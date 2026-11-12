import "server-only";
import { query, queryOne } from "./db";
import { sendMail } from "./email";
import { customerMessageEmail } from "./email-templates";
import { storeMailbox } from "./contact";
import { getAddresses } from "./customers";

// Admin, Customers: one customer's profile (registered account and/or guest orders,
// matched by email), emails to them, and disabling an account.

const siteUrl = () => (process.env.NEXT_PUBLIC_SITE_URL || process.env.URL || "http://localhost:3000").replace(/\/$/, "");
export const normaliseEmail = (e) => String(e || "").trim().toLowerCase();
export const customerPath = (email) => `/admin/customers/${encodeURIComponent(normaliseEmail(email))}`;

/** Everything shown on the customer page, or null if nobody has used this email. */
export async function getCustomerProfile(rawEmail) {
  const email = normaliseEmail(rawEmail);
  if (!email) return null;
  const [account, orders, emails] = await Promise.all([
    queryOne(
      "SELECT id, first_name, last_name, email, phone, email_verified_at, is_active, created_at FROM customers WHERE email = ?",
      [email]
    ),
    query(
      `SELECT id, order_number, first_name, last_name, phone, total, status, payment_status, payment_method, created_at
       FROM orders WHERE email = ? ORDER BY id DESC LIMIT 100`,
      [email]
    ),
    query("SELECT id, subject, body, sent_by, copied_to, created_at FROM customer_emails WHERE email = ? ORDER BY id DESC LIMIT 50", [email]).catch(() => []),
  ]);
  if (!account && !orders.length) return null;
  const latest = orders[0];
  const paid = orders.filter((o) => o.payment_status === "paid");
  return {
    email,
    account,
    name: account ? `${account.first_name} ${account.last_name}` : `${latest.first_name} ${latest.last_name}`,
    firstName: account?.first_name || latest?.first_name || "",
    phone: account?.phone || orders.find((o) => o.phone)?.phone || "",
    // Other numbers used at checkout, if different from the main one.
    otherPhones: [...new Set(orders.map((o) => o.phone).filter(Boolean))].filter((p) => p !== (account?.phone || orders.find((o) => o.phone)?.phone)),
    addresses: account ? await getAddresses(account.id) : [],
    orders,
    orderCount: orders.length,
    paidTotal: paid.reduce((sum, o) => sum + Number(o.total), 0),
    firstOrder: orders.at(-1)?.created_at || null,
    emails,
  };
}

/** Sends a message to the customer (Bcc the store mailbox) and keeps a copy in the history. */
export async function sendCustomerEmail({ email, subject, message, admin, store }) {
  const profile = await getCustomerProfile(email);
  if (!profile) return { error: "That customer no longer exists." };
  const mailbox = storeMailbox(store);
  const sent = await sendMail({
    to: profile.email,
    bcc: mailbox && mailbox.toLowerCase() !== profile.email ? mailbox : undefined,
    replyTo: mailbox || undefined,
    ...customerMessageEmail({ name: profile.firstName || profile.name, subject, message, store, siteUrl: siteUrl() }),
  });
  if (!sent.ok) return { error: `The email was not sent: ${sent.error}` };
  await query("INSERT INTO customer_emails (email, subject, body, sent_by, copied_to) VALUES (?,?,?,?,?)", [
    profile.email, subject, message, admin?.name || null, mailbox || null,
  ]);
  return { ok: true, sentTo: profile.email, copiedTo: mailbox };
}

/**
 * Disable or re-enable a registered account. Disabled: can't sign in (and is signed out
 * everywhere), can't reset the password, and can't order with this email, even as a guest.
 */
export async function setCustomerActive(email, active) {
  const res = await query(
    // Raising session_version ends existing sessions, so re-enabling doesn't revive old ones.
    "UPDATE customers SET is_active = ?, session_version = session_version + IF(? = 0, 1, 0) WHERE email = ?",
    [active ? 1 : 0, active ? 1 : 0, normaliseEmail(email)]
  );
  return res.affectedRows > 0;
}

/** True when this email belongs to an account an admin has disabled. */
export async function isDisabledEmail(email) {
  return Boolean(await queryOne("SELECT id FROM customers WHERE email = ? AND is_active = 0", [normaliseEmail(email)]));
}
