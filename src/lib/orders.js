import "server-only";
import crypto from "node:crypto";
import { query, queryOne, transaction, parseJson } from "./db";
import { getProductsByIds, packagesAvailable } from "./catalog";
import { getSetting } from "./settings";
import { applyVat } from "./vat";
import { getComponents, pickRules, pickPrice, getPickPool } from "./bundles";
import { lineKey } from "./bundle-format";

export const DELIVERY_METHODS = {
  delivery_lagos: "Home delivery in Lagos",
  delivery_nationwide: "Home delivery outside Lagos",
  pickup_ikeja: "Pick up at Ikeja showroom",
  pickup_vi: "Pick up at Victoria Island showroom",
};

export const ORDER_STATUSES = ["pending", "processing", "ready", "shipped", "completed", "cancelled", "refunded"];
export const PAYMENT_STATUSES = ["unpaid", "pending", "paid", "failed"];

export function shippingFee(method, subtotal, shipping) {
  if (method.startsWith("pickup_")) return 0;
  const threshold = Number(shipping.free_delivery_threshold || 0);
  if (threshold > 0 && subtotal >= threshold) return 0;
  return Number(method === "delivery_lagos" ? shipping.delivery_lagos_fee : shipping.delivery_nationwide_fee) || 0;
}

/** Amount payable: shelf prices + VAT added on VAT-exclusive items + delivery. */
export function orderTotal({ subtotal, vat_added, fee }) {
  return Number(subtotal) + Number(vat_added || 0) + Number(fee || 0);
}

/**
 * Re-price cart lines against the database (including VAT). Client prices are never trusted.
 * A bundle package line carries `parts`: { [includedProductId]: size|null }, one per item.
 * @param {{productId:number, size?:string, quantity:number, parts?:object}[]} lines
 */
export async function priceCart(lines) {
  const clean = (Array.isArray(lines) ? lines : [])
    .map((l) => ({
      productId: Number(l.productId),
      size: l.size ? String(l.size).slice(0, 40) : null,
      quantity: Math.min(Math.max(parseInt(l.quantity, 10) || 0, 0), 20),
      parts: l.parts && typeof l.parts === "object" ? l.parts : null,
      picks: Array.isArray(l.picks)
        ? l.picks.slice(0, 10).map((x) => ({ productId: Number(x?.productId), size: x?.size ? String(x.size).slice(0, 40) : null }))
        : null,
    }))
    .filter((l) => l.productId > 0 && l.quantity > 0)
    .slice(0, 50);
  const products = await getProductsByIds([...new Set(clean.map((l) => l.productId))]);
  const byId = new Map(products.map((p) => [p.id, p]));
  const bundles = await getComponents(products.filter((p) => p.is_bundle).map((p) => p.id));
  const packagesOk = await packagesAvailable();
  // Pick-your-own bundles: each one's pool of outfits.
  const pools = new Map();
  for (const p of products) {
    const rules = p.is_pick_bundle ? pickRules(p) : null;
    if (rules) pools.set(p.id, new Map((await getPickPool(rules, { limit: 1000 })).map((o) => [o.id, o])));
  }
  const items = [];
  const problems = [];

  // Stock is checked across the whole cart: a product bought on its own and inside a
  // bundle draws on the same stock.
  const stock = new Map(); // productId -> { name, track, qty, need, forBundle }
  const demand = (p, qty, bundleName = null) => {
    const s = stock.get(p.id) || { name: p.name, track: Boolean(p.track_stock), qty: Number(p.stock_qty), need: 0, forBundle: null };
    s.need += qty;
    if (bundleName) s.forBundle = bundleName;
    stock.set(p.id, s);
  };

  for (const l of clean) {
    const p = byId.get(l.productId);
    if (!p || !p.is_active || (p.kind === "package" && !packagesOk)) {
      problems.push(`An item in your cart is no longer available.`);
      continue;
    }
    let components = null;
    let unitPrice = Number(p.price);
    if (p.is_pick_bundle) {
      const rules = pickRules(p);
      const picks = l.picks || [];
      const price = pickPrice(rules, picks.length);
      if (!price) {
        problems.push(`Please choose ${rules.min === rules.max ? rules.min : `${rules.min} to ${rules.max}`} outfits for ${p.name}.`);
        continue;
      }
      const pool = pools.get(p.id);
      const chosen = picks.map((x) => ({ outfit: pool.get(x.productId), size: x.size }));
      const bad = chosen.find(({ outfit, size }) => !outfit || (outfit.sizes.length ? !outfit.sizes.includes(size || "") : size));
      if (bad) {
        problems.push(bad.outfit ? `Please choose a size for ${bad.outfit.name} in ${p.name}.` : `One of your outfits is no longer available in ${p.name}.`);
        continue;
      }
      unitPrice = price;
      components = chosen.map(({ outfit, size }) => ({ product_id: outfit.id, name: outfit.name, sku: outfit.sku, size: size || null, image: outfit.image }));
      for (const { outfit } of chosen) demand(outfit, l.quantity, p.name);
    } else if (p.is_bundle) {
      const included = bundles.get(p.id) || [];
      const missing = included.find((c) => c.sizes.length && !c.sizes.includes(String(l.parts?.[c.id] ?? "")));
      if (!included.length || missing) {
        problems.push(`Please choose sizes for ${p.name}${missing ? ` (${missing.name})` : ""}.`);
        continue;
      }
      components = included.map((c) => ({
        product_id: c.id,
        name: c.name,
        sku: c.sku,
        size: c.sizes.length ? String(l.parts[c.id]) : null,
        image: c.image,
      }));
      for (const c of included) demand(c, l.quantity, p.name);
    } else if (p.sizes?.length && (!l.size || !p.sizes.includes(l.size))) {
      problems.push(`Please choose a size for ${p.name}.`);
      continue;
    }
    demand(p, l.quantity);
    items.push({
      product_id: p.id,
      name: p.name,
      sku: p.sku,
      slug: p.slug,
      kind: p.kind,
      size: components ? null : l.size,
      components,
      key: lineKey(p.id, components ? null : l.size, p.is_bundle ? l.parts : null, p.is_pick_bundle ? l.picks : null),
      image: p.image,
      unit_price: unitPrice,
      quantity: l.quantity,
      line_total: unitPrice * l.quantity,
      vat_inclusive: p.vat_inclusive,
    });
  }
  for (const s of stock.values()) {
    if (s.track && s.qty < s.need) {
      problems.push(s.qty > 0 ? `Only ${s.qty} of ${s.name} left in stock${s.forBundle ? ` (needed for ${s.forBundle})` : ""}.` : `${s.name} is out of stock${s.forBundle ? ` (needed for ${s.forBundle})` : ""}.`);
    }
  }
  const subtotal = items.reduce((s, i) => s + i.line_total, 0);
  const tax = await getSetting("tax");
  const vat = applyVat(items, tax);
  return {
    items: vat.items,
    subtotal,
    vat_rate: vat.rate,
    vat_label: tax.vat_label || "VAT",
    vat_added: vat.vat_added,
    vat_included: vat.vat_included,
    problems,
  };
}

