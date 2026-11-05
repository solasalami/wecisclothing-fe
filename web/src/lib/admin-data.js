import "server-only";
import { query, queryOne, parseJson } from "./db";

export async function getAllCategoriesTree() {
  const rows = await query("SELECT id, parent_id, name, slug, is_active, show_in_menu, sort_order, image, description FROM categories ORDER BY sort_order, name");
  const byId = new Map(rows.map((c) => [c.id, { ...c, children: [] }]));
  const roots = [];
  for (const c of byId.values()) (c.parent_id && byId.has(c.parent_id) ? byId.get(c.parent_id).children : roots).push(c);
  return roots;
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
