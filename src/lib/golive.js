import "server-only";
import crypto from "node:crypto";
import { query, queryOne, parseJson } from "./db";
import { opayConfigured, opayMissingVars, opayMode } from "./opay";
import { emailEnabled, emailMissingVars } from "./email";
import { campaignStatus } from "./campaign";

// SHA-256 fingerprints of secrets known to have been exposed (e.g. committed to git).
// Only hashes are stored here, never the secrets themselves.
const EXPOSED_AUTH_SECRET_HASHES = new Set(["73ffc102c10fa4a3e2a703ad71253cb331b913a69d05bdfdbd582c68c9e17871"]);

const env = (n) => (process.env[n] || "").trim();
const siteUrl = () => (env("NEXT_PUBLIC_SITE_URL") || env("URL") || "http://localhost:3000").replace(/\/$/, "");

async function readSetting(key) {
  const row = await queryOne("SELECT value FROM settings WHERE `key` = ?", [key]);
  return parseJson(row?.value, {}) || {};
}

/** Record OPay webhook activity (called by the callback route). Never throws. */
export async function recordWebhook(kind, info = {}) {
  try {
    const current = await readSetting("opay_webhook");
    const at = new Date().toISOString();
    const next = kind === "valid" ? { ...current, last_valid_at: at, last_reference: info.reference, last_status: info.status } : { ...current, last_invalid_at: at };
    await query("INSERT INTO settings (`key`, value) VALUES ('opay_webhook', ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", [JSON.stringify(next)]);
  } catch {
    /* monitoring only */
  }
}

/** Record the outcome of an order email (called by order-emails). Never throws. */
export async function recordEmailResult(ok, error) {
  try {
    const current = await readSetting("email_status");
    const at = new Date().toISOString();
    const next = ok ? { ...current, last_ok_at: at } : { ...current, last_error_at: at, last_error: String(error || "").slice(0, 300) };
    await query("INSERT INTO settings (`key`, value) VALUES ('email_status', ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", [JSON.stringify(next)]);
  } catch {
    /* monitoring only */
  }
}

const fmt = (iso) =>
  iso ? new Date(iso).toLocaleString("en-NG", { dateStyle: "medium", timeStyle: "short", timeZone: "Africa/Lagos" }) : "";

/** Manual steps the site can't verify itself (ticked off in the dashboard). */
export function manualSteps() {
  const site = siteUrl();
  return [
    { id: "opay-dashboard-webhook", group: "Payments", label: "Set the OPay webhook URL in the OPay merchant dashboard", help: `${site}/api/payments/opay/callback (the site also sends this with every payment; this is a backup).` },
    { id: "opay-live-keys", group: "Payments", label: "Switch to live OPay keys", help: "In Netlify: live OPAY_MERCHANT_ID / OPAY_PUBLIC_KEY / OPAY_SECRET_KEY, OPAY_ENV=production, then redeploy." },
    { id: "opay-live-test", group: "Payments", label: "Make one real low-value payment on the live site", help: "Check: order shows Paid, emails arrive, and Netlify logs show POST /api/payments/opay/callback 200. Refund it afterwards." },
    { id: "bank-details", group: "Payments", label: "Fill in real bank transfer details", help: "Admin, Settings, Payments (or switch bank transfer off)." },
    { id: "remote-mysql", group: "Database & security", label: "Allow remote MySQL connections for Netlify", help: "cPanel, Remote MySQL: add % as an access host." },
    { id: "db-password", group: "Database & security", label: "Change the database password and update DB_PASSWORD in Netlify", help: "The old one appeared in Netlify logs." },
    { id: "admin-password", group: "Database & security", label: "Change admin passwords", help: "The original test admin password was committed to GitHub. Admin, My password." },
    { id: "git-history", group: "Database & security", label: "Decide on cleaning .env.local out of the GitHub history", help: "Only needed if the repository is public." },
    { id: "uptime-monitor", group: "Database & security", label: "Add an uptime monitor on /api/health", help: `${site}/api/health returns 200 when healthy and 503 when the database is down.` },
    { id: "media-upload", group: "Content", label: "Upload product images to Netlify Blobs", help: "Run npm run media:upload from your own terminal." },
    { id: "em-dash-fix", group: "Content", label: "Run the em dash clean-up on the live database", help: "db/fixes/2026-11-06-remove-em-dashes.sql in phpMyAdmin." },
    { id: "test-orders", group: "Content", label: "Cancel or delete test orders", help: "Admin, Orders." },
    { id: "email-dns", group: "Email", label: "Set SPF and DKIM for wecisclothing.com", help: "So order emails don't land in spam. cPanel, Email Deliverability." },
    { id: "email-test", group: "Email", label: "Send a real test confirmation", help: "Open a paid order, Resend confirmation email, and check the inbox and spam folder." },
    { id: "ga4-ads", group: "Tracking", label: "Configure GA4 and the Google Ads purchase conversion in GTM", help: "Follow docs/TRACKING.md and test in GTM Preview: one purchase per order, currency NGN." },
    { id: "domain", group: "Domain", label: "Point wecisclothing.com to Netlify with HTTPS", help: "Then update NEXT_PUBLIC_SITE_URL and the OPay webhook URL to the new domain." },
  ];
}

