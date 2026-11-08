import "server-only";
import nodemailer from "nodemailer";

// SMTP settings (all from environment variables):
//   SEND_EMAIL=true, SMTP_HOST, SMTP_PORT (587 = STARTTLS, 465 = SSL), SMTP_USER, SMTP_PASS,
//   FROM_EMAIL="Wecis Clothing Sales <sales@wecisclothing.com>", ADMIN_EMAIL (store notifications)
//   SMTP_HELO_NAME (optional) = host name announced in the SMTP greeting (HELO/EHLO), e.g. wecisclothing.com
//   SMTP_TLS_REJECT_UNAUTHORIZED=false only if the mail server's certificate doesn't match its host name.
const env = (n) => (process.env[n] || "").trim();

export function emailEnabled() {
  return env("SEND_EMAIL") === "true" && Boolean(env("SMTP_HOST") && env("SMTP_USER") && env("SMTP_PASS"));
}

export function emailMissingVars() {
  return ["SEND_EMAIL", "SMTP_HOST", "SMTP_USER", "SMTP_PASS", "FROM_EMAIL"].filter((n) => (n === "SEND_EMAIL" ? env(n) !== "true" : !env(n)));
}

let transporter;
function getTransporter() {
  if (transporter) return transporter;
  const port = Number(env("SMTP_PORT")) || 587;
  transporter = nodemailer.createTransport({
    host: env("SMTP_HOST"),
    port,
    // Name sent in HELO/EHLO. Defaults to this machine's host name, which some mail
    // servers reject or score as spam on serverless platforms; set it to your domain.
    name: env("SMTP_HELO_NAME").replace(/[<>\s]/g, "") || undefined,
    secure: port === 465, // 465 = implicit TLS; 587 upgrades with STARTTLS
    requireTLS: port === 587,
    auth: { user: env("SMTP_USER"), pass: process.env.SMTP_PASS }, // password untrimmed on purpose
    connectionTimeout: 10_000,
    greetingTimeout: 10_000,
    socketTimeout: 20_000,
    tls: { rejectUnauthorized: env("SMTP_TLS_REJECT_UNAUTHORIZED") !== "false" },
  });
  return transporter;
}

/** Send one email. Returns { ok, id } or { ok: false, error }; never throws. */
export async function sendMail({ to, bcc, subject, html, text, replyTo }) {
  if (!emailEnabled()) return { ok: false, error: `Email disabled or not configured (${emailMissingVars().join(", ") || "check SMTP settings"})` };
  try {
    const info = await getTransporter().sendMail({
      from: env("FROM_EMAIL") || env("SMTP_USER"),
      to,
      bcc: bcc || undefined,
      subject,
      html,
      text,
      replyTo: replyTo || undefined,
    });
    return { ok: true, id: info.messageId };
  } catch (err) {
    transporter = null; // rebuild the connection next time
    return { ok: false, error: `${err.code || "SMTP_ERROR"}: ${err.message}` };
  }
}
