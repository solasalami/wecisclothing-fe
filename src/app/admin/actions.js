"use server";
import { redirect } from "next/navigation";
import { revalidatePath, updateTag } from "next/cache";
import { STORE_TAG } from "@/lib/cache";
import { z } from "zod";
import { query, queryOne, transaction } from "@/lib/db";
import { requireAdmin, requireOwner, checkPassword, hashPassword, startAdminSession, endAdminSession } from "@/lib/auth";
import { saveUpload, deleteFile } from "@/lib/storage";
import { sanitizeHtml } from "@/lib/sanitize";
import { slugify } from "@/lib/format";
import { getSetting, saveSetting } from "@/lib/settings";
import { markOrderPaid, ORDER_STATUSES } from "@/lib/orders";
import { RESERVED_SLUGS } from "@/lib/campaign";

// Clear cached storefront data after any content change (see lib/cache.js).
const invalidateStore = () => updateTag(STORE_TAG);

const str = (fd, k) => String(fd.get(k) ?? "").trim();
const num = (fd, k) => {
  const v = String(fd.get(k) ?? "").replace(/[,₦\s]/g, "");
  return v === "" ? null : Number(v);
};
const bool = (fd, k) => (fd.get(k) === "on" || fd.get(k) === "1" ? 1 : 0);
const lines = (v) => String(v || "").split("\n").map((s) => s.trim()).filter(Boolean);
const csv = (v) => String(v || "").split(",").map((s) => s.trim()).filter(Boolean);

async function uniqueSlug(table, base, id = 0) {
  let slug = slugify(base) || "item";
  let n = 2;
  while (await queryOne(`SELECT id FROM ${table} WHERE slug = ? AND id <> ?`, [slug, id])) slug = `${slugify(base)}-${n++}`;
  return slug;
}

// ---------------- auth ----------------
export async function adminLogin(_prev, fd) {
  const email = str(fd, "email").toLowerCase();
  const user = await queryOne("SELECT * FROM admin_users WHERE email = ? AND is_active = 1", [email]);
  if (!user || !(await checkPassword(str(fd, "password"), user.password_hash))) return { error: "Incorrect email or password" };
  await query("UPDATE admin_users SET last_login_at = UTC_TIMESTAMP() WHERE id = ?", [user.id]);
  await startAdminSession(user);
  redirect("/admin");
}

export async function adminLogout() {
  await endAdminSession();
  redirect("/admin/login");
}

