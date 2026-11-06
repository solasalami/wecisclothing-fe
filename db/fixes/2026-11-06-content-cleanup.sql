-- Content clean-up after the OpenCart import. Safe to run more than once.
-- Run in phpMyAdmin: select the database, open SQL, paste, Go.
-- 1. No links to the old OpenCart site (index.php?route=...).
-- 2. Brand name is "Wecis Clothing" (not "Clothings").
-- 3. Terms: naira symbol lost in the import; delivery and returns point to the new policy page.
-- 4. Privacy: real contact email instead of the "[insert contact email]" placeholder.
SET NAMES utf8mb4;

-- Terms & Conditions
UPDATE pages SET body = REPLACE(body,
  '<a rel="noopener" href="https://www.wecisclothing.com/index.php?route=information/information&amp;information_id=5" target="_blank">Privacy Policy</a>',
  '<a href="/pages/privacy-policy">Privacy Policy</a>')
WHERE slug = 'terms-and-conditions';

UPDATE pages SET body = REPLACE(body, '[<span>?</span> / Nigerian Naira]', 'Nigerian Naira (₦)')
WHERE slug = 'terms-and-conditions';

UPDATE pages SET body = REPLACE(body,
  '<p>We deliver <strong>worldwide</strong>. Shipping fees and delivery timelines are provided at checkout.</p>',
  '<p>We deliver across Nigeria, and offer free pick-up at our Ikeja and Victoria Island showrooms in Lagos. Delivery fees are shown at checkout. For delivery outside Nigeria, contact us for a quote. Full details are in our <a href="/pages/shipping-and-returns">Shipping &amp; Returns policy</a>.</p>')
WHERE slug = 'terms-and-conditions';

UPDATE pages SET body = REPLACE(body,
  '<p>Shipping costs for returns are borne by the customer unless the item is defective.</p>\n</li></ul>',
  '<p>Shipping costs for returns are borne by the customer unless the item is defective.</p>\n</li></ul>\n<p>See our <a href="/pages/shipping-and-returns">Shipping &amp; Returns policy</a> for how to return or exchange an item.</p>')
WHERE slug = 'terms-and-conditions' AND body NOT LIKE '%for how to return or exchange an item%';

-- Privacy Policy
UPDATE pages SET body = REPLACE(body, '<strong>[insert contact email]</strong>', '<a href="mailto:info@wecisclothing.com">info@wecisclothing.com</a>')
WHERE slug = 'privacy-policy';
UPDATE pages SET body = REPLACE(body, '+234&nbsp; 803 364 0090', '+234 803 364 0090')
WHERE slug = 'privacy-policy';

-- Brand name everywhere
UPDATE pages      SET title = REPLACE(title, 'Wecis Clothings', 'Wecis Clothing'), body = REPLACE(body, 'Wecis Clothings', 'Wecis Clothing'),
                      meta_description = REPLACE(meta_description, 'Wecis Clothings', 'Wecis Clothing')
WHERE CONCAT_WS(' ', title, body, meta_description) LIKE '%Wecis Clothings%';
UPDATE categories SET description = REPLACE(description, 'Wecis Clothings', 'Wecis Clothing')
WHERE description LIKE '%Wecis Clothings%';
UPDATE products   SET description = REPLACE(description, 'Wecis Clothings', 'Wecis Clothing'),
                      short_description = REPLACE(short_description, 'Wecis Clothings', 'Wecis Clothing')
WHERE CONCAT_WS(' ', description, short_description) LIKE '%Wecis Clothings%';

-- Stray spaces before punctuation in the Men and Women category descriptions
UPDATE categories SET description = REPLACE(REPLACE(description, ' ,', ','), ' .', '.')
WHERE slug IN ('men', 'women');

-- Safety net: any other link to the old site becomes a relative link
-- (the new site redirects /index.php?route=... to the right page).
UPDATE pages      SET body = REPLACE(REPLACE(body, 'https://www.wecisclothing.com/index.php', '/index.php'), 'http://www.wecisclothing.com/index.php', '/index.php')
WHERE body LIKE '%wecisclothing.com/index.php%';
UPDATE products   SET description = REPLACE(REPLACE(description, 'https://www.wecisclothing.com/index.php', '/index.php'), 'http://www.wecisclothing.com/index.php', '/index.php')
WHERE description LIKE '%wecisclothing.com/index.php%';
UPDATE categories SET description = REPLACE(REPLACE(description, 'https://www.wecisclothing.com/index.php', '/index.php'), 'http://www.wecisclothing.com/index.php', '/index.php')
WHERE description LIKE '%wecisclothing.com/index.php%';
