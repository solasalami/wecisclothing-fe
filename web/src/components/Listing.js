import Link from "next/link";
import ProductGrid from "./ProductGrid";
import { excerpt, toParagraphs, tidyText } from "@/lib/format";

const SORT_OPTIONS = [
  ["default", "Featured"],
  ["newest", "Newest"],
  ["price_asc", "Price: low to high"],
  ["price_desc", "Price: high to low"],
  ["popular", "Most popular"],
];

/** Shared listing UI: sub-category chips, sort (GET form, works without JS), pagination. */
export default function Listing({ basePath, title, intro, aboutTitle, subcategories = [], result, page, perPage, sort, q }) {
  // Short intro above the products; the full text (if longer) sits below them, left-aligned.
  const short = intro ? excerpt(intro, 170) : "";
  const full = intro ? toParagraphs(intro) : [];
  const hasMore = full.length && tidyText(full.join(" ")).length > short.length + 10;
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
        {short && (
          <p className="mx-auto mt-3 max-w-2xl text-[15px] leading-relaxed text-muted">
            {short}
            {hasMore && (
              <>
                {" "}
                <a href="#about" className="whitespace-nowrap text-gold-dark underline underline-offset-2 hover:text-ink">Read more</a>
              </>
            )}
          </p>
        )}
      </div>
      {subcategories.length > 0 && (
        <div className="mb-8 flex flex-wrap justify-center gap-2">
          {subcategories.map((c) => (
            <Link key={c.slug} href={`/category/${c.slug}`} className="border border-line px-3 py-1.5 text-xs uppercase tracking-[0.15em] hover:border-gold">
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
          <button className="border border-gold px-3 py-1.5 text-xs uppercase tracking-[0.15em] hover:bg-gold">Apply</button>
        </form>
      </div>
      <ProductGrid products={result.items} priorityCount={4} />
      {pages > 1 && (
        <nav className="mt-12 flex justify-center gap-2" aria-label="Pagination">
          {Array.from({ length: pages }, (_, i) => i + 1).map((p) => (
            <Link key={p} href={qs(p)} className={`flex h-10 w-10 items-center justify-center border ${p === page ? "border-gold bg-gold text-ink" : "border-line"}`}>
              {p}
            </Link>
          ))}
        </nav>
      )}
      {hasMore && (
        <section id="about" className="mx-auto mt-20 max-w-3xl scroll-mt-32 border-t border-line pt-12">
          <h2 className="mb-5 text-3xl">{aboutTitle || `About ${title}`}</h2>
          <div className="space-y-4 text-[15px] leading-7 text-ink/75">
            {full.map((para, i) => <p key={i}>{para}</p>)}
          </div>
        </section>
      )}
    </div>
  );
}