// ---------------- products & packages ----------------
export async function saveProduct(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id")) || 0;
  const kind = str(fd, "kind") === "package" ? "package" : "product";
  const name = str(fd, "name");
  const price = num(fd, "price");
  if (!name) return { error: "Name is required" };
  if (price == null || !(price >= 0)) return { error: "Enter a valid price" };
  const compare = num(fd, "compare_at_price");
  const data = {
    kind,
    name,
    slug: await uniqueSlug("products", str(fd, "slug") || name, id),
    sku: str(fd, "sku") || null,
    short_description: str(fd, "short_description").slice(0, 500) || null,
    description: sanitizeHtml(fd.get("description")) || null,
    package_items: kind === "package" ? JSON.stringify(lines(fd.get("package_items"))) : null,
    price,
    compare_at_price: compare && compare > price ? compare : null,
    sizes: JSON.stringify(csv(fd.get("sizes"))),
    stock_qty: Math.max(0, num(fd, "stock_qty") || 0),
    track_stock: bool(fd, "track_stock"),
    is_active: bool(fd, "is_active"),
    is_featured: bool(fd, "is_featured"),
    badge: str(fd, "badge").slice(0, 40) || null,
    sort_order: num(fd, "sort_order") || 0,
    meta_title: str(fd, "meta_title") || null,
    meta_description: str(fd, "meta_description") || null,
  };
  const categoryIds = fd.getAll("categories").map(Number).filter(Boolean);
  const removeImages = fd.getAll("remove_image").map(Number).filter(Boolean);
  const imageOrder = fd.getAll("image_order").map(Number).filter(Boolean);
  const files = fd.getAll("images").filter((f) => f && typeof f !== "string" && f.size > 0);

  // Upload first (outside the DB transaction).
  const newUrls = [];
  try {
    for (const f of files.slice(0, 12)) newUrls.push(await saveUpload(f, "products"));
  } catch (e) {
    return { error: e.message };
  }

  const removedUrls = [];
  const productId = await transaction(async (tx) => {
    let pid = id;
    const cols = Object.keys(data);
    if (pid) {
      await tx.query(`UPDATE products SET ${cols.map((c) => `${c} = ?`).join(", ")} WHERE id = ?`, [...cols.map((c) => data[c]), pid]);
    } else {
      const res = await tx.query(`INSERT INTO products (${cols.join(",")}) VALUES (${cols.map(() => "?").join(",")})`, cols.map((c) => data[c]));
      pid = res.insertId;
    }
    await tx.query("DELETE FROM product_categories WHERE product_id = ?", [pid]);
    for (const cid of categoryIds) await tx.query("INSERT IGNORE INTO product_categories (product_id, category_id) VALUES (?,?)", [pid, cid]);

    if (removeImages.length) {
      const rows = await tx.query("SELECT id, url FROM product_images WHERE product_id = ? AND id IN (?)", [pid, removeImages]);
      removedUrls.push(...rows.map((r) => r.url));
      await tx.query("DELETE FROM product_images WHERE product_id = ? AND id IN (?)", [pid, removeImages]);
    }
    for (const [i, imgId] of imageOrder.entries()) {
      await tx.query("UPDATE product_images SET sort_order = ? WHERE id = ? AND product_id = ?", [i, imgId, pid]);
    }
    const [{ maxOrder }] = await tx.query("SELECT COALESCE(MAX(sort_order), -1) AS maxOrder FROM product_images WHERE product_id = ?", [pid]);
    for (const [i, url] of newUrls.entries()) {
      await tx.query("INSERT INTO product_images (product_id, url, alt, sort_order) VALUES (?,?,?,?)", [pid, url, name, maxOrder + 1 + i]);
    }
    return pid;
  });
  for (const url of removedUrls) {
    const stillUsed = await queryOne("SELECT id FROM product_images WHERE url = ? LIMIT 1", [url]);
    if (!stillUsed) await deleteFile(url).catch(() => {});
  }
  invalidateStore();
  redirect(`/admin/products/${productId}?saved=1`);
}

export async function deleteProduct(fd) {
  await requireAdmin();
  const id = Number(fd.get("id"));
  const used = await queryOne("SELECT id FROM order_items WHERE product_id = ? LIMIT 1", [id]);
  if (used) {
    // keep order history intact: just hide it
    await query("UPDATE products SET is_active = 0 WHERE id = ?", [id]);
  } else {
    await query("DELETE FROM products WHERE id = ?", [id]);
  }
  invalidateStore();
  redirect(fd.get("return_to") === "packages" ? "/admin/campaign" : "/admin/products");
}

export async function toggleProduct(fd) {
  await requireAdmin();
  await query("UPDATE products SET is_active = 1 - is_active WHERE id = ?", [Number(fd.get("id"))]);
  revalidatePath("/admin", "layout");
  invalidateStore();
}

// ---------------- categories ----------------
export async function saveCategory(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id")) || 0;
  const name = str(fd, "name");
  if (!name) return { error: "Name is required" };
  const parentId = Number(fd.get("parent_id")) || null;
  if (parentId && id) {
    // Walk up from the chosen parent; reaching this category would create a loop.
    let cursor = parentId;
    for (let i = 0; cursor && i < 50; i++) {
      if (cursor === id) return { error: "A category can't be placed inside itself or one of its own sub-categories" };
      cursor = (await queryOne("SELECT parent_id FROM categories WHERE id = ?", [cursor]))?.parent_id;
    }
  }
  let image;
  try {
    image = await saveUpload(fd.get("image"), "categories");
  } catch (e) {
    return { error: e.message };
  }
  const slug = await uniqueSlug("categories", str(fd, "slug") || name, id);
  const vals = [parentId, name, slug, str(fd, "description") || null, num(fd, "sort_order") || 0, bool(fd, "is_active"), bool(fd, "show_in_menu")];
  if (id) {
    await query("UPDATE categories SET parent_id=?, name=?, slug=?, description=?, sort_order=?, is_active=?, show_in_menu=? WHERE id=?", [...vals, id]);
    if (image) await query("UPDATE categories SET image = ? WHERE id = ?", [image, id]);
  } else {
    await query("INSERT INTO categories (parent_id, name, slug, description, sort_order, is_active, show_in_menu, image) VALUES (?,?,?,?,?,?,?,?)", [...vals, image]);
  }
  invalidateStore();
  redirect("/admin/categories?saved=1");
}

