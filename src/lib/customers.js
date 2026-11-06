import "server-only";
import { query, queryOne, transaction } from "./db";
import { signToken, verifyToken } from "./auth";
import { sendMail } from "./email";
import { verifyEmailEmail } from "./email-templates";
import { getSetting } from "./settings";

const VERIFY_TTL = 60 * 60 * 24 * 3; // 3 days
export const MAX_ADDRESSES = 10;

function siteUrl() {
  return (process.env.NEXT_PUBLIC_SITE_URL || "http://localhost:3000").replace(/\/$/, "");
}

// ---------- Email confirmation and guest orders ----------

/**
 * Attach guest orders placed with this customer's email to their account.
 * Only for confirmed emails: otherwise anyone could register with someone else's
 * address and see their orders. (Order emails already go to that address, so
 * the person who owns the inbox is the one who should see them.)
 */
export async function linkGuestOrders(customer) {
  if (!customer?.email_verified_at) return 0;
  const res = await query("UPDATE orders SET customer_id = ? WHERE customer_id IS NULL AND email = ?", [customer.id, customer.email]);
  return res.affectedRows || 0;
}

/** Confirmed account for this email, if any (used to attach new guest orders). */
export async function verifiedCustomerByEmail(email) {
  return queryOne("SELECT id FROM customers WHERE email = ? AND email_verified_at IS NOT NULL AND is_active = 1", [String(email).trim().toLowerCase()]);
}

export async function verificationUrl(customer) {
  const token = await signToken({ kind: "verify-email", sub: String(customer.id), email: customer.email }, VERIFY_TTL);
  return `${siteUrl()}/account/verify?token=${encodeURIComponent(token)}`;
}

export async function sendVerificationEmail(customer) {
  const url = await verificationUrl(customer);
  const store = await getSetting("store");
  const res = await sendMail({ to: customer.email, ...verifyEmailEmail({ customer, url, store, siteUrl: siteUrl() }) });
  if (!res.ok) {
    console.error("Verification email failed:", res.error);
    if (process.env.NODE_ENV !== "production") console.log("Verification link (dev):", url);
  }
  return res;
}

/** Confirms the email in a verification token and links earlier guest orders. Returns the customer or null. */
export async function confirmEmailToken(token) {
  const payload = await verifyToken(token);
  if (payload?.kind !== "verify-email") return null;
  const customer = await queryOne("SELECT id, email, email_verified_at FROM customers WHERE id = ? AND is_active = 1", [payload.sub]);
  // The link is only valid for the email it was sent to.
  if (!customer || customer.email !== payload.email) return null;
  if (!customer.email_verified_at) {
    await query("UPDATE customers SET email_verified_at = UTC_TIMESTAMP() WHERE id = ?", [customer.id]);
    customer.email_verified_at = new Date();
  }
  customer.linked = await linkGuestOrders(customer);
  return customer;
}

// ---------- Saved addresses ----------

export async function getAddresses(customerId) {
  return query("SELECT * FROM customer_addresses WHERE customer_id = ? ORDER BY is_default DESC, id DESC", [customerId]);
}

/** Insert or update one address; the first address (or one marked default) becomes the default. */
export async function saveAddress(customerId, addr, id = 0) {
  return transaction(async (tx) => {
    if (id) {
      const own = await tx.query("SELECT id FROM customer_addresses WHERE id = ? AND customer_id = ?", [id, customerId]);
      if (!own.length) return { error: "Address not found" };
    } else {
      const [{ n }] = await tx.query("SELECT COUNT(*) n FROM customer_addresses WHERE customer_id = ?", [customerId]);
      if (n >= MAX_ADDRESSES) return { error: `You can save up to ${MAX_ADDRESSES} addresses. Delete one to add another.` };
      if (n === 0) addr.is_default = 1;
    }
    if (addr.is_default) await tx.query("UPDATE customer_addresses SET is_default = 0 WHERE customer_id = ?", [customerId]);
    const vals = [addr.label || null, addr.address_line, addr.city, addr.state, addr.phone || null, addr.is_default ? 1 : 0];
    if (id) {
      await tx.query("UPDATE customer_addresses SET label=?, address_line=?, city=?, state=?, phone=?, is_default=GREATEST(is_default, ?) WHERE id = ? AND customer_id = ?", [...vals, id, customerId]);
      return { id };
    }
    const res = await tx.query("INSERT INTO customer_addresses (label, address_line, city, state, phone, is_default, customer_id) VALUES (?,?,?,?,?,?,?)", [...vals, customerId]);
    return { id: res.insertId };
  });
}

export async function deleteAddress(customerId, id) {
  return transaction(async (tx) => {
    const rows = await tx.query("SELECT is_default FROM customer_addresses WHERE id = ? AND customer_id = ?", [id, customerId]);
    if (!rows.length) return;
    await tx.query("DELETE FROM customer_addresses WHERE id = ? AND customer_id = ?", [id, customerId]);
    if (rows[0].is_default) {
      // Promote the most recent remaining address.
      await tx.query("UPDATE customer_addresses SET is_default = 1 WHERE customer_id = ? ORDER BY id DESC LIMIT 1", [customerId]);
    }
  });
}

export async function setDefaultAddress(customerId, id) {
  await transaction(async (tx) => {
    const own = await tx.query("SELECT id FROM customer_addresses WHERE id = ? AND customer_id = ?", [id, customerId]);
    if (!own.length) return;
    await tx.query("UPDATE customer_addresses SET is_default = (id = ?) WHERE customer_id = ?", [id, customerId]);
  });
}

/** Saves a checkout address unless the customer already has the same one. */
export async function rememberAddress(customerId, addr) {
  const same = await queryOne(
    "SELECT id FROM customer_addresses WHERE customer_id = ? AND address_line = ? AND city = ? AND state = ?",
    [customerId, addr.address_line, addr.city, addr.state]
  );
  if (same) return { id: same.id };
  return saveAddress(customerId, { ...addr, is_default: 0 });
}
