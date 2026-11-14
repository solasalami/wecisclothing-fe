import "server-only";
import { query, queryOne, parseJson } from "./db";

// Bundle packages: a package (products.kind = 'package') made of real products listed in
// package_components. The shopper picks a size for each included product; the bundle is
// sold as one line at the package's price.

/** Included products for each package id: Map(packageId => [{ id, name, slug, sku, price, sizes, image, ... }]). */
export async function getComponents(packageIds) {
  const ids = [...new Set((packageIds || []).map(Number).filter(Boolean))];
  const out = new Map(ids.map((id) => [id, []]));
  if (!ids.length) return out;
  const rows = await query(
    `SELECT pc.package_id, p.id, p.name, p.slug, p.sku, p.price, p.sizes, p.is_active, p.track_stock, p.stock_qty,
       (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1) AS image
     FROM package_components pc JOIN products p ON p.id = pc.product_id
     WHERE pc.package_id IN (?) ORDER BY pc.package_id, pc.sort_order, pc.id`,
    [ids]
  );
  for (const r of rows) {
    out.get(r.package_id)?.push({
      id: r.id,
      name: r.name,
      slug: r.slug,
      sku: r.sku,
      price: Number(r.price),
      sizes: parseJson(r.sizes, []),
      image: r.image,
      is_active: Boolean(r.is_active),
      track_stock: Boolean(r.track_stock),
      stock_qty: Number(r.stock_qty),
      in_stock: !r.track_stock || r.stock_qty > 0,
    });
  }
  return out;
}

/** What the items would cost separately: the admin's "compare at" price, or their total. */
export function bundleWorth(pkg, components) {
  return Number(pkg.compare_at_price) || components.reduce((sum, c) => sum + Number(c.price), 0);
}

/** Replace a package's included products (inside a transaction). Never itself or another package. */
export async function saveComponents(tx, packageId, productIds) {
  const wanted = [...new Set(productIds.map(Number).filter((id) => id > 0 && id !== Number(packageId)))];
  const valid = wanted.length
    ? (await tx.query("SELECT id FROM products WHERE id IN (?) AND kind = 'product'", [wanted])).map((r) => r.id)
    : [];
  await tx.query("DELETE FROM package_components WHERE package_id = ?", [packageId]);
  let order = 0;
  for (const id of wanted) {
    if (!valid.includes(id)) continue;
    await tx.query("INSERT INTO package_components (package_id, product_id, sort_order) VALUES (?,?,?)", [packageId, id, order++]);
  }
  return order;
}

// ---------- Pick-your-own bundles ----------
// A package with pick_min/pick_max/pick_prices: the shopper chooses between pick_min and
// pick_max outfits from its pool, at the price set for that number. The pool is the
// package's own product list (package_components, the same list as fixed bundles, also
// filled from Admin, Products) plus, optionally, every visible product in pick_category_id.

/** { packageId, categoryId|null, min, max, prices: { [count]: price } } for a pick-your-own package, else null. */
export function pickRules(pkg) {
  if (!pkg || pkg.pick_min == null) return null;
  const prices = parseJson(pkg.pick_prices, {}) || {};
  return {
    packageId: Number(pkg.id),
    categoryId: Number(pkg.pick_category_id) || null,
    min: Number(pkg.pick_min) || 1,
    max: Number(pkg.pick_max) || Number(pkg.pick_min) || 1,
    prices,
  };
}

/** The fixed price for picking `count` outfits, or null when that number isn't allowed. */
export function pickPrice(rules, count) {
  if (!rules || count < rules.min || count > rules.max) return null;
  const price = Number(rules.prices?.[count]);
  return price > 0 ? price : null;
}

// Products in a pick-your-own pool: listed on the package (even if hidden from the shop, so
// bundle-only outfits work), or visible in its category or a sub-category.
function poolWhere(rules) {
  const params = [rules.packageId];
  let cat = "";
  if (rules.categoryId) {
    cat = `OR (p.is_active = 1 AND EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id AND pc.category_id IN (
      WITH RECURSIVE sub AS (SELECT id FROM categories WHERE id = ? UNION ALL SELECT c.id FROM categories c JOIN sub ON c.parent_id = sub.id)
      SELECT id FROM sub)))`;
    params.push(rules.categoryId);
  }
  return { sql: `p.kind = 'product' AND (EXISTS (SELECT 1 FROM package_components k WHERE k.package_id = ? AND k.product_id = p.id) ${cat})`, params };
}

/** The outfits a shopper can pick from, listed ones first in their order. */
export async function getPickPool(rules, { limit = 200 } = {}) {
  if (!rules) return [];
  const where = poolWhere(rules);
  const rows = await query(
    `SELECT p.id, p.name, p.slug, p.sku, p.price, p.sizes, p.is_active, p.track_stock, p.stock_qty,
       (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1) AS image,
       (SELECT k.sort_order FROM package_components k WHERE k.package_id = ? AND k.product_id = p.id) AS listed
     FROM products p WHERE ${where.sql}
     ORDER BY listed IS NULL, listed, p.sort_order, p.id DESC LIMIT ${Number(limit)}`,
    [rules.packageId, ...where.params]
  );
  return rows.map((r) => ({
    id: r.id,
    name: r.name,
    slug: r.slug,
    sku: r.sku,
    price: Number(r.price),
    sizes: parseJson(r.sizes, []),
    image: r.image,
    is_active: Boolean(r.is_active),
    track_stock: Boolean(r.track_stock),
    stock_qty: Number(r.stock_qty),
    in_stock: !r.track_stock || r.stock_qty > 0,
  }));
}

/** How many outfits a pick-your-own package can draw on (for admin). */
export async function pickPoolSize(rules) {
  if (!rules) return 0;
  const where = poolWhere(rules);
  const r = await queryOne(`SELECT COUNT(*) n FROM products p WHERE ${where.sql}`, where.params);
  return Number(r?.n || 0);
}
