import "server-only";
import crypto from "node:crypto";

// Paystack hosted checkout (redirect): https://paystack.com/docs/payments/accept-payments/
// Only the secret key is used, server-side. Test or live mode comes from the key itself
// (sk_test_... / sk_live_...).
const BASE = "https://api.paystack.co";

// Trim values: keys pasted into dashboards often pick up stray spaces/newlines.
const env = (name) => (process.env[name] || "").trim();
const secretKey = () => env("PAYSTACK_SECRET_KEY");

export const PAYSTACK_REQUIRED_VARS = ["PAYSTACK_SECRET_KEY"];

/** Names (never values) of required Paystack variables missing at runtime. */
export function paystackMissingVars() {
  return PAYSTACK_REQUIRED_VARS.filter((n) => !env(n));
}

export function paystackConfigured() {
  return paystackMissingVars().length === 0;
}

/** "live" for sk_live_ keys, otherwise "test". */
export function paystackMode() {
  return secretKey().startsWith("sk_live_") ? "live" : "test";
}

async function call(path, init = {}) {
  const res = await fetch(`${BASE}${path}`, {
    ...init,
    headers: { Authorization: `Bearer ${secretKey()}`, "Content-Type": "application/json", ...init.headers },
    cache: "no-store",
  });
  const json = await res.json().catch(() => ({}));
  if (!res.ok || json.status !== true) throw new Error(`Paystack ${path.split("/")[2] || path} failed: ${res.status} ${json.message || ""}`.trim());
  return json;
}

/**
 * Start a hosted checkout. Amounts are sent in kobo.
 * Returns { authorizationUrl, accessCode, raw }.
 */
export async function initializeTransaction({ reference, amountNaira, email, callbackUrl, cancelUrl, metadata = {} }) {
  const json = await call("/transaction/initialize", {
    method: "POST",
    body: JSON.stringify({
      reference,
      email,
      amount: Math.round(Number(amountNaira) * 100),
      currency: "NGN",
      callback_url: callbackUrl,
      // cancel_action: where Paystack's "Cancel payment" button sends the shopper.
      metadata: { ...metadata, cancel_action: cancelUrl },
    }),
  });
  return { authorizationUrl: json.data.authorization_url, accessCode: json.data.access_code, raw: json };
}

// Paystack transaction status -> our payment status vocabulary (same as OPay's).
const STATUS = { success: "SUCCESS", failed: "FAIL", reversed: "FAIL", abandoned: "CLOSE" };

/** Server-to-server check. Returns { status, amountNaira, currency, raw }. */
export async function verifyTransaction(reference) {
  const json = await call(`/transaction/verify/${encodeURIComponent(reference)}`);
  const d = json.data || {};
  return {
    status: STATUS[d.status] || "PENDING",
    amountNaira: d.amount != null ? Number(d.amount) / 100 : null,
    currency: d.currency,
    raw: json,
  };
}

/** Check the x-paystack-signature header: HMAC-SHA512 of the raw body with the secret key. */
export function verifyWebhookSignature(rawBody, signature) {
  if (!signature || !secretKey()) return false;
  const expected = crypto.createHmac("sha512", secretKey()).update(rawBody).digest("hex");
  const given = String(signature).toLowerCase();
  return expected.length === given.length && crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(given));
}