function newOrderNumber() {
  const d = new Date();
  const ymd = `${String(d.getUTCFullYear()).slice(2)}${String(d.getUTCMonth() + 1).padStart(2, "0")}${String(d.getUTCDate()).padStart(2, "0")}`;
  return `WC${ymd}-${crypto.randomInt(1000, 9999)}${crypto.randomInt(10, 99)}`;
}

export async function createOrder({ customer, contact, delivery, items, subtotal, vat, fee, paymentMethod, utm }) {
  return transaction(async (tx) => {
    let orderNumber;
    for (let i = 0; i < 5; i++) {
      orderNumber = newOrderNumber();
      const exists = await tx.query("SELECT id FROM orders WHERE order_number = ?", [orderNumber]);
      if (!exists.length) break;
    }
    const total = orderTotal({ subtotal, vat_added: vat.vat_added, fee });
    const res = await tx.query(
      `INSERT INTO orders (order_number, customer_id, first_name, last_name, email, phone, delivery_method,
        address_line, city, state, notes, subtotal, vat_rate, vat_added, vat_included, shipping_fee, total, currency,
        payment_method, payment_status, utm)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 'NGN', ?, 'unpaid', ?)`,
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
        vat.vat_rate,
        vat.vat_added,
        vat.vat_included,
        fee,
        total,
        paymentMethod,
        utm ? JSON.stringify(utm) : null,
      ]
    );
    const orderId = res.insertId;
    for (const it of items) {
      await tx.query(
        `INSERT INTO order_items (order_id, product_id, name, sku, size, components, image, unit_price, quantity, line_total, vat_inclusive, vat_amount)
         VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
        [orderId, it.product_id, it.name, it.sku, it.size, it.components ? JSON.stringify(it.components) : null, it.image, it.unit_price, it.quantity, it.line_total, it.vat_inclusive, it.vat_amount]
      );
    }
    return { id: orderId, order_number: orderNumber, total };
  });
}

/** order_items rows with `components` parsed (bundle packages), [] for normal items. */
export const withComponents = (rows) => rows.map((r) => ({ ...r, components: parseJson(r.components, []) || [] }));

export async function getOrderByNumber(orderNumber) {
  const order = await queryOne("SELECT * FROM orders WHERE order_number = ?", [orderNumber]);
  if (!order) return null;
  order.items = withComponents(await query("SELECT * FROM order_items WHERE order_id = ? ORDER BY id", [order.id]));
  return order;
}

export async function getOrderById(id) {
  const order = await queryOne("SELECT * FROM orders WHERE id = ?", [id]);
  if (!order) return null;
  order.items = withComponents(await query("SELECT * FROM order_items WHERE order_id = ? ORDER BY id", [order.id]));
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
    const items = await tx.query("SELECT product_id, quantity, components FROM order_items WHERE order_id = ?", [orderId]);
    const decrement = (productId, qty) =>
      tx.query("UPDATE products SET stock_qty = GREATEST(stock_qty - ?, 0) WHERE id = ? AND track_stock = 1", [qty, productId]);
    for (const it of items) {
      if (it.product_id) await decrement(it.product_id, it.quantity);
      // Bundle packages: each included product leaves the shelf too.
      for (const c of parseJson(it.components, []) || []) {
        if (c?.product_id) await decrement(c.product_id, it.quantity);
      }
    }
    return true;
  });
}

/**
 * Atomically claim the right to emit the browser `purchase` event for an order.
 * Only the first caller gets true; this is what prevents duplicate conversions
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
