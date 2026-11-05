import "server-only";
import { unstable_rethrow } from "next/navigation";
import { query, queryOne, parseJson } from "./db";
import { DEFAULT_SETTINGS } from "./defaults";

export { DEFAULT_SETTINGS };


export async function getSettings() {
  let rows = [];
  try {
    rows = await query("SELECT `key`, value FROM settings");
  } catch (err) {
    unstable_rethrow(err); // let the "database unavailable" redirect through
    rows = []; // e.g. settings table not migrated yet: fall back to defaults
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
