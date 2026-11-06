# Go-live checklist

The live version of this checklist is in **Admin, Go-live checklist** (/admin/go-live). It re-checks the automatic items every time you open it and lets the team tick off the manual steps.

## Checked automatically

| Area | Check |
|---|---|
| Payments | OPay keys visible to the running site (`OPAY_MERCHANT_ID`, `OPAY_PUBLIC_KEY`, `OPAY_SECRET_KEY`, scope "Functions") |
| Payments | OPay in live mode (`OPAY_ENV=production`) |
| Payments | **OPay webhook received**: the site records every genuine notification to `/api/payments/opay/callback` and warns if one arrives with an invalid signature (wrong `OPAY_SECRET_KEY`) |
| Payments | Test payment page off (`PAYMENT_MOCK` not set) |
| Payments | Bank transfer details include an account number (or bank transfer is off) |
| Email | `SEND_EMAIL`, `SMTP_HOST`, `SMTP_USER`, `SMTP_PASS`, `FROM_EMAIL` set |
| Email | `ADMIN_EMAIL` and `SMTP_HELO_NAME` set |
| Email | Last order email delivered (shows the last error if sending failed) |
| Site & security | `NEXT_PUBLIC_SITE_URL` is a public HTTPS address |
| Site & security | `AUTH_SECRET` is strong and is **not** the one that was committed to GitHub |
| Site & security | `STORAGE_DRIVER=blobs` on Netlify |
| Site & security | At least one owner admin account |
| Content & marketing | Products live, every live product has a photo, showroom hours filled in |
| Content & marketing | Google Tag Manager ID set, seasonal campaign live |

## Manual steps (tick off in Admin, Go-live checklist)

**Payments**
- [ ] Set the OPay webhook URL in the OPay merchant dashboard: `https://<your-site>/api/payments/opay/callback`. The site also sends it with every payment; this is a backup.
- [ ] Switch to live OPay keys and `OPAY_ENV=production`, then redeploy.
- [ ] Make one real low-value payment on the live site. Check that the order shows **Paid**, the emails arrive, and Netlify, Logs, Functions shows `POST /api/payments/opay/callback` with status 200. Refund it afterwards.
- [ ] Fill in real bank transfer details, or switch bank transfer off.

**Database & security**
- [ ] cPanel, Remote MySQL: add `%` as an access host.
- [ ] Change the database password (it appeared in Netlify logs) and update `DB_PASSWORD`.
- [ ] Change admin passwords (the original test password was committed to GitHub).
- [ ] If the GitHub repository is public, decide whether to clean `.env.local` out of the history.
- [ ] Add an uptime monitor on `/api/health` (200 = healthy, 503 = database down).

**Content**
- [ ] Upload product images to Netlify Blobs: `npm run media:upload` from your own terminal.
- [ ] Run `db/fixes/2026-11-06-remove-em-dashes.sql` on the live database.
- [ ] Run `db/fixes/2026-11-06-add-vat.sql` on the live database **before** deploying the VAT update. Without these columns, product pages and checkout will error.
- [ ] Review VAT in Admin, Settings (7.5%) and tick **Price includes VAT** on any product whose price already contains VAT. Unticked products get VAT added at checkout.
- [ ] Run `db/fixes/2026-11-06-shipping-and-returns.sql` on the live database (adds the Shipping & Returns page and retires the old Delivery Information page).
- [ ] Check the measurements in Admin, Size guide against real garments, and the timelines and return rules in Admin, Info pages, Shipping & Returns.
- [ ] Run `db/fixes/2026-11-06-content-cleanup.sql` on the live database (removes the old OpenCart link, fixes "Wecis Clothings", the Terms naira symbol and the Privacy contact email).
- [ ] Cancel or delete test orders.

**Email**
- [ ] Set SPF and DKIM for wecisclothing.com (cPanel, Email Deliverability) so emails don't land in spam.
- [ ] Send a real test confirmation (paid order, **Resend confirmation email**) and check inbox and spam.

**Tracking**
- [ ] Configure GA4 and the Google Ads purchase conversion in GTM and test in Preview mode (see `docs/TRACKING.md`).

**Domain**
- [ ] Point wecisclothing.com to Netlify with HTTPS, then update `NEXT_PUBLIC_SITE_URL` and the OPay webhook URL.

## Local only (not part of go-live)

A crontab entry on the development Mac calls `POST http://localhost:3000/api/cron/service-status` every minute. That endpoint belongs to another project, so on this site it returns 404. It is harmless; remove it with `crontab -e` if it's no longer needed.
