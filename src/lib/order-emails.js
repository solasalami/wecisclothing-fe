import "server-only";
import { after } from "next/server";
import { getOrderById, orderAccessToken } from "./orders";
import { getSettings } from "./settings";
import { getShowrooms } from "./catalog";
import { sendMail } from "./email";
import { orderConfirmationEmail, adminNewOrderEmail } from "./email-templates";
import { recordEmailResult } from "./golive";

function siteUrl() {
  return (process.env.NEXT_PUBLIC_SITE_URL || process.env.URL || "http://localhost:3000").replace(/\/$/, "");
}

/** Build both order emails (also used by the admin preview). */
export async function buildOrderEmails(orderId) {
  const order = await getOrderById(orderId);
  if (!order) return null;
  const [{ store }, showrooms] = await Promise.all([getSettings(), getShowrooms()]);
  const base = siteUrl();
  const viewUrl = `${base}/checkout/success/${order.order_number}?t=${orderAccessToken(order.order_number)}`;
  return {
    order,
    customer: orderConfirmationEmail({ order, store, showrooms, siteUrl: base, viewUrl }),
    admin: adminNewOrderEmail({ order, store, siteUrl: base, adminUrl: `${base}/admin/orders/${order.id}` }),
    replyTo: store.email,
  };
}

/** Send the customer confirmation (and optionally the store notification). Never throws. */
export async function sendOrderPaidEmails(orderId, { customer = true, admin = true } = {}) {
  try {
    const built = await buildOrderEmails(orderId);
    if (!built) return { ok: false, error: "Order not found" };
    const results = {};
    if (customer) {
      results.customer = await sendMail({ to: built.order.email, replyTo: built.replyTo, ...built.customer });
    }
    const adminTo = (process.env.ADMIN_EMAIL || "").trim();
    if (admin && adminTo) {
      results.admin = await sendMail({ to: adminTo, replyTo: built.order.email, ...built.admin });
    }
    for (const [who, r] of Object.entries(results)) {
      await recordEmailResult(r.ok, r.error); // shown on the go-live checklist
      if (r.ok) console.log(`[email] ${who} email for ${built.order.order_number} sent (${r.id})`);
      else console.error(`[email] ${who} email for ${built.order.order_number} failed: ${r.error}`);
    }
    return { ok: Object.values(results).every((r) => r.ok), results };
  } catch (err) {
    console.error("[email] order email error", err?.message || err);
    return { ok: false, error: err?.message || String(err) };
  }
}

/**
 * Called once when an order becomes paid. Sends after the response is finished so
 * checkout isn't slowed by the mail server; falls back to sending inline.
 */
export async function queueOrderPaidEmails(orderId) {
  try {
    after(() => sendOrderPaidEmails(orderId));
  } catch {
    await sendOrderPaidEmails(orderId); // outside a request (e.g. scripts)
  }
}
