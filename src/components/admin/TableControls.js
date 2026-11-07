import Link from "next/link";
import { PAGE_SIZES, tableHref } from "@/lib/admin-table";

/**
 * Sortable column header. First click sorts newest / highest first;
 * clicking the active column flips the direction. Always returns to page 1.
 */
export function SortHeader({ label, column, basePath, sp, table, align = "left", className = "" }) {
  const active = table.sort === column;
  const nextDir = active && table.dir === "desc" ? "asc" : "desc";
  const arrow = active ? (table.dir === "desc" ? "↓" : "↑") : "↕";
  return (
    <th className={`${align === "right" ? "text-right" : ""} ${className}`} aria-sort={active ? (table.dir === "desc" ? "descending" : "ascending") : undefined}>
      <Link
        href={tableHref(basePath, sp, { sort: column, dir: nextDir, page: null })}
        className={`inline-flex items-center gap-1 hover:text-ink ${active ? "text-ink" : ""}`}
        title={`Sort by ${label.toLowerCase()}`}
      >
        {label}
        <span aria-hidden="true" className={active ? "text-gold-dark" : "opacity-40"}>{arrow}</span>
      </Link>
    </th>
  );
}

/** Hidden inputs so a filter form keeps the chosen page size and sort (and starts at page 1). */
export function KeepTableState({ table }) {
  return (
    <>
      <input type="hidden" name="per" value={table.per} />
      {table.sort && <input type="hidden" name="sort" value={table.sort} />}
      {table.sort && <input type="hidden" name="dir" value={table.dir} />}
    </>
  );
}

function pageList(page, pages) {
  const set = new Set([1, pages, page - 1, page, page + 1].filter((n) => n >= 1 && n <= pages));
  const sorted = [...set].sort((a, b) => a - b);
  const out = [];
  sorted.forEach((n, i) => {
    if (i && n - sorted[i - 1] > 1) out.push("…");
    out.push(n);
  });
  return out;
}

/** "Showing 21 to 40 of 132", rows-per-page choice and page links. */
export function Pagination({ basePath, sp, table, total }) {
  const pages = Math.max(1, Math.ceil(total / table.per));
  const page = Math.min(table.page, pages);
  const from = total ? (page - 1) * table.per + 1 : 0;
  const to = Math.min(page * table.per, total);
  const link = "min-w-8 border border-line px-2 py-1 text-center hover:border-gold";
  return (
    <div className="flex flex-wrap items-center justify-between gap-3 border-t border-line p-3 text-sm">
      <p className="text-muted">{total ? `Showing ${from} to ${to} of ${total}` : "No results"}</p>
      <div className="flex items-center gap-2">
        <span className="text-xs uppercase tracking-wider text-muted">Rows</span>
        {PAGE_SIZES.map((n) => (
          <Link
            key={n}
            href={tableHref(basePath, sp, { per: n, page: null })}
            className={`${link} ${n === table.per ? "border-gold bg-gold text-ink" : ""}`}
            aria-current={n === table.per ? "true" : undefined}
          >
            {n}
          </Link>
        ))}
      </div>
      {pages > 1 && (
        <nav className="flex items-center gap-1" aria-label="Pages">
          {page > 1 ? <Link href={tableHref(basePath, sp, { page: page - 1 })} className={link}>Prev</Link> : <span className={`${link} opacity-40`}>Prev</span>}
          {pageList(page, pages).map((n, i) =>
            n === "…" ? (
              <span key={`gap${i}`} className="px-1 text-muted">…</span>
            ) : (
              <Link key={n} href={tableHref(basePath, sp, { page: n })} className={`${link} ${n === page ? "border-gold bg-gold text-ink" : ""}`} aria-current={n === page ? "page" : undefined}>
                {n}
              </Link>
            )
          )}
          {page < pages ? <Link href={tableHref(basePath, sp, { page: page + 1 })} className={link}>Next</Link> : <span className={`${link} opacity-40`}>Next</span>}
        </nav>
      )}
    </div>
  );
}
