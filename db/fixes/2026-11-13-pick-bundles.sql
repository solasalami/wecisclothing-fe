-- Pick-your-own bundles: the shopper chooses a number of outfits (e.g. 3 to 5) from a
-- category, at a fixed price for each number picked.
-- Run once on the live database BEFORE deploying (product pages read these columns).
-- Locally, `npm run db:migrate` does the same.
-- If this says "Duplicate column name", the columns are already there: that's fine.
ALTER TABLE products
  ADD COLUMN pick_category_id INT UNSIGNED NULL AFTER package_items,
  ADD COLUMN pick_min TINYINT UNSIGNED NULL AFTER pick_category_id,
  ADD COLUMN pick_max TINYINT UNSIGNED NULL AFTER pick_min,
  ADD COLUMN pick_prices JSON NULL AFTER pick_max;
