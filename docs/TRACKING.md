# Google Tag Manager, GA4 & Google Ads setup

**Current state (checked 5 Nov 2026).** The live OpenCart site has **no** GTM, GA4 or Google Ads tags installed. The new site already pushes every event below to `window.dataLayer`. Nothing reaches Google until a GTM container ID is added.

## 1. Create the accounts
1. **Google Tag Manager** (tagmanager.google.com). Create a container for `wecisclothing.com` (Web) and copy the ID (`GTM-XXXXXXX`).
2. **GA4** (analytics.google.com). Create a property with time zone **Africa/Lagos** and currency **NGN**, add a Web data stream, and copy the Measurement ID (`G-XXXXXXX`).
3. **Google Ads.** In Goals → Conversions → New → Website → *Set up manually*, create a **Purchase** conversion:
   - Value: "Use different values for each conversion", default currency NGN
   - Count: **One**
   - Copy the **Conversion ID** (`AW-…`) and **Conversion label**
4. Enter the GTM ID in **Admin → Settings → Tracking** (or the `NEXT_PUBLIC_GTM_ID` environment variable).

## 2. Data layer events emitted by the site

| Event | When | Key fields |
|---|---|---|
| `view_item` | Product page | `ecommerce.items[]`, `value`, `currency: NGN` |
| `add_to_cart` | "Add to bag" | `ecommerce.items[]` (with `item_variant` = size), `value` |
| `remove_from_cart` / `view_cart` | Bag | same |
| `begin_checkout` | Checkout page loads (once) | `ecommerce.items[]`, `value` |
| `add_shipping_info` / `add_payment_info` | Order submitted | `shipping_tier`, `payment_type` |
| **`purchase`** | Order confirmation page, **only after payment is verified** | `ecommerce.transaction_id` (order number), `value` (total), `shipping`, `currency: "NGN"`, `items[]`; `user_data.email`, `user_data.phone_number` |
| `whatsapp_click` | Any WhatsApp link | `link_location` (floating_button, header, product_page, …), `page_path` |
| `phone_click` | Any `tel:` link | `link_location`, `phone_number` |

**How duplicate purchases are prevented:**
1. The server sets `orders.purchase_tracked_at` atomically. Only the first render of a paid order's confirmation page gets the purchase payload, so refreshes, bookmarks and the back button don't re-fire it.
2. A localStorage guard per order number.
3. `transaction_id` is sent, and both GA4 and Google Ads de-duplicate on it.

Bank-transfer orders aren't counted as browser conversions, because payment is confirmed later by staff. Import them as offline conversions if needed.

## 3. GTM configuration

**Variables** (Data Layer Variable, version 2):
`DLV - ecommerce.transaction_id`, `DLV - ecommerce.value`, `DLV - ecommerce.currency`, `DLV - link_location`, `DLV - user_data.email`, `DLV - user_data.phone_number`

**Triggers** (Custom Event):
`CE - purchase`, `CE - add_to_cart`, `CE - begin_checkout`, `CE - view_item`, `CE - whatsapp_click`, `CE - phone_click`
(or a single regex trigger: `^(view_item|add_to_cart|remove_from_cart|view_cart|begin_checkout|add_shipping_info|add_payment_info|purchase)$`)

**Tags:**
| Tag | Type | Trigger |
|---|---|---|
| Google Tag | Google tag, ID `G-XXXXXXX` | Initialization – All Pages |
| GA4 – ecommerce | GA4 Event, event name `{{Event}}`, ✔ *Send Ecommerce data* (Data Layer) | the ecommerce regex trigger |
| GA4 – whatsapp_click | GA4 Event `whatsapp_click`, param `link_location` | CE - whatsapp_click |
| GA4 – phone_click | GA4 Event `phone_click`, param `link_location` | CE - phone_click |
| Conversion Linker | Conversion Linker | All Pages |
| Google Ads – Purchase | Google Ads Conversion Tracking: Conversion ID/label, Value `{{DLV - ecommerce.value}}`, Transaction ID `{{DLV - ecommerce.transaction_id}}`, Currency `{{DLV - ecommerce.currency}}`. Optionally enable *Include user-provided data* using the `user_data` variables (Enhanced Conversions) | CE - purchase |
| Google Ads – WhatsApp/Call clicks (optional secondary conversions) | Google Ads Conversion Tracking | CE - whatsapp_click / CE - phone_click |
| Google Ads Remarketing (optional) | Google Ads Remarketing | All Pages |

## 4. Link GA4 ↔ Google Ads
GA4 → Admin → Product links → **Google Ads links** → Link. Enable auto-tagging in Google Ads (Account settings → Auto-tagging). In GA4, mark `purchase` as a **key event**. Use the Google Ads tag (above) as the *primary* purchase conversion, and import the GA4 purchase only as *secondary*, so the same sale isn't counted twice.

The site also stores `gclid` / `utm_*` from the landing URL on each order, visible in Admin → Order → *Marketing attribution*.

## 5. Testing checklist
1. GTM **Preview** mode → open the site.
2. Product → `view_item`. Add to bag → `add_to_cart` with size and value. Checkout → `begin_checkout`.
3. Pay. Use OPay sandbox keys, or `PAYMENT_MOCK=true` locally → confirmation page shows **one** `purchase` with `transaction_id`, `value`, `currency = NGN`.
4. **Refresh** the confirmation page. There should be **no** second `purchase`.
5. Click the floating WhatsApp button and the phone number, and check that `whatsapp_click` / `phone_click` fire with the right `link_location`.
6. In GA4 **DebugView**, confirm the events. In Google Ads → Conversions → *Troubleshoot*, check the tag status, which updates within about 24h.
