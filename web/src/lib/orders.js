import "server-only";
import crypto from "node:crypto";
import { query, queryOne, transaction } from "./db";
import { getProductsByIds, packagesAvailable } from "./catalog";

export const DELIVERY_METHODS = {
  delivery_lagos: "Home delivery — Lagos",
  delivery_nationwide: "Home delivery — Outside Lagos",
  pickup_ikeja: "Pick up — Ikeja showroom",
  pickup_vi: "Pick up — Victoria Island showroom",
};

export const ORDER_STATUSES = ["pending", "processing", "ready", "shipped", "completed", "cancelled", "refunded"];
export const PAYMENT_STATUSES = ["unpaid", "pending", "paid", "failed"];

export function shippingFee(method, subtotal, shipping) {
  if (method.startsWith("pickup_")) return 0;
  const threshold = Number(shipping.free_delivery_threshold || 0);
  if (threshold > 0 && subtotal >= threshold) return 0;
  return Number(method === "delivery_lagos" ? shipping.delivery_lagos_fee : shipping.delivery_nationwide_fee) || 0;
}

/**
 * Re-price cart lines against the database. Client prices are never trusted.
 * @param {{productId:number, size?:string, quantity:number}[]} lines
 */
export async function priceCart(lines) {
  const clean = (Array.isArray(lines) ? lines : [])
    .map((l) => ({
      productId: Number(l.productId),
      size: l.size ? String(l.size).slice(0, 40) : null,
      quantity: Math.min(Math.max(parseInt(l.quantity, 10) || 0, 0), 20),
    }))
    .filter((l) => l.productId > 0 && l.quantity > 0)
    .slice(0, 50);
  const products = await getProductsByIds([...new Set(clean.map((l) => l.productId))]);
  const byId = new Map(products.map((p) => [p.id, p]));
  const packagesOk = await packagesAvailable();
  const items = [];
  const problems = [];
  for (const l of clean) {
    const p = byId.get(l.productId);
    if (!p || !p.is_active || (p.kind === "package" && !packagesOk)) {
      problems.push(`An item in your cart is no longer available.`);
      continue;
    }
    if (p.sizes?.length && (!l.size || !p.sizes.includes(l.size))) {
      problems.push(`Please choose a size for ${p.name}.`);
      continue;
    }
    if (p.track_stock && p.stock_qty < l.quantity) {
      problems.push(`Only ${p.stock_qty} of ${p.name} left in stock.`);
      continue;
    }
    items.push({
      product_id: p.id,
      name: p.name,
      sku: p.sku,
      slug: p.slug,
      kind: p.kind,
      size: l.size,
      image: p.image,
      unit_price: Number(p.price),
      quantity: l.quantity,
      line_total: Number(p.price) * l.quantity,
    });
  }
  const subtotal = items.reduce((s, i) => s + i.line_total, 0);
  return { items, subtotal, problems };
}

function newOrderNumber() {
  const d = new Date();
  const ymd = `${String(d.getUTCFullYear()).slice(2)}${String(d.getUTCMonth() + 1).padStart(2, "0")}${String(d.getUTCDate()).padStart(2, "0")}`;
  return `WC${ymd}-${crypto.randomInt(1000, 9999)}${crypto.randomInt(10, 99)}`;
}

export async function createOrder({ customer, contact, delivery, items, subtotal, fee, paymentMethod, utm }) {
  return transaction(async (tx) => {
    let orderNumber;
    for (let i = 0; i < 5; i++) {
      orderNumber = newOrderNumber();
      const exists = await tx.query("SELECT id FROM orders WHERE order_number = ?", [orderNumber]);
      if (!exists.length) break;
    }
    const total = subtotal + fee;
    const res = await tx.query(
      `INSERT INTO orders (order_number, customer_id, first_name, last_name, email, phone, delivery_method,
        address_line, city, state, notes, subtotal, shipping_fee, total, currency, payment_method, payment_status, utm)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?, 'NGN', ?, 'unpaid', ?)`,
      [
        orderNumber,
        customer?.id ?? null,
        contact.first_name,
        contact.last_name,
        contact.email,
        contact.phone,
        delivery.method,
        delivery.address_line || null,
        delivery.city || null,
        delivery.state || null,
        contact.notes || null,
        subtotal,
        fee,
        total,
        paymentMethod,
        utm ? JSON.stringify(utm) : null,
      ]
    );
    const orderId = res.insertId;
    for (const it of items) {
      await tx.query(
        `INSERT INTO order_items (order_id, product_id, name, sku, size, image, unit_price, quantity, line_total)
         VALUES (?,?,?,?,?,?,?,?,?)`,
        [orderId, it.product_id, it.name, it.sku, it.size, it.image, it.unit_price, it.quantity, it.line_total]
      );
    }
    return { id: orderId, order_number: orderNumber, total };
  });
}

export async function getOrderByNumber(orderNumber) {
  const order = await queryOne("SELECT * FROM orders WHERE order_number = ?", [orderNumber]);
  if (!order) return null;
  order.items = await query("SELECT * FROM order_items WHERE order_id = ? ORDER BY id", [order.id]);
  return order;
}

export async function getOrderById(id) {
  const order = await queryOne("SELECT * FROM orders WHERE id = ?", [id]);
  if (!order) return null;
  order.items = await query("SELECT * FROM order_items WHERE order_id = ? ORDER BY id", [order.id]);
  order.payments = await query("SELECT * FROM payments WHERE order_id = ? ORDER BY id DESC", [order.id]);
  return order;
}

/**
 * Idempotently mark an order paid and decrement stock exactly once.
 * Returns true only for the call that actually flipped the order to paid.
 */
export async function markOrderPaid(orderId, reference) {
  return transaction(async (tx) => {
    const res = await tx.query(
      `UPDATE orders SET payment_status = 'paid', paid_at = UTC_TIMESTAMP(), payment_reference = COALESCE(?, payment_reference),
         status = IF(status = 'pending', 'processing', status)
       WHERE id = ? AND payment_status <> 'paid'`,
      [reference, orderId]
    );
    if (res.affectedRows !== 1) return false;
    const items = await tx.query("SELECT product_id, quantity FROM order_items WHERE order_id = ?", [orderId]);
    for (const it of items) {
      if (!it.product_id) continue;
      await tx.query(
        "UPDATE products SET stock_qty = GREATEST(stock_qty - ?, 0) WHERE id = ? AND track_stock = 1",
        [it.quantity, it.product_id]
      );
    }
    return true;
  });
}

/**
 * Atomically claim the right to emit the browser `purchase` event for an order.
 * Only the first caller gets true — this is what prevents duplicate conversions
 * when the thank-you page is refreshed, bookmarked or revisited.
 */
export async function claimPurchaseTracking(orderId) {
  const res = await query(
    "UPDATE orders SET purchase_tracked_at = UTC_TIMESTAMP() WHERE id = ? AND payment_status = 'paid' AND purchase_tracked_at IS NULL",
    [orderId]
  );
  return res.affectedRows === 1;
}

/** Unguessable token that lets a shopper view their own order without logging in. */
export function orderAccessToken(orderNumber) {
  return crypto.createHmac("sha256", process.env.AUTH_SECRET || "").update(`order:${orderNumber}`).digest("hex").slice(0, 32);
}

export function checkOrderAccessToken(orderNumber, token) {
  const expected = orderAccessToken(orderNumber);
  return typeof token === "string" && token.length === expected.length && crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(token));
}
