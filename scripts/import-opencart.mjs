// One-time import of real catalogue data from the OpenCart dump into the clean schema.
// Usage: node scripts/import-opencart.mjs ./localhost.sql ./wecisclothing/image
//
// Imports: categories (re-parented under Men/Women), products, images, home banners,
// information pages, showrooms and default settings.
// Skips:   OpenCart demo customers/orders/options (they are theme demo data).
import "./env.mjs";
import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import mysql from "mysql2/promise";

const [sqlPath = "./localhost.sql", imageRoot = "./wecisclothing/image"] = process.argv.slice(2).filter((a) => !a.startsWith("--"));
const sql = fs.readFileSync(sqlPath, "utf8");

// ---------- tiny SQL INSERT parser ----------
function tableRows(table) {
  const re = new RegExp("INSERT INTO `" + table + "` \\(([^)]*)\\) VALUES\\s*", "g");
  const out = [];
  let m;
  while ((m = re.exec(sql))) {
    const cols = m[1].split(",").map((c) => c.trim().replace(/`/g, ""));
    let i = re.lastIndex;
    // parse tuples until ';'
    while (i < sql.length && sql[i] !== ";") {
      if (sql[i] !== "(") { i++; continue; }
      i++;
      const vals = [];
      while (true) {
        while (sql[i] === " " || sql[i] === "\n" || sql[i] === "\r") i++;
        if (sql[i] === "'") {
          let v = "";
          i++;
          while (true) {
            const ch = sql[i];
            if (ch === "\\") { const n = sql[i + 1]; v += n === "n" ? "\n" : n === "r" ? "\r" : n === "t" ? "\t" : n === "0" ? "\0" : n; i += 2; continue; }
            if (ch === "'" && sql[i + 1] === "'") { v += "'"; i += 2; continue; }
            if (ch === "'") { i++; break; }
            v += ch; i++;
          }
          vals.push(v);
        } else {
          let v = "";
          while (sql[i] !== "," && sql[i] !== ")") v += sql[i++];
          v = v.trim();
          vals.push(v === "NULL" ? null : v);
        }
        while (sql[i] === " ") i++;
        if (sql[i] === ",") { i++; continue; }
        if (sql[i] === ")") { i++; break; }
      }
      out.push(Object.fromEntries(cols.map((c, k) => [c, vals[k]])));
    }
    re.lastIndex = i;
  }
  return out;
}

const decode = (s) =>
  String(s ?? "")
    .replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/&#039;/g, "'").replace(/&amp;/g, "&");

// Strip OpenCart/ChatGPT paste cruft (data-* attrs, inline styles, classes) from HTML.
const cleanHtml = (html) =>
  decode(html)
    .replace(/<(script|style|iframe)[\s\S]*?<\/\1>/gi, "")
    .replace(/\s(data-[\w-]+|class|style|id)="[^"]*"/gi, "")
    .replace(/\son\w+="[^"]*"/gi, "")
    .replace(/<span>\s*<\/span>/g, "")
    .replace(/(\r?\n|\t)+/g, "\n")
    .replace(/<p>(\s|&nbsp;|<br\s*\/?>)*<\/p>/gi, "")
    .trim();

const plain = (html) => cleanHtml(html).replace(/<[^>]+>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();

const slugify = (t) =>
  String(t).toLowerCase().normalize("NFKD").replace(/[̀-ͯ]/g, "").replace(/&/g, " and ").replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "").slice(0, 200);

// ---------- storage (same layout as src/lib/storage.js) ----------
const driver = process.env.STORAGE_DRIVER || "local";
let blobStore;
if (driver === "blobs") {
  const { getStore } = await import("@netlify/blobs");
  blobStore = getStore({ name: "media", siteID: process.env.NETLIFY_SITE_ID, token: process.env.NETLIFY_AUTH_TOKEN });
}
const uploaded = new Map();
async function uploadImage(rel) {
  if (!rel) return null;
  if (uploaded.has(rel)) return uploaded.get(rel);
  const file = path.join(imageRoot, rel);
  if (!fs.existsSync(file)) { console.warn("  missing image", rel); uploaded.set(rel, null); return null; }
  const buf = fs.readFileSync(file);
  const ext = path.extname(rel).toLowerCase() === ".png" ? ".png" : ".jpg";
  const key = `legacy/${crypto.createHash("sha1").update(buf).digest("hex").slice(0, 16)}${ext}`;
  const type = ext === ".png" ? "image/png" : "image/jpeg";
  if (driver === "blobs") {
    await blobStore.set(key, new Blob([buf], { type }), { metadata: { contentType: type } });
  } else {
    const dest = path.join(process.cwd(), ".uploads", key);
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.writeFileSync(dest, buf);
  }
  const url = `/media/${key}`;
  uploaded.set(rel, url);
  return url;
}

// ---------- run ----------
const db = await mysql.createConnection({
  uri: process.env.DATABASE_URL,
  ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: true } : undefined,
});
const q = async (s, p = []) => (await db.query(s, p))[0];

const existing = await q("SELECT COUNT(*) AS n FROM products");
if (existing[0].n > 0 && !process.argv.includes("--force")) {
  console.error("Products already exist. Re-run with --force to wipe catalogue tables and re-import.");
  process.exit(1);
}
if (process.argv.includes("--force")) {
  await q("SET FOREIGN_KEY_CHECKS = 0");
  for (const t of ["product_categories", "product_images", "products", "categories", "banners", "showrooms", "pages"]) await q(`TRUNCATE TABLE ${t}`);
  await q("SET FOREIGN_KEY_CHECKS = 1");
}

// Categories (English = language_id 1)
const catRows = tableRows("oc_category").filter((c) => c.status === "1");
const catNames = Object.fromEntries(tableRows("oc_category_description").filter((d) => d.language_id === "1").map((d) => [d.category_id, d]));
const MEN = "20", WOMEN = "25";
// Legacy top-level categories that belong under a gender
const REPARENT = { 17: MEN, 24: MEN, 59: MEN, 60: WOMEN };
const RENAME = { 26: "Casual", 28: "Casual", 37: "Long Sleeves without Cuffs", 38: "Long Sleeves with Cuffs", 54: "Round Neck Shirts", 32: "Haute Couture" };
const catMap = new Map(); // legacy id -> new id
const usedSlugs = new Set();
const uniqueSlug = (base) => { let s = base || "item", n = 2; while (usedSlugs.has(s)) s = `${base}-${n++}`; usedSlugs.add(s); return s; };

const ordered = [...catRows].sort((a, b) => {
  const depth = (c) => { let d = 0, cur = c; while (cur && cur.parent_id !== "0") { d++; cur = catRows.find((x) => x.category_id === (REPARENT[cur.category_id] ?? cur.parent_id)); if (d > 5) break; } return d; };
  return depth(a) - depth(b);
});
// ensure parents first: Men & Women
ordered.sort((a, b) => ([MEN, WOMEN].includes(b.category_id) ? 1 : 0) - ([MEN, WOMEN].includes(a.category_id) ? 1 : 0));
for (const c of ordered) {
  const legacyParent = REPARENT[c.category_id] ?? c.parent_id;
  const name = RENAME[c.category_id] || decode(catNames[c.category_id]?.name || `Category ${c.category_id}`).trim();
  const parentId = legacyParent !== "0" ? catMap.get(legacyParent) ?? null : null;
  const parentSlug = parentId ? [...catMap.entries()].find(([, v]) => v === parentId) : null;
  const gender = c.category_id === MEN || c.category_id === WOMEN ? "" : (legacyParent === WOMEN || catRows.find((x) => x.category_id === legacyParent)?.parent_id === WOMEN ? "women-" : "men-");
  const slug = uniqueSlug(slugify(`${gender}${name}`));
  const image = c.category_id === MEN ? "catalog/Wecis/banner 2.jpeg" : c.category_id === WOMEN ? "catalog/Wecis/banner 1.jpeg" : null;
  const res = await q(
    "INSERT INTO categories (parent_id, name, slug, description, image, sort_order, is_active, show_in_menu) VALUES (?,?,?,?,?,?,1,?)",
    [parentId, name, slug, plain(catNames[c.category_id]?.description) || null, await uploadImage(image), c.category_id === MEN ? 1 : c.category_id === WOMEN ? 2 : Number(c.sort_order), 1]
  );
  catMap.set(c.category_id, res.insertId);
  void parentSlug;
}
console.log(`Categories: ${catMap.size}`);

// Products
const prodRows = tableRows("oc_product");
const prodDesc = Object.fromEntries(tableRows("oc_product_description").filter((d) => d.language_id === "1").map((d) => [d.product_id, d]));
const gallery = tableRows("oc_product_image");
const DEMO_NAMES = /voluptas|praesentium|doloremque|assumenda/i;
const DEFAULT_SIZES = ["S", "M", "L", "XL", "XXL"];
usedSlugs.clear();
let nProducts = 0, nDrafts = 0;
for (const p of prodRows) {
  const d = prodDesc[p.product_id] || {};
  let name = decode(d.name || "").replace(/\s+/g, " ").trim().replace(/\s*-\s*$/, "");
  const isWomen = /New Women/i.test(p.image);
  const isDemo = !name || DEMO_NAMES.test(name);
  if (name === "Men Tropical Outfit") name = "Men Tropical Outfit - Off White";
  name = name
    .replace("Muti-Colour", "Multi-Colour")
    .replace("Bugundary", "Burgundy")
    .replace("Dark gray", "Dark Grey")
    .replace(/\s+-\s*/g, " - "); // normalise "Outfit -Dark" -> "Outfit - Dark", keep "Blue-Black"
  if (isDemo) name = `Untitled ${isWomen ? "women's" : "men's"} style #${p.product_id}`;
  const description = cleanHtml(d.description);
  const short = plain(d.description).slice(0, 300) || null;
  const slug = uniqueSlug(slugify(name));
  const active = p.status === "1" && !isDemo ? 1 : 0;
  const res = await q(
    `INSERT INTO products (kind, name, slug, sku, short_description, description, price, sizes, stock_qty, track_stock, is_active, is_featured, sort_order, meta_title, views, legacy_id, created_at)
     VALUES ('product',?,?,?,?,?,?,?,0,0,?,?,?,?,?,?,?)`,
    [name, slug, `WC-${p.product_id}`, short, plain(description) ? description : null, Number(p.price), JSON.stringify(DEFAULT_SIZES), active, 0, Number(p.sort_order) || 0, null, Number(p.viewed) || 0, Number(p.product_id), p.date_added]
  );
  const pid = res.insertId;
  // gender category (legacy product_to_category data is theme demo noise, so we use the image folder)
  await q("INSERT INTO product_categories (product_id, category_id) VALUES (?,?)", [pid, catMap.get(isWomen ? WOMEN : MEN)]);
  const imgs = [p.image, ...gallery.filter((g) => g.product_id === p.product_id).sort((a, b) => a.sort_order - b.sort_order).map((g) => g.image)].filter(Boolean);
  const seen = new Set();
  let order = 0;
  for (const rel of imgs) {
    const url = await uploadImage(rel);
    if (!url || seen.has(url)) continue;
    seen.add(url);
    await q("INSERT INTO product_images (product_id, url, alt, sort_order) VALUES (?,?,?,?)", [pid, url, name, order++]);
  }
  nProducts++;
  if (!active) nDrafts++;
}
// Men / Women tiles on the homepage use their most-viewed product photo
for (const legacy of [MEN, WOMEN]) {
  await q(
    `UPDATE categories c SET c.image = (
       SELECT i.url FROM product_images i JOIN product_categories pc ON pc.product_id = i.product_id JOIN products p ON p.id = i.product_id
       WHERE pc.category_id = c.id AND p.is_active = 1 ORDER BY p.views DESC, i.sort_order LIMIT 1)
     WHERE c.id = ?`,
    [catMap.get(legacy)]
  );
}
// Feature the 8 most viewed active products on the homepage
await q("UPDATE products p JOIN (SELECT id FROM products WHERE is_active = 1 ORDER BY views DESC LIMIT 8) t ON t.id = p.id SET p.is_featured = 1");
console.log(`Products: ${nProducts} (${nDrafts} hidden drafts needing names)`);

// Home banners (banner_id 7, English)
const banners = tableRows("oc_banner_image").filter((b) => b.banner_id === "7" && b.language_id === "1");
for (const b of banners) {
  const url = await uploadImage(b.image);
  if (url) await q("INSERT INTO banners (placement, title, image, link, sort_order) VALUES ('home_hero',?,?,?,?)", [b.title, url, null, Number(b.sort_order)]);
}
console.log(`Banners: ${banners.length}`);

// Information pages
const info = tableRows("oc_information_description").filter((d) => d.language_id === "1");
let order = 0;
for (const d of info) {
  const title = decode(d.title).trim();
  await q("INSERT INTO pages (slug, title, body, meta_description, sort_order) VALUES (?,?,?,?,?)", [slugify(title), title, cleanHtml(d.description), plain(d.description).slice(0, 300), order++]);
}
console.log(`Pages: ${info.length}`);

// Showrooms (from config_address)
await q(
  `INSERT INTO showrooms (name, address, phone, whatsapp, hours, map_url, sort_order) VALUES
   ('Ikeja Showroom', '3 Adeniyi Jones Avenue, Ikeja, Lagos', '+234 803 364 0090', '+234 803 364 0090', NULL, ?, 1),
   ('Victoria Island Showroom', '49 Adeola Odeku Street, Victoria Island, Lagos', '+234 803 364 0090', '+234 803 364 0090', NULL, ?, 2)`,
  [
    "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent("3 Adeniyi Jones Avenue, Ikeja, Lagos"),
    "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent("49 Adeola Odeku Street, Victoria Island, Lagos"),
  ]
);
console.log("Showrooms: 2");
await db.end();
console.log("Import complete.");