export async function deleteCategory(fd) {
  await requireAdmin();
  await query("DELETE FROM categories WHERE id = ?", [Number(fd.get("id"))]);
  invalidateStore();
  redirect("/admin/categories");
}

// ---------------- orders ----------------
export async function updateOrder(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id"));
  const status = str(fd, "status");
  if (!ORDER_STATUSES.includes(status)) return { error: "Invalid status" };
  await query("UPDATE orders SET status = ? WHERE id = ?", [status, id]);
  revalidatePath(`/admin/orders/${id}`);
  return { ok: "Order updated" };
}

export async function markPaidManually(fd) {
  await requireAdmin();
  const id = Number(fd.get("id"));
  await markOrderPaid(id, str(fd, "reference") || null);
  invalidateStore();
  redirect(`/admin/orders/${id}?saved=1`);
}

// ---------------- seasonal campaign ----------------
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;

export async function saveCampaign(_prev, fd) {
  await requireAdmin();
  const current = await getSetting("campaign");

  const name = str(fd, "name");
  const title = str(fd, "title");
  const slug = slugify(str(fd, "slug") || name);
  const starts_at = str(fd, "starts_at");
  const ends_at = str(fd, "ends_at");
  if (!name || !title) return { error: "Campaign name and title are required" };
  if (!slug || RESERVED_SLUGS.has(slug)) return { error: `"${slug}" can't be used as the page URL — please choose another` };
  if ([starts_at, ends_at].some((d) => d && !DATE_RE.test(d))) return { error: "Dates must be valid" };
  if (starts_at && ends_at && ends_at < starts_at) return { error: "End date must be on or after the start date" };

  let hero = current.hero_image;
  try {
    const up = await saveUpload(fd.get("hero_image"), "campaign");
    if (up) hero = up;
  } catch (e) {
    return { error: e.message };
  }
  if (fd.get("remove_hero") === "on") hero = "";

  // Homepage section images (optional): desktop + mobile
  let homeImage = current.home_image || "";
  let homeImageMobile = current.home_image_mobile || "";
  try {
    homeImage = (await saveUpload(fd.get("home_image"), "campaign")) || homeImage;
    homeImageMobile = (await saveUpload(fd.get("home_image_mobile"), "campaign")) || homeImageMobile;
  } catch (e) {
    return { error: e.message };
  }
  if (fd.get("remove_home_image") === "on") homeImage = "";
  if (fd.get("remove_home_image_mobile") === "on") homeImageMobile = "";

  // Remember old URLs so links/ads to the previous slug keep working.
  const previous = new Set(current.previous_slugs || []);
  if (current.slug && current.slug !== slug) previous.add(current.slug);
  previous.delete(slug);

  await saveSetting("campaign", {
    ...current,
    enabled: !!bool(fd, "enabled"),
    name,
    slug,
    previous_slugs: [...previous].slice(-10),
    starts_at,
    ends_at,
    hide_after_end: !!bool(fd, "hide_after_end"),
    show_countdown: !!bool(fd, "show_countdown"),
    hide_packages_when_off: !!bool(fd, "hide_packages_when_off"),
    eyebrow: str(fd, "eyebrow"),
    title,
    subtitle: str(fd, "subtitle"),
    hero_image: hero,
    cta_label: str(fd, "cta_label"),
    body: sanitizeHtml(fd.get("body")),
    packages_heading: str(fd, "packages_heading") || "Packages",
    packages_subheading: str(fd, "packages_subheading"),
    package_label: str(fd, "package_label") || "Package",
    empty_message: str(fd, "empty_message"),
    whatsapp_message: str(fd, "whatsapp_message"),
    show_on_home: !!bool(fd, "show_on_home"),
    home_image: homeImage,
    home_image_mobile: homeImageMobile,
    home_image_alt: str(fd, "home_image_alt"),
    home_title: str(fd, "home_title"),
    home_subtitle: str(fd, "home_subtitle"),
    home_show_packages: !!bool(fd, "home_show_packages"),
    home_eyebrow: str(fd, "home_eyebrow"),
    home_cta: str(fd, "home_cta"),
    show_announcement: !!bool(fd, "show_announcement"),
    announcement: str(fd, "announcement"),
  });
  invalidateStore();
  redirect("/admin/campaign?saved=1");
}

