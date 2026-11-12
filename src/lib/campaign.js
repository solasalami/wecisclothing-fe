// Seasonal campaign helpers (pure functions, safe on server and client).

/** Lagos is UTC+1 all year (no DST). */
const LAGOS_OFFSET = "+01:00";

export const RESERVED_SLUGS = new Set([
  "shop", "category", "product", "cart", "checkout", "account", "contact", "contact-us", "pages", "size-guide",
  "index.php", "maintenance", "promos",
  "admin", "api", "media", "sitemap.xml", "robots.txt", "icon.png", "_next", "favicon.ico",
]);

function startOf(date) {
  return date ? new Date(`${date}T00:00:00${LAGOS_OFFSET}`).getTime() : null;
}
function endOf(date) {
  return date ? new Date(`${date}T23:59:59${LAGOS_OFFSET}`).getTime() : null;
}

/**
 * Status of the campaign right now:
 *  "off"       – switched off in admin
 *  "scheduled" – enabled, start date in the future
 *  "live"      – visible on the site
 *  "ended"     – end date passed and hide_after_end is on
 */
export function campaignStatus(c, now = Date.now()) {
  if (!c?.enabled) return "off";
  const start = startOf(c.starts_at);
  const end = endOf(c.ends_at);
  if (start && now < start) return "scheduled";
  if (end && now > end && c.hide_after_end) return "ended";
  return "live";
}

export const isCampaignLive = (c, now) => campaignStatus(c, now) === "live";

// Every campaign uses this one permanent address; old seasonal addresses redirect to it.
export const PROMOS_PATH = "/promos";

/** Address of the campaign landing page (the same for every campaign). */
export const campaignPath = () => PROMOS_PATH;

/** Shop menu and footer text for the campaign link (Admin, Seasonal campaign, Menu label). */
export const campaignMenuLabel = (c) => String(c?.menu_label || "").trim() || "Promos";

/** End timestamp for the countdown, or null if there shouldn't be one. */
export function countdownEnd(c, now = Date.now()) {
  const end = endOf(c.ends_at);
  return c.show_countdown && end && end > now ? end : null;
}