/** Automatic checks, evaluated live on every dashboard view. */
export async function automaticChecks(settings) {
  const [webhook, emailStatus, [counts]] = await Promise.all([
    readSetting("opay_webhook"),
    readSetting("email_status"),
    query(`SELECT
        (SELECT COUNT(*) FROM products WHERE is_active = 1) AS live_products,
        (SELECT COUNT(*) FROM products p WHERE p.is_active = 1 AND NOT EXISTS (SELECT 1 FROM product_images i WHERE i.product_id = p.id)) AS no_photo,
        (SELECT COUNT(*) FROM showrooms WHERE is_active = 1 AND (hours IS NULL OR hours = '')) AS showrooms_no_hours,
        (SELECT COUNT(*) FROM admin_users WHERE role = 'owner' AND is_active = 1) AS owners`),
  ]);
  const site = siteUrl();
  const onNetlify = Boolean(process.env.NETLIFY || process.env.AWS_LAMBDA_FUNCTION_NAME);
  const secret = env("AUTH_SECRET");
  const secretExposed = EXPOSED_AUTH_SECRET_HASHES.has(crypto.createHash("sha256").update(secret).digest("hex"));
  const bankDetails = settings.payments.bank_transfer_details || "";
  const status = campaignStatus(settings.campaign);
  const lastValid = webhook.last_valid_at ? new Date(webhook.last_valid_at) : null;
  const lastInvalid = webhook.last_invalid_at ? new Date(webhook.last_invalid_at) : null;

  return [
    {
      group: "Payments",
      items: [
        {
          ok: opayConfigured() && settings.payments.opay_enabled,
          label: opayConfigured() ? `OPay connected (${opayMode()} mode)` : "OPay keys configured",
          help: !opayConfigured()
            ? `Not visible to the running site: ${opayMissingVars().join(", ")}. In Netlify, Environment variables: add them with scope "Functions" (or All scopes), then redeploy.`
            : "OPay is switched off in Settings, Payments, so checkout won't offer it.",
        },
        {
          ok: opayMode() === "production",
          label: "OPay in live (production) mode",
          help: "Sandbox mode: only test payments. Switch to live keys and OPAY_ENV=production when you're ready to take real payments.",
        },
        {
          ok: Boolean(lastValid) && !(lastInvalid && lastInvalid > lastValid),
          label: lastValid ? `OPay webhook received (last: ${fmt(webhook.last_valid_at)})` : "OPay webhook received",
          help:
            lastInvalid && (!lastValid || lastInvalid > lastValid)
              ? `A notification arrived on ${fmt(webhook.last_invalid_at)} with an invalid signature: check OPAY_SECRET_KEY matches the keys in use.`
              : `None yet. Make a payment on the live site; OPay notifies ${site}/api/payments/opay/callback (it can't reach localhost).`,
        },
        { ok: env("PAYMENT_MOCK") !== "true", label: "Test payment page switched off", help: "Remove PAYMENT_MOCK from the environment variables." },
        {
          ok: !settings.payments.bank_transfer_enabled || /\d{10}/.test(bankDetails),
          label: "Bank transfer details complete",
          help: "Add a 10-digit account number in Settings, Payments, or switch bank transfer off.",
        },
      ],
    },
    {
      group: "Email",
      items: [
        { ok: emailEnabled(), label: "Order emails switched on", help: `Missing: ${emailMissingVars().join(", ")}.` },
        { ok: Boolean(env("ADMIN_EMAIL")), label: "Store notification address set", help: "Set ADMIN_EMAIL (e.g. info@wecisclothing.com)." },
        { ok: Boolean(env("SMTP_HELO_NAME")), label: "SMTP greeting name set", help: "Set SMTP_HELO_NAME=wecisclothing.com." },
        {
          ok: Boolean(emailStatus.last_ok_at) && !(emailStatus.last_error_at && emailStatus.last_error_at > emailStatus.last_ok_at),
          label: emailStatus.last_ok_at ? `Order emails delivering (last sent: ${fmt(emailStatus.last_ok_at)})` : "Order emails delivering",
          help: emailStatus.last_error_at
            ? `Last failure ${fmt(emailStatus.last_error_at)}: ${emailStatus.last_error}`
            : "No order email sent yet. Use Resend confirmation email on a paid order to test.",
        },
      ],
    },
    {
      group: "Site & security",
      items: [
        { ok: /^https:\/\//.test(site) && !/localhost|127\.0\.0\.1/.test(site), label: `Site address is public HTTPS (${site})`, help: "Set NEXT_PUBLIC_SITE_URL to your live address (used in emails and payment links)." },
        {
          ok: secret.length >= 32 && !secretExposed,
          label: "AUTH_SECRET is private and strong",
          help: secretExposed
            ? "This AUTH_SECRET was committed to GitHub. Generate a new one (openssl rand -base64 48), set it in Netlify and redeploy."
            : "Use a random string of at least 32 characters.",
        },
        { ok: !onNetlify || env("STORAGE_DRIVER") === "blobs", label: "Images stored in Netlify Blobs", help: "Set STORAGE_DRIVER=blobs on Netlify." },
        { ok: counts.owners > 0, label: "At least one owner admin account", help: "Create one with npm run admin:sql." },
      ],
    },
    {
      group: "Content & marketing",
      items: [
        { ok: counts.live_products > 0, label: `${counts.live_products} products live`, help: "Publish products in Admin, Products." },
        { ok: counts.no_photo === 0, label: "Every live product has a photo", help: `${counts.no_photo} live product(s) without photos.` },
        { ok: counts.showrooms_no_hours === 0, label: "Showroom opening hours filled in", help: "Admin, Showrooms." },
        { ok: Boolean(settings.tracking.gtm_id), label: "Google Tag Manager installed", help: "Add your GTM container ID in Settings." },
        { ok: status === "live", label: `${settings.campaign.name} campaign live`, help: `Status: ${status}. Manage it under Seasonal campaign.` },
      ],
    },
  ];
}

export async function getManualProgress() {
  return readSetting("golive");
}

export async function setManualStep(id, done, by) {
  const current = await readSetting("golive");
  if (done) current[id] = { done_at: new Date().toISOString(), by };
  else delete current[id];
  await query("INSERT INTO settings (`key`, value) VALUES ('golive', ?) ON DUPLICATE KEY UPDATE value = VALUES(value)", [JSON.stringify(current)]);
}

export { fmt as formatChecklistDate };
