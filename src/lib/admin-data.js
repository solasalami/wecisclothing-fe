import "server-only";
import { query, queryOne, parseJson } from "./db";

export async function getAllCategoriesTree() {
  const rows = await query(
    `SELECT c.id, c.parent_id, c.name, c.slug, c.is_active, c.show_in_menu, c.sort_order, c.image, c.description,
       (SELECT COUNT(*) FROM product_categories pc WHERE pc.category_id = c.id) AS product_count
     FROM categories c ORDER BY c.sort_order, c.name`
  );
  const byId = new Map(rows.map((c) => [c.id, { ...c, children: [] }]));
  const roots = [];
  for (const c of byId.values()) (c.parent_id && byId.has(c.parent_id) ? byId.get(c.parent_id).children : roots).push(c);
  return roots;
}

/** Depth-first list with depth, full path ("Men › Suit › Office Suit") and descendant ids. */
export function flattenCategories(tree, depth = 0, trail = [], out = []) {
  for (const c of tree) {
    const path = [...trail, c.name];
    const node = { ...c, depth, path: path.join(" › "), descendantIds: [] };
    out.push(node);
    const start = out.length;
    flattenCategories(c.children, depth + 1, path, out);
    node.descendantIds = out.slice(start).map((d) => d.id);
  }
  return out;
}

export async function getProductForEdit(id) {
  const p = await queryOne("SELECT * FROM products WHERE id = ?", [id]);
  if (!p) return null;
  p.sizes = parseJson(p.sizes, []);
  p.package_items = parseJson(p.package_items, []);
  p.images = await query("SELECT id, url FROM product_images WHERE product_id = ? ORDER BY sort_order, id", [id]);
  p.categoryIds = (await query("SELECT category_id FROM product_categories WHERE product_id = ?", [id])).map((r) => r.category_id);
  p.pick = p.pick_min != null
    ? { categoryId: p.pick_category_id || null, min: p.pick_min, max: p.pick_max, prices: parseJson(p.pick_prices, {}) || {} }
    : null;
  p.componentIds = p.kind === "package"
    ? (await query("SELECT product_id FROM package_components WHERE package_id = ? ORDER BY sort_order, id", [id])).map((r) => r.product_id)
    : [];
  return p;
}

/** Categories for a pick-your-own bundle, each with how many visible products it (and its sub-categories) holds. */
export async function getPickCategoryOptions() {
  const flat = flattenCategories(await getAllCategoriesTree());
  const links = await query(
    "SELECT pc.category_id, pc.product_id FROM product_categories pc JOIN products p ON p.id = pc.product_id WHERE p.kind = 'product' AND p.is_active = 1"
  );
  const byCat = new Map();
  for (const l of links) (byCat.get(l.category_id) || byCat.set(l.category_id, new Set()).get(l.category_id)).add(l.product_id);
  return flat.map((c) => {
    const ids = new Set();
    for (const id of [c.id, ...c.descendantIds]) for (const pid of byCat.get(id) || []) ids.add(pid);
    return { id: c.id, path: c.path, pool_count: ids.size };
  });
}

/** Every normal product, for picking what goes into a bundle package. */
export async function getBundleCandidates() {
  const rows = await query(
    `SELECT p.id, p.name, p.price, p.sizes, p.is_active,
       (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1) AS image
     FROM products p WHERE p.kind = 'product' ORDER BY p.is_active DESC, p.name`
  );
  return rows.map((r) => ({ id: r.id, name: r.name, price: Number(r.price), sizes: parseJson(r.sizes, []), is_active: Boolean(r.is_active), image: r.image }));
}
