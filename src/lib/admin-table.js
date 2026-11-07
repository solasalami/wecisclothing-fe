// Pagination and sorting for admin tables, driven by the URL:
//   ?page=2&per=50&sort=total&dir=asc  (plus each page's own filters)
// Sort keys are whitelisted per table, so nothing from the URL reaches SQL directly.

export const PAGE_SIZES = [10, 20, 30, 50, 100];
const DEFAULT_PER = 20;

/**
 * @param sp        awaited searchParams
 * @param sorts     { key: "sql expression" } allowed sort columns
 * @param fallback  ORDER BY used when no sort is chosen (e.g. "id DESC")
 */
export function tableParams(sp, { sorts = {}, fallback = "id DESC", tiebreak = "id DESC" } = {}) {
  const per = PAGE_SIZES.includes(Number(sp.per)) ? Number(sp.per) : DEFAULT_PER;
  const page = Math.max(1, parseInt(sp.page, 10) || 1);
  const sort = Object.hasOwn(sorts, sp.sort) ? sp.sort : null;
  const dir = sp.dir === "asc" ? "asc" : "desc";
  // Empty values (e.g. a guest's registration date) always go last.
  const orderBy = sort ? `(${sorts[sort]}) IS NULL, ${sorts[sort]} ${dir.toUpperCase()}, ${tiebreak}` : fallback;
  return { page, per, offset: (page - 1) * per, sort, dir, orderBy };
}

/** Build "/admin/x?..." keeping the current filters, with some params changed (null removes). */
export function tableHref(basePath, sp, changes = {}) {
  const params = new URLSearchParams();
  for (const [k, v] of Object.entries({ ...sp, ...changes })) {
    if (v === null || v === undefined || v === "") continue;
    params.set(k, String(v));
  }
  const qs = params.toString();
  return qs ? `${basePath}?${qs}` : basePath;
}

// ---------- Date range filters (?from=YYYY-MM-DD&to=YYYY-MM-DD) ----------
// Dates are Lagos calendar days (UTC+1, no daylight saving); the database stores UTC.

const isDay = (v) => typeof v === "string" && /^\d{4}-\d{2}-\d{2}$/.test(v) && !Number.isNaN(Date.parse(`${v}T00:00:00Z`));
const lagosMidnightUtc = (day) => new Date(`${day}T00:00:00+01:00`).toISOString().slice(0, 19).replace("T", " ");

/** Valid { from, to } from the URL (swapped if entered the wrong way round). */
export function dateParams(sp) {
  let from = isDay(sp.from) ? sp.from : "";
  let to = isDay(sp.to) ? sp.to : "";
  if (from && to && from > to) [from, to] = [to, from];
  return { from, to };
}

/**
 * SQL conditions for a date column, inclusive of both days.
 * Returns { where: [...sql], params: [...] } to merge into a query.
 */
export function dateRangeSql(sp, column) {
  const { from, to } = dateParams(sp);
  const where = [];
  const params = [];
  if (from) {
    where.push(`${column} >= ?`);
    params.push(lagosMidnightUtc(from));
  }
  if (to) {
    const next = new Date(Date.parse(`${to}T00:00:00Z`) + 864e5).toISOString().slice(0, 10);
    where.push(`${column} < ?`);
    params.push(lagosMidnightUtc(next));
  }
  return { where, params };
}
