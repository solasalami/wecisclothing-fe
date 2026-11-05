# Wecis Clothing — Next.js storefront & admin

A replacement for the OpenCart 3 site at wecisclothing.com. It's built with **Next.js 16 (App Router, plain JavaScript)**, **MySQL 8**, **Tailwind CSS 4** and **Netlify** (hosting, with Netlify Blobs for image storage). Payments go through **OPay**, and analytics through **Google Tag Manager → GA4 / Google Ads**.

## What's included

| Area | Details |
|---|---|
| Storefront | Home (banner slider, Men/Women, Detty December, featured), category pages (nested), product pages (gallery, sizes, WhatsApp enquiry, JSON-LD), search, bag drawer, checkout, order confirmation, customer accounts, info pages, contact/showrooms, sitemap and robots |
| Seasonal campaign | A reusable campaign (currently **Detty December** at `/detty-december`). It has a landing page with hero, countdown, packages and a WhatsApp/call/showroom section, plus a menu item, an announcement bar and a homepage section. Name, URL, all wording, hero image and **start/end dates** are set in **Admin → Seasonal campaign**. It turns on and off on schedule, old URLs redirect, admins can preview it before launch, and packages can be hidden and stop selling outside the campaign |
| Admin (`/admin`) | Dashboard and launch checklist, orders (status, mark bank transfers as paid), products and packages (photo upload, reorder, sizes, stock), categories, customers, home banners, showrooms, info pages, settings (contact, delivery fees, payments, GTM), admin users (owner/staff) |
| Payments | OPay Cashier redirect. Payment is **verified server-side** (status API and signed callback) and amounts are checked against the order. Optional bank transfer. A dev-only mock gateway lets you test without OPay keys |
| Tracking | GA4 ecommerce events in `dataLayer`: `view_item`, `add_to_cart`, `remove_from_cart`, `view_cart`, `begin_checkout`, `add_shipping_info`, `add_payment_info`, `purchase` (once per order), plus `whatsapp_click` and `phone_click`. See [docs/TRACKING.md](docs/TRACKING.md) |
| Contact | Floating WhatsApp button on every page, a call/WhatsApp top bar, and Ikeja and Victoria Island showrooms in the footer, on the contact page and on the Detty December page |

## Local development

```bash
# 1. MySQL 8 (Docker)
docker run -d --name wecis-mysql -e MYSQL_ROOT_PASSWORD=wecis_root -e MYSQL_DATABASE=wecis \
  -e MYSQL_USER=wecis -e MYSQL_PASSWORD=wecis_dev -p 3307:3306 mysql:8.4

# 2. env
cp .env.example .env.local      # then set AUTH_SECRET (openssl rand -base64 48)

# 3. install, create tables, import the OpenCart catalogue, create an admin
npm install
npm run db:migrate
npm run db:import                # reads ../localhost.sql and ../wecisclothing/image
npm run admin:create -- "Your Name" you@wecisclothing.com 'a-strong-password' owner

npm run dev
```

With `PAYMENT_MOCK=true` (dev only) checkout sends you to a **simulated OPay page**, where you can choose a successful or failed payment.

## Deploying to Netlify

1. **MySQL hosting.** Netlify doesn't host MySQL, so use a managed MySQL 8 that's reachable over the internet, for example **Aiven for MySQL**, **TiDB Cloud Serverless**, **DigitalOcean Managed MySQL**, or your current cPanel host with Remote MySQL enabled. Most of these need `DATABASE_SSL=true`.
2. Push this `web/` folder to a Git repo and create a Netlify site from it. Netlify detects Next.js automatically, and `netlify.toml` is included.
3. In **Site configuration → Environment variables** set:
   - `DATABASE_URL`, `DATABASE_SSL`
   - `AUTH_SECRET` (long random string)
   - `NEXT_PUBLIC_SITE_URL=https://wecisclothing.com`
   - `STORAGE_DRIVER=blobs`
   - `OPAY_ENV`, `OPAY_MERCHANT_ID`, `OPAY_PUBLIC_KEY`, `OPAY_SECRET_KEY` (once the OPay account is approved)
   - `NEXT_PUBLIC_GTM_ID` (optional; it can also be set in Admin → Settings)
   - Do **not** set `PAYMENT_MOCK` in production. It's ignored on production deploys anyway.
4. Run the migration and import against the production DB from your machine. Images go into Netlify Blobs:
   ```bash
   DATABASE_URL=... DATABASE_SSL=true STORAGE_DRIVER=blobs \
   NETLIFY_SITE_ID=<site id> NETLIFY_AUTH_TOKEN=<personal access token> \
   npm run db:migrate && npm run db:import && npm run admin:create -- "Owner" owner@wecisclothing.com '...'
   ```
5. In the OPay merchant dashboard, set the webhook/callback URL to `https://wecisclothing.com/api/payments/opay/callback`.
6. Point the wecisclothing.com DNS at Netlify once you're happy with the preview URL.

## After import: things to review in Admin

- **3 hidden products** named "Untitled … style #NN". These were theme demo names on real photos. Rename them and make them visible, or delete them.
- **Sub-categories.** OpenCart's product-to-category links were theme demo data, so products were imported into **Men** or **Women** only, based on their photo folder. Assign sub-categories (Agbada, Kaftan, Bubu…) in each product. Sub-categories stay hidden from the menu until they contain products.
- **Sizes** default to S–XXL, and stock tracking is off (made to order). Adjust per product.
- **Showroom opening hours** and **bank transfer details** (Settings) are blank.
- **Delivery fees** default to ₦5,000 in Lagos and ₦10,000 outside Lagos.
- **Seasonal campaign.** Admin → Seasonal campaign. Check the dates and wording, then **+ New package**. For a new season, unpublish the old packages and change the name, URL, wording and dates.

## Database outages & health check

If MySQL can't be reached (down, wrong credentials, too many connections, timeouts), visitors are redirected to **`/maintenance`**. It's a branded page that never touches the database:
- **Responses:** it answers **HTTP 503 + `Retry-After`**, so search engines treat the outage as temporary.
- **Ordering:** it offers WhatsApp/phone ordering and the showroom addresses.
- **Recovery:** it checks **`/api/health`** every 20s and sends the visitor back to the page they were on once the database is back.
- **Behind the scenes** (`src/lib/db.js`): a 5s connect timeout, a 6s query cap and a short circuit breaker stop pages from hanging. Outages are logged at most once every 30s as `[db] Database unavailable`.
- **Payment webhooks:** the OPay callback answers **503** instead of redirecting, so OPay retries and no payment confirmation is lost.

Point an uptime monitor (e.g. UptimeRobot or Better Stack) at `https://wecisclothing.com/api/health`. It returns 200 when healthy and 503 when the database is down.

## Project layout

```
db/schema.sql                 clean MySQL schema (12 tables instead of 136 oc_* tables)
scripts/                      migrate, OpenCart import, create-admin
src/app/(shop)/               storefront routes
src/app/admin/                admin (proxy-protected, every action re-checks the session)
src/app/api/payments/opay/    OPay callback
src/lib/                      db, auth, catalog, orders, payments, opay, storage, settings, analytics
src/proxy.js                  optimistic /admin gate (Next 16 "proxy" = old middleware)
```
