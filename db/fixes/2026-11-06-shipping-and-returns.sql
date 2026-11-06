-- Shipping and returns policy page (Nigeria). Safe to run more than once.
-- Run in phpMyAdmin: select the database, open SQL, paste, Go.
-- Afterwards the page can be edited in Admin, Info pages.
SET NAMES utf8mb4;

INSERT INTO pages (slug, title, body, meta_description, is_active, sort_order)
VALUES ('shipping-and-returns', 'Shipping & Returns', '<p>We want you to love what you ordered. This page explains how we deliver across Nigeria, how showroom pick-up works, and what to do if something isn''t right.</p>

<h2>Order processing</h2>
<ul>
<li><strong>Ready-to-wear:</strong> dispatched or ready for pick-up within 1 to 2 working days after your payment is confirmed.</li>
<li><strong>Custom (made to measure):</strong> usually 7 to 14 working days, depending on the style. We will confirm a date on WhatsApp once we have your measurements.</li>
<li><strong>Bank transfer orders</strong> are processed once the money reaches our account. Send your receipt on WhatsApp to speed this up.</li>
<li>Working days are Monday to Friday, excluding Nigerian public holidays.</li>
<li><strong>Festive season:</strong> December is our busiest month. Order early, especially custom pieces and festive packages, to receive them before Christmas and New Year.</li>
</ul>

<h2>Delivery within Nigeria</h2>
<table>
<thead><tr><th>Where</th><th>Delivery time after dispatch</th></tr></thead>
<tbody>
<tr><td>Lagos</td><td>1 to 3 working days</td></tr>
<tr><td>Other states, including Abuja (FCT)</td><td>3 to 7 working days</td></tr>
</tbody>
</table>
<ul>
<li>The delivery fee for your location is shown at checkout before you pay. When free delivery is on offer, the minimum order value is shown at checkout too.</li>
<li>Our dispatch rider or courier will call the phone number on your order. Please keep it switched on and make sure someone can receive the parcel.</li>
<li>If a delivery fails because we can''t reach you or the address is wrong, a second delivery may attract an extra fee.</li>
<li>Some remote areas and periods of disruption (for example heavy rain, road closures or public holidays) can add a few days. We will keep you updated on WhatsApp.</li>
<li>Please check your parcel on arrival and tell us within 48 hours if anything is damaged or missing.</li>
</ul>

<h2>Free showroom pick-up</h2>
<p>Choose pick-up at checkout and collect from either showroom at no cost:</p>
<ul>
<li><strong>Ikeja:</strong> 3 Adeniyi Jones Avenue, Ikeja, Lagos</li>
<li><strong>Victoria Island:</strong> 49 Adeola Odeku Street, Victoria Island, Lagos</li>
</ul>
<p>We will message you on WhatsApp when your order is ready. Bring your order number. If someone is collecting for you, send us their name and phone number in advance. You can also try your items on and have small adjustments discussed with our team.</p>

<h2>Delivery outside Nigeria</h2>
<p>We can send orders abroad by international courier. Message us on WhatsApp before ordering for a delivery quote and timeline. Customs duties and import taxes in the destination country are paid by the customer.</p>

<h2>Returns and exchanges</h2>
<p>You can return or exchange items within <strong>30 days</strong> of delivery or collection, as long as they are:</p>
<ul>
<li>unworn, unwashed and not altered,</li>
<li>in their original condition with tags and packaging.</li>
</ul>
<p>An <strong>exchange</strong> for a different size or item is the quickest option, especially in the festive season.</p>
<p>These items can''t be returned unless they are faulty:</p>
<ul>
<li>custom and made-to-measure pieces, and items altered at your request,</li>
<li>caps, fila, gele and other headwear, for hygiene reasons,</li>
<li>items from festive packages that were personalised for you.</li>
</ul>
<p>Items bought on sale or with a promo code can be exchanged, or refunded as store credit.</p>

<h2>How to return or exchange</h2>
<ol>
<li>Message us on WhatsApp or email within 30 days with your order number, the item, the reason and a photo.</li>
<li>We will reply within 1 to 2 working days with instructions. Please don''t send anything back before we confirm.</li>
<li>Drop the item at our Ikeja or Victoria Island showroom (free), or send it to us by courier. Courier costs for returns are paid by the customer, unless the item was faulty or we sent the wrong one.</li>
</ol>

<h2>Faulty or wrong items</h2>
<p>If your item is faulty, damaged or not what you ordered, tell us within 48 hours of delivery with photos. We will collect it at our cost and send a replacement or give you a full refund, including the delivery fee.</p>

<h2>Refunds</h2>
<ul>
<li>Once we receive and inspect your return, we will confirm your refund on WhatsApp or email.</li>
<li>Refunds go back to the original payment method: OPay and card payments through OPay, and bank transfers to the account that made the payment.</li>
<li>Refunds are processed within 14 working days of approval. Your bank may take a few extra days to show the money.</li>
<li>The refund includes the VAT you paid on the item. Delivery fees are not refunded unless the item was faulty or wrong.</li>
</ul>

<h2>Cancellations</h2>
<p>You can cancel a ready-to-wear order for a full refund until it has been dispatched or collected. Custom orders can''t be cancelled once cutting has started.</p>

<h2>Need help?</h2>
<p>WhatsApp or call <a href="https://wa.me/2348033640090">+234 803 364 0090</a>, or email <a href="mailto:info@wecisclothing.com">info@wecisclothing.com</a>.</p>
<p><em>This policy does not affect your rights under the Federal Competition and Consumer Protection Act 2018.</em></p>', 'Delivery across Nigeria, free pick-up at our Ikeja and Victoria Island showrooms, and 30-day returns and exchanges at Wecis Clothing.', 1, 2)
ON DUPLICATE KEY UPDATE title = VALUES(title), body = VALUES(body), meta_description = VALUES(meta_description), is_active = 1;

-- The old one-line "Delivery Information" page is replaced (the site redirects its URL to the new page).
UPDATE pages SET is_active = 0 WHERE slug = 'delivery-information';
