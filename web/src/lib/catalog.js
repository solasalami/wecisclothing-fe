import "server-only";
import { query, queryOne, parseJson } from "./db";

const PRODUCT_COLUMNS = `
  p.id, p.kind, p.name, p.slug, p.sku, p.short_description, p.price, p.compare_at_price,
  p.stock_qty, p.track_stock, p.is_featured, p.sizes,
  (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1) AS image,
  (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1 OFFSET 1) AS image_alt`;

function hydrate(p) {
  if (!p) return p;
  return {
    ...p,
    sizes: parseJson(p.sizes, []),
    package_items: parseJson(p.package_items, []),
    in_stock: !p.track_stock || p.stock_qty > 0,
  };
}

async function descendantIds(rootId) {
  const rows = await query(
    `WITH RECURSIVE sub AS (
       SELECT id FROM categories WHERE id = ?
       UNION ALL SELECT c.id FROM categories c JOIN sub ON c.parent_id = sub.id
     ) SELECT id FROM sub`,
    [rootId]
  );
  return rows.map((r) => r.id);
}

/** Active category tree. Each node has `count` = active products in it or any descendant. */
export async function getCategoryTree() {
  const rows = await query(
    `SELECT c.id, c.parent_id, c.name, c.slug, c.image, c.description, c.show_in_menu,
       (SELECT COUNT(*) FROM product_categories pc JOIN products p ON p.id = pc.product_id AND p.is_active = 1 WHERE pc.category_id = c.id) AS own
     FROM categories c WHERE c.is_active = 1 ORDER BY c.sort_order, c.name`
  );
  const byId = new Map(rows.map((c) => [c.id, { ...c, children: [] }]));
  const roots = [];
  for (const c of byId.values()) {
    if (c.parent_id && byId.has(c.parent_id)) byId.get(c.parent_id).children.push(c);
    else roots.push(c);
  }
  const total = (n) => (n.count = Number(n.own) + n.children.reduce((s, ch) => s + total(ch), 0));
  roots.forEach(total);
  return roots;
}

export async function getCategoryBySlug(slug) {
  const cat = await queryOne("SELECT * FROM categories WHERE slug = ? AND is_active = 1", [slug]);
  if (!cat) return null;
  const children = await query(
    "SELECT id, name, slug FROM categories WHERE parent_id = ? AND is_active = 1 ORDER BY sort_order, name",
    [cat.id]
  );
  // only surface sub-categories that actually contain products
  cat.children = [];
  for (const ch of children) {
    const ids = await descendantIds(ch.id);
    const [{ n }] = await query(
      "SELECT COUNT(*) AS n FROM product_categories pc JOIN products p ON p.id = pc.product_id AND p.is_active = 1 WHERE pc.category_id IN (?)",
      [ids]
    );
    if (n > 0) cat.children.push(ch);
  }
  cat.parent = cat.parent_id
    ? await queryOne("SELECT id, name, slug FROM categories WHERE id = ?", [cat.parent_id])
    : null;
  return cat;
}

const SORTS = {
  newest: "p.created_at DESC, p.id DESC",
  price_asc: "p.price ASC",
  price_desc: "p.price DESC",
  popular: "p.views DESC",
  default: "p.sort_order ASC, p.created_at DESC, p.id DESC",
};

/**
 * List active products.
 * @param {{categoryId?:number, kind?:string, featured?:boolean, search?:string, sort?:string, limit?:number, offset?:number}} opts
 */
export async function listProducts(opts = {}) {
  const where = ["p.is_active = 1"];
  const params = [];
  if (opts.kind) {
    where.push("p.kind = ?");
    params.push(opts.kind);
  }
  if (opts.featured) where.push("p.is_featured = 1");
  if (opts.categoryId) {
    // include products in the category or any descendant category
    const ids = await descendantIds(opts.categoryId);
    where.push("EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id AND pc.category_id IN (?))");
    params.push(ids);
  }
  if (opts.search) {
    where.push("(p.name LIKE ? OR p.short_description LIKE ? OR p.sku = ?)");
    params.push(`%${opts.search}%`, `%${opts.search}%`, opts.search);
  }
  const order = SORTS[opts.sort] || SORTS.default;
  const limit = Math.min(Number(opts.limit) || 24, 100);
  const offset = Math.max(Number(opts.offset) || 0, 0);
  const rows = await query(
    `SELECT ${PRODUCT_COLUMNS} FROM products p WHERE ${where.join(" AND ")} ORDER BY ${order} LIMIT ${limit} OFFSET ${offset}`,
    params
  );
  const [{ total }] = await query(`SELECT COUNT(*) AS total FROM products p WHERE ${where.join(" AND ")}`, params);
  return { items: rows.map(hydrate), total };
}

export async function getProductBySlug(slug) {
  const p = await queryOne("SELECT * FROM products WHERE slug = ? AND is_active = 1", [slug]);
  if (!p) return null;
  p.images = await query("SELECT id, url, alt FROM product_images WHERE product_id = ? ORDER BY sort_order, id", [p.id]);
  p.categories = await query(
    "SELECT c.id, c.name, c.slug FROM product_categories pc JOIN categories c ON c.id = pc.category_id WHERE pc.product_id = ? AND c.is_active = 1",
    [p.id]
  );
  query("UPDATE products SET views = views + 1 WHERE id = ?", [p.id]).catch(() => {});
  return hydrate(p);
}

export async function getRelatedProducts(product, limit = 4) {
  const catIds = product.categories.map((c) => c.id);
  if (!catIds.length) return (await listProducts({ limit })).items.filter((p) => p.id !== product.id);
  const rows = await query(
    `SELECT ${PRODUCT_COLUMNS} FROM products p
     WHERE p.is_active = 1 AND p.id <> ?
       AND EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id AND pc.category_id IN (?))
     ORDER BY p.views DESC LIMIT ${Number(limit)}`,
    [product.id, catIds]
  );
  return rows.map(hydrate);
}

/** Fetch live product rows for pricing a cart server-side. */
export async function getProductsByIds(ids) {
  if (!ids.length) return [];
  const rows = await query(`SELECT ${PRODUCT_COLUMNS}, p.is_active FROM products p WHERE p.id IN (?)`, [ids]);
  return rows.map(hydrate);
}

export async function getBanners(placement = "home_hero") {
  return query("SELECT * FROM banners WHERE placement = ? AND is_active = 1 ORDER BY sort_order, id", [placement]);
}

export async function getShowrooms() {
  return query("SELECT * FROM showrooms WHERE is_active = 1 ORDER BY sort_order, id");
}

export async function getPage(slug) {
  return queryOne("SELECT * FROM pages WHERE slug = ? AND is_active = 1", [slug]);
}

export async function getFooterPages() {
  return query("SELECT slug, title FROM pages WHERE is_active = 1 ORDER BY sort_order, title");
}
