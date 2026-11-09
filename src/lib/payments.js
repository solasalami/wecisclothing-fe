import "server-only";
import crypto from "node:crypto";
import { query, queryOne } from "./db";
import { markOrderPaid } from "./orders";
import { queueOrderPaidEmails } from "./order-emails";
import { createCashierPayment, queryPaymentStatus, opayConfigured } from "./opay";
import { initializeTransaction, verifyTransaction, paystackConfigured } from "./paystack";

export function siteUrl() {
  return (process.env.URL || process.env.NEXT_PUBLIC_SITE_URL || "http://localhost:3000").replace(/\/$/, "");
}

export function mockPaymentsEnabled() {
  return process.env.PAYMENT_MOCK === "true" && process.env.CONTEXT !== "production";
}

/** Checkout payment methods that go through an online gateway. */
export const ONLINE_METHODS = ["paystack", "opay"];
export const PROVIDER_NAMES = { paystack: "Paystack", opay: "OPay", mock: "the test gateway" };

const providerConfigured = (method) => (method === "paystack" ? paystackConfigured() : method === "opay" ? opayConfigured() : false);

/** Can this online method take payments right now (real keys, or the dev mock)? */
export function onlinePaymentAvailable(method) {
  return providerConfigured(method) || mockPaymentsEnabled();
}

/** Create a payment attempt for an order and return the URL to send the shopper to. */
export async function startOnlinePayment(order) {
  const reference = `${order.order_number}-${crypto.randomBytes(3).toString("hex")}`;
  const provider = providerConfigured(order.payment_method) ? order.payment_method : "mock";
  if (provider === "mock" && !mockPaymentsEnabled()) throw new Error(`${order.payment_method} is not configured`);
  await query("INSERT INTO payments (order_id, provider, reference, amount, status) VALUES (?,?,?,?, 'INITIAL')", [
    order.id,
    provider,
    reference,
    order.total,
  ]);
  await query("UPDATE orders SET payment_status = 'pending', payment_reference = ? WHERE id = ?", [reference, order.id]);

  const base = siteUrl();
  const returnUrl = `${base}/checkout/return?ref=${encodeURIComponent(reference)}`;

  if (provider === "mock") return `${base}/checkout/mock-pay?ref=${encodeURIComponent(reference)}`;

  if (provider === "paystack") {
    const { authorizationUrl, accessCode, raw } = await initializeTransaction({
      reference,
      amountNaira: order.total,
      email: order.email,
      callbackUrl: returnUrl,
      cancelUrl: `${returnUrl}&cancelled=1`,
      metadata: {
        order_number: order.order_number,
        custom_fields: [
          { display_name: "Order", variable_name: "order_number", value: order.order_number },
          { display_name: "Customer", variable_name: "customer", value: `${order.first_name} ${order.last_name}`.trim() },
          { display_name: "Items", variable_name: "items", value: order.items.map((i) => `${i.quantity} x ${i.name}`).join(", ").slice(0, 250) },
        ],
      },
    });
    await query("UPDATE payments SET provider_order_no = ?, raw = ? WHERE reference = ?", [accessCode, JSON.stringify(raw), reference]);
    return authorizationUrl;
  }

  const { cashierUrl, orderNo, raw } = await createCashierPayment({
    reference,
    amountNaira: order.total,
    returnUrl,
    cancelUrl: `${returnUrl}&cancelled=1`,
    callbackUrl: `${base}/api/payments/opay/callback`,
    customer: order,
    items: order.items,
  });
  await query("UPDATE payments SET provider_order_no = ?, raw = ? WHERE reference = ?", [orderNo, JSON.stringify(raw), reference]);
  return cashierUrl;
}

/**
 * Confirm a payment by asking the gateway directly (never trust redirects or
 * callback bodies alone). Safe to call many times.
 * Returns { order, status } where status is SUCCESS | PENDING | FAIL | CLOSE | INITIAL.
 */
export async function confirmPayment(reference, { mockStatus } = {}) {
  const payment = await queryOne("SELECT * FROM payments WHERE reference = ?", [reference]);
  if (!payment) return { order: null, status: "NOT_FOUND" };
  const order = await queryOne("SELECT * FROM orders WHERE id = ?", [payment.order_id]);

  if (order.payment_status === "paid") return { order, status: "SUCCESS" };

  let status = payment.status;
  let raw = null;
  if (payment.provider === "mock") {
    if (!mockPaymentsEnabled()) return { order, status: "FAIL" };
    status = mockStatus || payment.status;
  } else {
    try {
      const res = payment.provider === "paystack" ? await verifyTransaction(reference) : await queryPaymentStatus(reference);
      raw = res.raw;
      status = res.status;
      // Guard against amount tampering.
      if (status === "SUCCESS" && (res.currency !== "NGN" || Math.round(res.amountNaira * 100) !== Math.round(Number(payment.amount) * 100))) {
        console.error(`${PROVIDER_NAMES[payment.provider] || payment.provider} amount mismatch`, reference, res.currency, res.amountNaira, payment.amount);
        status = "FAIL";
      }
    } catch (err) {
      console.error(err);
      return { order, status: "PENDING" };
    }
  }

  await query("UPDATE payments SET status = ?, raw = COALESCE(?, raw) WHERE id = ?", [status, raw ? JSON.stringify(raw) : null, payment.id]);

  if (status === "SUCCESS") {
    // markOrderPaid returns true only for the call that flips the order to paid,
    // so confirmation emails go out exactly once even if the gateway notifies us repeatedly.
    if (await markOrderPaid(order.id, reference)) await queueOrderPaidEmails(order.id);
  } else if (status === "FAIL" || status === "CLOSE") {
    await query("UPDATE orders SET payment_status = 'failed' WHERE id = ? AND payment_status <> 'paid'", [order.id]);
  }
  const fresh = await queryOne("SELECT * FROM orders WHERE id = ?", [order.id]);
  return { order: fresh, status };
}
