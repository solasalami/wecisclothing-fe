import "server-only";
import { query, queryOne } from "./db";
import { createChallenge as createCaptcha, checkHuman as checkCaptcha } from "./captcha";
import { sendMail } from "./email";
import { esc, contactReplyEmail } from "./email-templates";

// Contact form protection: the shared spam check in ./captcha.js (question, honeypot,
// timing; each question works once because its nonce is stored UNIQUE with the message),
// plus at most RATE_LIMIT messages per hour from one connection, and few links.

export const TOPICS = ["Order enquiry", "Custom / made-to-measure", "Sizing help", "Delivery or returns", "Festive packages", "Something else"];
const RATE_LIMIT = 5;
const MAX_LINKS = 2;

/** A fresh question for the contact form: { question, token }. */
export const createChallenge = () => createCaptcha("contact");

/** Checks the captcha, honeypot and timing. Returns { nonce } or { error }. */
export const checkHuman = (input) => checkCaptcha("contact", input);

export function countLinks(text) {
  return (String(text).match(/https?:\/\/|www\./gi) || []).length;
}
export const LINK_LIMIT = MAX_LINKS;

export async function tooManyFrom(ip) {
  if (!ip) return false;
  const [{ n }] = await query("SELECT COUNT(*) n FROM contact_messages WHERE ip = ? AND created_at > UTC_TIMESTAMP() - INTERVAL 1 HOUR", [ip]);
  return Number(n) >= RATE_LIMIT;
}

/** Saves the message. Returns false if this question was already used (replay). */
export async function saveMessage(m) {
  try {
    await query(
      "INSERT INTO contact_messages (name, email, phone, topic, message, ip, user_agent, nonce) VALUES (?,?,?,?,?,?,?,?)",
      [m.name, m.email, m.phone || null, m.topic, m.message, m.ip || null, (m.userAgent || "").slice(0, 255) || null, m.nonce]
    );
    return true;
  } catch (err) {
    if (err?.code === "ER_DUP_ENTRY") return false;
    throw err;
  }
}

/** Emails the store; replying goes straight to the customer. Never throws. */
export async function notifyStore(m, store) {
  const to = storeMailbox(store);
  if (!to) return { ok: false, error: "No ADMIN_EMAIL or store email set" };
  const base = (process.env.NEXT_PUBLIC_SITE_URL || "").replace(/\/$/, "");
  const subject = `Website message: ${m.topic} from ${m.name}`;
  const text = `New message from the website contact form

Name: ${m.name}
Email: ${m.email}
Phone: ${m.phone || "-"}
Topic: ${m.topic}

${m.message}

Reply to this email to answer ${m.name} directly.
All messages: ${base}/admin/messages`;
  const html = `<div style="font:15px/1.6 Helvetica,Arial,sans-serif;color:#262626;max-width:600px">
<p style="margin:0 0 12px;font-size:12px;letter-spacing:2px;text-transform:uppercase;color:#9c7a12">New website message</p>
<p style="margin:0"><strong>${esc(m.name)}</strong><br><a href="mailto:${esc(m.email)}">${esc(m.email)}</a>${m.phone ? ` &middot; ${esc(m.phone)}` : ""}<br>Topic: ${esc(m.topic)}</p>
<p style="margin:16px 0;padding:14px;background:#f6efd9;white-space:pre-wrap">${esc(m.message)}</p>
<p style="margin:0;font-size:13px;color:#6b6b6b">Reply to this email to answer ${esc(m.name)} directly. <a href="${esc(base)}/admin/messages">All messages</a></p>
</div>`;
  return sendMail({ to, subject, text, html, replyTo: m.email });
}

/** The store mailbox that receives contact messages and copies of replies. */
export const storeMailbox = (store) => (process.env.ADMIN_EMAIL || "").trim() || store?.email || "";

/**
 * Emails an admin's reply to the customer, Bcc'ing the store mailbox so the
 * conversation is kept there too, then records it. Returns { ok } or { error }.
 */
export async function sendReply({ messageId, body, admin, store }) {
  const message = await queryOne("SELECT id, name, email, topic, message, created_at FROM contact_messages WHERE id = ?", [messageId]);
  if (!message) return { error: "That message no longer exists." };
  const mailbox = storeMailbox(store);
  const siteUrl = (process.env.NEXT_PUBLIC_SITE_URL || process.env.URL || "http://localhost:3000").replace(/\/$/, "");
  const email = contactReplyEmail({ message, reply: body, store, siteUrl });
  const sent = await sendMail({
    to: message.email,
    bcc: mailbox && mailbox.toLowerCase() !== message.email.toLowerCase() ? mailbox : undefined,
    replyTo: mailbox || undefined,
    ...email,
  });
  if (!sent.ok) return { error: `The reply was not sent: ${sent.error}` };
  await query("INSERT INTO contact_replies (message_id, body, sent_by, sent_to, copied_to) VALUES (?,?,?,?,?)", [
    message.id, body, admin?.name || null, message.email, mailbox || null,
  ]);
  await query("UPDATE contact_messages SET read_at = COALESCE(read_at, UTC_TIMESTAMP()) WHERE id = ?", [message.id]);
  return { ok: true, sentTo: message.email, copiedTo: mailbox };
}
