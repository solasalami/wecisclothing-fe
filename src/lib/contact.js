import "server-only";
import crypto from "node:crypto";
import { query, queryOne } from "./db";
import { signToken, verifyToken } from "./auth";
import { sendMail } from "./email";
import { esc, contactReplyEmail } from "./email-templates";

// Contact form protection, all self-hosted (no third-party captcha or keys):
//  1. a short arithmetic question; the answer is never sent to the browser, only a
//     signed hash of it, so it can't be read from the page or forged;
//  2. a hidden "website" field that people never see but form-filling bots do;
//  3. timing: a person needs more than a few seconds, and stale pages expire;
//  4. each question works once (nonce stored with the message);
//  5. at most RATE_LIMIT messages per hour from one connection, and few links.
// This stops ordinary spam bots. A determined AI browser agent can still solve a
// sum; if that becomes a problem, add Cloudflare Turnstile (free) on top.

export const TOPICS = ["Order enquiry", "Custom / made-to-measure", "Sizing help", "Delivery or returns", "Festive packages", "Something else"];
const MIN_SECONDS = 3;
const MAX_AGE = 2 * 60 * 60; // 2 hours
const RATE_LIMIT = 5;
const MAX_LINKS = 2;

const hashAnswer = (nonce, answer) =>
  crypto.createHash("sha256").update(`contact:${nonce}:${String(answer).trim()}:${process.env.AUTH_SECRET || ""}`).digest("hex");

/** A fresh question for the form: { question, token }. */
export async function createChallenge() {
  const plus = crypto.randomInt(0, 2) === 1;
  let a = crypto.randomInt(2, 10);
  let b = crypto.randomInt(1, 10);
  if (!plus && b > a) [a, b] = [b, a];
  const answer = plus ? a + b : a - b;
  const nonce = crypto.randomBytes(16).toString("hex");
  const token = await signToken({ kind: "contact", n: nonce, h: hashAnswer(nonce, answer) }, MAX_AGE);
  return { question: `What is ${a} ${plus ? "+" : "−"} ${b}?`, token };
}

/** Checks the captcha, honeypot and timing. Returns { nonce } or { error }. */
export async function checkHuman({ token, answer, website }) {
  if (website) return { error: "spam" }; // hidden field filled in: a bot
  const payload = await verifyToken(token);
  if (payload?.kind !== "contact") return { error: "This form has expired. Please answer the new question and send again." };
  const age = Date.now() / 1000 - (payload.iat || 0);
  if (age < MIN_SECONDS) return { error: "spam" };
  const given = String(answer ?? "").replace(/[^\d-]/g, "");
  if (!given || hashAnswer(payload.n, given) !== payload.h) return { error: "That answer isn't right. Please try the new question." };
  return { nonce: payload.n };
}

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
