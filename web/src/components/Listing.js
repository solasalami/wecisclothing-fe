import Link from "next/link";
import ProductGrid from "./ProductGrid";

const SORT_OPTIONS = [
  ["default", "Featured"],
  ["newest", "Newest"],
  ["price_asc", "Price: low to high"],
  ["price_desc", "Price: high to low"],
  ["popular", "Most popular"],
];

/** Shared listing UI: sub-category chips, sort (GET form, works without JS), pagination. */
export default function Listing({ basePath, title, intro, subcategories = [], result, page, perPage, sort, q }) {
  const pages = Math.max(1, Math.ceil(result.total / perPage));
  const qs = (p) => {
    const sp = new URLSearchParams();
    if (q) sp.set("q", q);
    if (sort && sort !== "default") sp.set("sort", sort);
    if (p > 1) sp.set("page", p);
    const s = sp.toString();
    return s ? `${basePath}?${s}` : basePath;
  };
  return (
    <div className="mx-auto max-w-7xl px-4 py-10">
      <div className="mb-8 text-center">
        <h1 className="text-4xl">{title}</h1>
        {intro && <p className="mx-auto mt-3 max-w-2xl text-muted">{intro}</p>}
      </div>
      {subcategories.length > 0 && (
        <div className="mb-8 flex flex-wrap justify-center gap-2">
          {subcategories.map((c) => (
            <Link key={c.slug} href={`/category/${c.slug}`} className="border border-line px-3 py-1.5 text-xs uppercase tracking-wider hover:border-ink">
              {c.name}
            </Link>
          ))}
        </div>
      )}
      <div className="mb-6 flex items-center justify-between gap-4 border-y border-line py-3 text-sm">
        <span className="text-muted">{result.total} {result.total === 1 ? "item" : "items"}</span>
        <form action={basePath} className="flex items-center gap-2">
          {q && <input type="hidden" name="q" value={q} />}
          <label htmlFor="sort" className="text-muted">Sort</label>
          <select id="sort" name="sort" defaultValue={sort || "default"} className="border border-line bg-white px-2 py-1.5">
            {SORT_OPTIONS.map(([v, l]) => <option key={v} value={v}>{l}</option>)}
          </select>
          <button className="border border-ink px-3 py-1.5 text-xs uppercase">Apply</button>
        </form>
      </div>
      <ProductGrid products={result.items} priorityCount={4} />
      {pages > 1 && (
        <nav className="mt-12 flex justify-center gap-2" aria-label="Pagination">
          {Array.from({ length: pages }, (_, i) => i + 1).map((p) => (
            <Link key={p} href={qs(p)} className={`flex h-10 w-10 items-center justify-center border ${p === page ? "border-ink bg-ink text-white" : "border-line"}`}>
              {p}
            </Link>
          ))}
        </nav>
      )}
    </div>
  );
}
