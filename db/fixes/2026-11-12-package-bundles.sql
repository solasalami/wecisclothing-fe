-- Bundle packages (e.g. "All-In-One Family Drip"): a package made of real products sold
-- together at one price, with a size chosen for each item.
-- Run once on the live database BEFORE deploying (product listings read the new table).
-- Locally, `npm run db:migrate` does the same.
CREATE TABLE IF NOT EXISTS package_components (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  package_id INT UNSIGNED NOT NULL,         -- the package (products.kind = 'package')
  product_id INT UNSIGNED NOT NULL,         -- a real product included in it
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE KEY uq_pkg_product (package_id, product_id),
  KEY idx_pc_product (product_id),
  CONSTRAINT fk_pkgc_package FOREIGN KEY (package_id) REFERENCES products(id) ON DELETE CASCADE,
  CONSTRAINT fk_pkgc_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- If this says "Duplicate column name 'components'", it is already there: that's fine.
ALTER TABLE order_items ADD COLUMN components JSON NULL AFTER size;
