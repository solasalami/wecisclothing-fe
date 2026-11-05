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
  return p;
}
