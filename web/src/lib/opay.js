import "server-only";
import crypto from "node:crypto";

// OPay Express Checkout (Cashier) — https://doc.opaycheckout.com/cashier-create.html
const BASE = {
  sandbox: "https://sandboxapi.opaycheckout.com",
  production: "https://api.opaycheckout.com",
};

function cfg() {
  const env = process.env.OPAY_ENV === "production" ? "production" : "sandbox";
  return {
    base: BASE[env],
    merchantId: process.env.OPAY_MERCHANT_ID,
    publicKey: process.env.OPAY_PUBLIC_KEY,
    secretKey: process.env.OPAY_SECRET_KEY,
  };
}

export function opayConfigured() {
  const c = cfg();
  return Boolean(c.merchantId && c.publicKey && c.secretKey);
}

function sortKeys(value) {
  if (Array.isArray(value)) return value.map(sortKeys);
  if (value && typeof value === "object") {
    return Object.keys(value)
      .sort()
      .reduce((o, k) => ((o[k] = sortKeys(value[k])), o), {});
  }
  return value;
}

/** HMAC-SHA512 of the key-sorted JSON body, signed with the secret key. */
export function signBody(body, secretKey = cfg().secretKey) {
  return crypto.createHmac("sha512", secretKey).update(JSON.stringify(sortKeys(body))).digest("hex");
}

const isOk = (code) => code === "00000" || code === "00";

/**
 * Create a cashier payment and return { cashierUrl, orderNo, raw }.
 * Amounts are sent in kobo (minor units).
 */
export async function createCashierPayment({ reference, amountNaira, returnUrl, callbackUrl, cancelUrl, customer, items }) {
  const c = cfg();
  const body = {
    country: "NG",
    reference,
    amount: { total: Math.round(Number(amountNaira) * 100), currency: "NGN" },
    returnUrl,
    callbackUrl,
    cancelUrl,
    expireAt: 30,
    userInfo: {
      userEmail: customer.email,
      userMobile: customer.phone,
      userName: `${customer.first_name} ${customer.last_name}`.trim(),
    },
    product: {
      name: "Wecis Clothing order",
      description: items.map((i) => `${i.quantity} x ${i.name}`).join(", ").slice(0, 250),
    },
  };
  const res = await fetch(`${c.base}/api/v1/international/cashier/create`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${c.publicKey}`,
      MerchantId: c.merchantId,
    },
    body: JSON.stringify(body),
    cache: "no-store",
  });
  const json = await res.json().catch(() => ({}));
  if (!isOk(json.code) || !json.data?.cashierUrl) {
    throw new Error(`OPay create failed: ${json.code || res.status} ${json.message || ""}`.trim());
  }
  return { cashierUrl: json.data.cashierUrl, orderNo: json.data.orderNo, raw: json };
}

/** Server-to-server status query. Returns { status, amountNaira, currency, orderNo, raw }. */
export async function queryPaymentStatus(reference) {
  const c = cfg();
  const body = { country: "NG", reference };
  const res = await fetch(`${c.base}/api/v1/international/cashier/status`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${signBody(body, c.secretKey)}`,
      MerchantId: c.merchantId,
    },
    body: JSON.stringify(body),
    cache: "no-store",
  });
  const json = await res.json().catch(() => ({}));
  if (!isOk(json.code)) throw new Error(`OPay status failed: ${json.code || res.status} ${json.message || ""}`.trim());
  const d = json.data || {};
  return {
    status: d.status,
    amountNaira: d.amount ? Number(d.amount.total) / 100 : null,
    currency: d.amount?.currency,
    orderNo: d.orderNo,
    raw: json,
  };
}

/** Verify the `sha512` field of an OPay transaction-status callback (HMAC-SHA3-512). */
export function verifyCallbackSignature(callback) {
  const p = callback?.payload;
  if (!p || !callback.sha512) return false;
  const str =
    `{Amount:"${p.amount}",Currency:"${p.currency}",Reference:"${p.reference}",` +
    `Refunded:${p.refunded ? "t" : "f"},Status:"${p.status}",Timestamp:"${p.timestamp}",` +
    `Token:"${p.token ?? ""}",TransactionID:"${p.transactionId ?? ""}"}`;
  const expected = crypto.createHmac("sha3-512", cfg().secretKey || "").update(str).digest("hex");
  const given = String(callback.sha512).toLowerCase();
  return expected.length === given.length && crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(given));
}
