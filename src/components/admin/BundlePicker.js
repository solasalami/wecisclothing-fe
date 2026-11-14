"use client";
import { useMemo, useState } from "react";
import { formatNaira } from "@/lib/format";

/**
 * Admin, package editor: the real products a bundle package is made of. Shoppers pick a
 * size for each one; the bundle sells as one line at the package price.
 * `products`: every normal product [{ id, name, price, sizes, image, is_active }].
 */
// mode: "fixed" (every item is in the bundle) or "pick" (the list shoppers choose from).
export default function BundlePicker({ products, initial = [], mode = "fixed" }) {
  const byId = useMemo(() => new Map(products.map((p) => [p.id, p])), [products]);
  const [ids, setIds] = useState(() => initial.filter((id) => byId.has(id)));
  const [search, setSearch] = useState("");

  const picked = ids.map((id) => byId.get(id));
  const worth = picked.reduce((sum, p) => sum + Number(p.price), 0);
  const q = search.trim().toLowerCase();
  const matches = q ? products.filter((p) => !ids.includes(p.id) && p.name.toLowerCase().includes(q)).slice(0, 8) : [];

  const move = (i, d) =>
    setIds((prev) => {
      const next = [...prev];
      const j = i + d;
      if (j < 0 || j >= next.length) return prev;
      [next[i], next[j]] = [next[j], next[i]];
      return next;
    });

  return (
    <div className="space-y-3">
      {ids.map((id) => <input key={id} type="hidden" name="component_ids" value={id} />)}
      {picked.length > 0 ? (
        <ul className="divide-y divide-line border border-line">
          {picked.map((p, i) => (
            <li key={p.id} className="flex items-center gap-3 p-2 text-sm">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              {p.image ? <img src={p.image} alt="" className="h-12 w-10 flex-none object-cover" /> : <span className="h-12 w-10 flex-none bg-soft" />}
              <div className="min-w-0 flex-1">
                <p className="truncate font-medium">
                  {p.name} {!p.is_active && <span className="text-xs font-normal text-muted">(hidden from shop)</span>}
                </p>
                <p className="text-xs text-muted">
                  {formatNaira(p.price)} · {p.sizes.length ? `Sizes: ${p.sizes.join(", ")}` : "One size"}
                </p>
              </div>
              <div className="flex flex-none items-center gap-1 text-xs">
                <button type="button" onClick={() => move(i, -1)} disabled={i === 0} className="px-1.5 py-1 disabled:opacity-30" aria-label={`Move ${p.name} up`}>↑</button>
                <button type="button" onClick={() => move(i, 1)} disabled={i === picked.length - 1} className="px-1.5 py-1 disabled:opacity-30" aria-label={`Move ${p.name} down`}>↓</button>
                <button type="button" onClick={() => setIds((prev) => prev.filter((x) => x !== p.id))} className="ml-1 text-red-600 underline">Remove</button>
              </div>
            </li>
          ))}
        </ul>
      ) : (
        <p className="border border-dashed border-line p-3 text-sm text-muted">
          {mode === "pick"
            ? "No outfits listed yet. Add them here, or from Admin, Products (the Packages column on each product)."
            : "No products added. Without products this is a simple package: one item with the \u201cWhat\u2019s included\u201d list below."}
        </p>
      )}
      {picked.length > 0 && mode === "fixed" && (
        <p className="text-sm">
          Items worth <strong>{formatNaira(worth)}</strong> if bought separately. Set the package price below this to show shoppers the saving.
        </p>
      )}
      <div className="relative">
        <label className="label" htmlFor="bundle-search">Add a product</label>
        <input
          id="bundle-search"
          type="search"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") e.preventDefault(); // don't submit the whole form
          }}
          placeholder="Type a product name…"
          className="input"
          autoComplete="off"
        />
        {matches.length > 0 && (
          <ul className="absolute inset-x-0 top-full z-10 max-h-72 overflow-y-auto border border-line bg-white shadow-lg">
            {matches.map((p) => (
              <li key={p.id}>
                <button
                  type="button"
                  onClick={() => {
                    setIds((prev) => [...prev, p.id]);
                    setSearch("");
                  }}
                  className="flex w-full items-center justify-between gap-3 px-3 py-2 text-left text-sm hover:bg-soft"
                >
                  <span className="truncate">
                    {p.name} {!p.is_active && <span className="text-xs text-muted">(hidden)</span>}
                  </span>
                  <span className="flex-none text-xs text-muted">{formatNaira(p.price)}</span>
                </button>
              </li>
            ))}
          </ul>
        )}
        {q && !matches.length && <p className="mt-1 text-xs text-muted">No matching products.</p>}
      </div>
      <p className="text-xs text-muted">
        {mode === "pick"
          ? `${picked.length} outfit${picked.length === 1 ? "" : "s"} listed. Shoppers choose from these and pick a size for each. Products hidden from the shop can still be listed.`
          : "Shoppers choose a size for each item. Products hidden from the shop can still be part of a package."}
      </p>
    </div>
  );
}
