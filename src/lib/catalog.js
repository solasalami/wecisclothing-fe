import "server-only";
import { query, queryOne, parseJson } from "./db";
import { getSetting } from "./settings";
import { isCampaignLive } from "./campaign";
import { cached } from "./cache";

/** Seasonal packages are hidden from listings (and can't be bought) outside their campaign, if configured. */
export async function packagesAvailable() {
  const c = await getSetting("campaign");
  return isCampaignLive(c) || !c.hide_packages_when_off;
}

const PRODUCT_COLUMNS = `
  p.id, p.kind, p.name, p.slug, p.sku, p.short_description, p.price, p.compare_at_price, p.vat_inclusive,
  p.stock_qty, p.track_stock, p.is_featured, p.sizes, p.badge, p.created_at,
  (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1) AS image,
  (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY i.sort_order, i.id LIMIT 1 OFFSET 1) AS image_alt`;

const NEW_ARRIVAL_DAYS = 45;

/** Card label: admin-set badge wins; otherwise "New arrival" for recently added products. */
function displayBadge(p) {
  if (p.badge) return p.badge;
  if (p.created_at && Date.now() - new Date(p.created_at).getTime() < NEW_ARRIVAL_DAYS * 864e5) return "New arrival";
  return null;
}

function hydrate(p) {
  if (!p) return p;
  return {
    ...p,
    display_badge: displayBadge(p),
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
async function getCategoryTreeUncached() {
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

async function getCategoryBySlugUncached(slug) {
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
async function listProductsUncached(opts = {}) {
  const where = ["p.is_active = 1"];
  const params = [];
  if (opts.kind) {
    where.push("p.kind = ?");
    params.push(opts.kind);
  } else if (!(await packagesAvailable())) {
    where.push("p.kind = 'product'");
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

async function loadProductBySlug(slug) {
  const p = await queryOne("SELECT * FROM products WHERE slug = ? AND is_active = 1", [slug]);
  if (!p) return null;
  p.images = await query("SELECT id, url, alt FROM product_images WHERE product_id = ? ORDER BY sort_order, id", [p.id]);
  p.categories = await query(
    "SELECT c.id, c.name, c.slug FROM product_categories pc JOIN categories c ON c.id = pc.category_id WHERE pc.product_id = ? AND c.is_active = 1",
    [p.id]
  );
  return hydrate(p);
}
const loadProductBySlugCached = cached(loadProductBySlug, "productBySlug");

export async function getProductBySlug(slug) {
  const p = await loadProductBySlugCached(slug);
  // view counter stays outside the cache (fire-and-forget)
  if (p) query("UPDATE products SET views = views + 1 WHERE id = ?", [p.id]).catch(() => {});
  return p;
}

export async function getRelatedProducts(product, limit = 4) {
  return relatedCached(product.id, product.categories.map((c) => c.id), limit);
}

async function relatedUncached(productId, catIds, limit) {
  const product = { id: productId };
  if (!catIds.length) return (await listProducts({ limit })).items.filter((p) => p.id !== product.id);
  const rows = await query(
    `SELECT ${PRODUCT_COLUMNS} FROM products p
     WHERE p.is_active = 1 AND p.id <> ? ${(await packagesAvailable()) ? "" : "AND p.kind = 'product'"}
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

async function getBannersUncached(placement = "home_hero") {
  return query("SELECT * FROM banners WHERE placement = ? AND is_active = 1 ORDER BY sort_order, id", [placement]);
}

async function getShowroomsUncached() {
  return query("SELECT * FROM showrooms WHERE is_active = 1 ORDER BY sort_order, id");
}

async function getPageUncached(slug) {
  return queryOne("SELECT * FROM pages WHERE slug = ? AND is_active = 1", [slug]);
}

async function getFooterPagesUncached() {
  return query("SELECT slug, title FROM pages WHERE is_active = 1 ORDER BY sort_order, title");
}

export const getCategoryTree = cached(getCategoryTreeUncached, "getCategoryTree");
export const getCategoryBySlug = cached(getCategoryBySlugUncached, "getCategoryBySlug");
export const listProducts = cached(listProductsUncached, "listProducts");
export const getBanners = cached(getBannersUncached, "getBanners");
export const getShowrooms = cached(getShowroomsUncached, "getShowrooms");
export const getPage = cached(getPageUncached, "getPage");
export const getFooterPages = cached(getFooterPagesUncached, "getFooterPages");
const relatedCached = cached(relatedUncached, "related");
