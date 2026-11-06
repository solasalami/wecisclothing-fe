-- Add VAT columns (products, orders, order_items). Run once on the live database.
-- Run in phpMyAdmin: select the database, open SQL, paste, Go.
-- (Locally, `npm run db:migrate` does the same thing and is safe to run more than once.)
ALTER TABLE products    ADD COLUMN vat_inclusive TINYINT(1) NOT NULL DEFAULT 0 AFTER compare_at_price;
ALTER TABLE orders      ADD COLUMN vat_rate DECIMAL(5,2) NOT NULL DEFAULT 0 AFTER subtotal,
                        ADD COLUMN vat_added DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_rate,
                        ADD COLUMN vat_included DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_added;
ALTER TABLE order_items ADD COLUMN vat_inclusive TINYINT(1) NOT NULL DEFAULT 0 AFTER line_total,
                        ADD COLUMN vat_amount DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_inclusive;
