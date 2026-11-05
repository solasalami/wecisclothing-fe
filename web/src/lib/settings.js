import "server-only";
import { query, queryOne, parseJson } from "./db";

export const DEFAULT_SETTINGS = {
  store: {
    name: "Wecis Clothing",
    tagline: "Premium African-inspired fashion for men and women",
    email: "info@wecisclothing.com",
    phone: "+234 803 364 0090",
    whatsapp: "+234 803 364 0090",
    whatsapp_message: "Hello Wecis Clothing, I'd like to make an enquiry.",
    instagram: "",
    facebook: "",
    tiktok: "",
  },
  shipping: {
    delivery_lagos_fee: 5000,
    delivery_nationwide_fee: 10000,
    free_delivery_threshold: 0, // 0 = disabled
    pickup_enabled: true,
  },
  payments: {
    opay_enabled: true,
    bank_transfer_enabled: true,
    bank_transfer_details: "Bank: \nAccount name: Wecis Clothing\nAccount number: \nUse your order number as the payment reference.",
  },
  tracking: {
    gtm_id: "", // overrides NEXT_PUBLIC_GTM_ID when set
  },
  campaign: {
    // Detty December landing page (editable in Admin → Detty December)
    enabled: true,
    slug: "detty-december",
    title: "Detty December 2026",
    subtitle: "Festive outfits & packages for every owambe, concert and family gathering this December.",
    hero_image: "",
    body: "",
    ends_at: "2026-12-31",
    announcement: "Detty December packages are live — order early for delivery before Christmas!",
    show_announcement: true,
  },
};

export async function getSettings() {
  let rows = [];
  try {
    rows = await query("SELECT `key`, value FROM settings");
  } catch {
    rows = [];
  }
  const out = structuredClone(DEFAULT_SETTINGS);
  for (const r of rows) {
    const v = parseJson(r.value, {});
    out[r.key] = typeof v === "object" && !Array.isArray(v) ? { ...(out[r.key] || {}), ...v } : v;
  }
  out.tracking.gtm_id = out.tracking.gtm_id || process.env.NEXT_PUBLIC_GTM_ID || "";
  return out;
}

export async function getSetting(key) {
  const row = await queryOne("SELECT value FROM settings WHERE `key` = ?", [key]);
  return { ...(DEFAULT_SETTINGS[key] || {}), ...parseJson(row?.value, {}) };
}

export async function saveSetting(key, value) {
  await query(
    "INSERT INTO settings (`key`, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = VALUES(value)",
    [key, JSON.stringify(value)]
  );
}