// ---------------- banners ----------------
export async function saveBanner(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id")) || 0;
  let image;
  try {
    image = await saveUpload(fd.get("image"), "banners");
  } catch (e) {
    return { error: e.message };
  }
  if (!id && !image) return { error: "Please choose an image (recommended 1800×718)" };
  const vals = [str(fd, "title") || null, str(fd, "subtitle") || null, str(fd, "link") || null, str(fd, "button_label") || null, num(fd, "sort_order") || 0, bool(fd, "is_active")];
  if (id) {
    await query("UPDATE banners SET title=?, subtitle=?, link=?, button_label=?, sort_order=?, is_active=? WHERE id=?", [...vals, id]);
    if (image) await query("UPDATE banners SET image=? WHERE id=?", [image, id]);
  } else {
    await query("INSERT INTO banners (title, subtitle, link, button_label, sort_order, is_active, image, placement) VALUES (?,?,?,?,?,?,?, 'home_hero')", [...vals, image]);
  }
  invalidateStore();
  redirect("/admin/banners?saved=1");
}

export async function deleteBanner(fd) {
  await requireAdmin();
  await query("DELETE FROM banners WHERE id = ?", [Number(fd.get("id"))]);
  invalidateStore();
  redirect("/admin/banners");
}

// ---------------- pages ----------------
export async function savePage(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id")) || 0;
  const title = str(fd, "title");
  if (!title) return { error: "Title is required" };
  const slug = await uniqueSlug("pages", str(fd, "slug") || title, id);
  const vals = [title, slug, sanitizeHtml(fd.get("body")), str(fd, "meta_description") || null, bool(fd, "is_active"), num(fd, "sort_order") || 0];
  if (id) await query("UPDATE pages SET title=?, slug=?, body=?, meta_description=?, is_active=?, sort_order=? WHERE id=?", [...vals, id]);
  else await query("INSERT INTO pages (title, slug, body, meta_description, is_active, sort_order) VALUES (?,?,?,?,?,?)", vals);
  invalidateStore();
  redirect("/admin/pages?saved=1");
}

export async function deletePage(fd) {
  await requireAdmin();
  await query("DELETE FROM pages WHERE id = ?", [Number(fd.get("id"))]);
  invalidateStore();
  redirect("/admin/pages");
}

// ---------------- showrooms ----------------
export async function saveShowroom(_prev, fd) {
  await requireAdmin();
  const id = Number(fd.get("id")) || 0;
  const vals = [str(fd, "name"), str(fd, "address"), str(fd, "phone") || null, str(fd, "whatsapp") || null, str(fd, "hours") || null, str(fd, "map_url") || null, num(fd, "sort_order") || 0, bool(fd, "is_active")];
  if (!vals[0] || !vals[1]) return { error: "Name and address are required" };
  if (id) await query("UPDATE showrooms SET name=?, address=?, phone=?, whatsapp=?, hours=?, map_url=?, sort_order=?, is_active=? WHERE id=?", [...vals, id]);
  else await query("INSERT INTO showrooms (name, address, phone, whatsapp, hours, map_url, sort_order, is_active) VALUES (?,?,?,?,?,?,?,?)", vals);
  invalidateStore();
  redirect("/admin/showrooms?saved=1");
}

