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
