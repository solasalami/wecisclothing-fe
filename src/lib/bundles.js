import "server-only";
import { query, parseJson } from "./db";

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