export async function deleteShowroom(fd) {
  await requireAdmin();
  await query("DELETE FROM showrooms WHERE id = ?", [Number(fd.get("id"))]);
  invalidateStore();
  redirect("/admin/showrooms");
}

// ---------------- settings ----------------
export async function saveSettings(_prev, fd) {
  await requireOwner();
  const store = await getSetting("store");
  const shipping = await getSetting("shipping");
  const payments = await getSetting("payments");
  const tracking = await getSetting("tracking");
  await saveSetting("store", {
    ...store,
    name: str(fd, "store_name") || store.name,
    tagline: str(fd, "tagline"),
    email: str(fd, "email"),
    phone: str(fd, "phone"),
    whatsapp: str(fd, "whatsapp"),
    whatsapp_message: str(fd, "whatsapp_message"),
    instagram: str(fd, "instagram"),
    facebook: str(fd, "facebook"),
    tiktok: str(fd, "tiktok"),
  });
  await saveSetting("shipping", {
    ...shipping,
    delivery_lagos_fee: num(fd, "delivery_lagos_fee") || 0,
    delivery_nationwide_fee: num(fd, "delivery_nationwide_fee") || 0,
    free_delivery_threshold: num(fd, "free_delivery_threshold") || 0,
    pickup_enabled: !!bool(fd, "pickup_enabled"),
  });
  await saveSetting("payments", {
    ...payments,
    opay_enabled: !!bool(fd, "opay_enabled"),
    bank_transfer_enabled: !!bool(fd, "bank_transfer_enabled"),
    bank_transfer_details: str(fd, "bank_transfer_details"),
  });
  const gtm = str(fd, "gtm_id").toUpperCase();
  if (gtm && !/^GTM-[A-Z0-9]{4,12}$/.test(gtm)) return { error: "GTM container ID should look like GTM-XXXXXXX" };
  await saveSetting("tracking", { ...tracking, gtm_id: gtm });
  invalidateStore();
  return { ok: "Settings saved" };
}

// ---------------- admin users ----------------
const userSchema = z.object({
  name: z.string().trim().min(1),
  email: z.string().trim().toLowerCase().email(),
  role: z.enum(["owner", "staff"]),
  password: z.string().optional(),
});

export async function saveAdminUser(_prev, fd) {
  const me = await requireOwner();
  const id = Number(fd.get("id")) || 0;
  const parsed = userSchema.safeParse(Object.fromEntries(fd));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const d = parsed.data;
  const active = bool(fd, "is_active");
  if (id === me.id && (!active || d.role !== "owner")) return { error: "You cannot demote or disable yourself" };
  if (!id && (!d.password || d.password.length < 10)) return { error: "Password must be at least 10 characters" };
  if (d.password && d.password.length > 0 && d.password.length < 10) return { error: "Password must be at least 10 characters" };
  try {
    if (id) {
      await query("UPDATE admin_users SET name=?, email=?, role=?, is_active=? WHERE id=?", [d.name, d.email, d.role, active, id]);
      if (d.password) await query("UPDATE admin_users SET password_hash=? WHERE id=?", [await hashPassword(d.password), id]);
    } else {
      await query("INSERT INTO admin_users (name, email, role, is_active, password_hash) VALUES (?,?,?,?,?)", [d.name, d.email, d.role, active, await hashPassword(d.password)]);
    }
  } catch (e) {
    if (e.code === "ER_DUP_ENTRY") return { error: "That email is already in use" };
    throw e;
  }
  redirect("/admin/users?saved=1");
}

export async function changeOwnPassword(_prev, fd) {
  const me = await requireAdmin();
  const row = await queryOne("SELECT password_hash FROM admin_users WHERE id = ?", [me.id]);
  if (!(await checkPassword(str(fd, "current"), row.password_hash))) return { error: "Current password is incorrect" };
  const next = String(fd.get("next") || "");
  if (next.length < 10) return { error: "New password must be at least 10 characters" };
  await query("UPDATE admin_users SET password_hash = ? WHERE id = ?", [await hashPassword(next), me.id]);
  return { ok: "Password changed" };
}
