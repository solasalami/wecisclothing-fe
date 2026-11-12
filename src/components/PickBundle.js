"use client";
import { useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import { useCart } from "./CartProvider";
import ProductImage from "./ProductImage";
import { formatNaira } from "@/lib/format";
import { pickTiers } from "@/lib/bundle-format";
import { trackViewItem } from "@/lib/analytics";

/**
 * Pick-your-own bundle: the shopper chooses between pick.min and pick.max outfits from the
 * pool (the same outfit may be chosen twice, e.g. in two sizes), then adds the set to the
 * bag as one line at the price for that number.
 */
export default function PickBundle({ product, pick }) {
  const { add } = useCart();
  const tiers = useMemo(() => pickTiers(pick), [pick]);
  const byId = useMemo(() => new Map(pick.pool.map((o) => [o.id, o])), [pick.pool]);
  const [sizes, setSizes] = useState({}); // outfit id -> size chosen on its card
  const [picks, setPicks] = useState([]); // [{ uid, productId, size }]
  const [hint, setHint] = useState(null); // outfit id whose size is missing
  const uid = useRef(0);

  const viewed = useRef(null);
  useEffect(() => {
    if (viewed.current === product.id) return;
    viewed.current = product.id;
    trackViewItem(product);
  }, [product]);

  const count = picks.length;
  const full = count >= pick.max;
  const price = tiers.find((t) => t.count === count)?.price ?? null;
  const next = tiers.find((t) => t.count === count + 1);
  const worth = picks.reduce((sum, p) => sum + (byId.get(p.productId)?.price || 0), 0);
  const range = pick.min === pick.max ? `${pick.min}` : `${pick.min} to ${pick.max}`;

  function addPick(o) {
    if (full) return;
    const size = o.sizes.length === 1 ? o.sizes[0] : sizes[o.id];
    if (o.sizes.length && !size) {
      setHint(o.id);
      return;
    }
    setHint(null);
    setPicks((prev) => [...prev, { uid: ++uid.current, productId: o.id, size: size || null }]);
  }

  function addToBag() {
    if (!price) return;
    // The bag shows the price for this number of outfits (checkout re-prices it on the server).
    add({ ...product, price }, {
      quantity: 1,
      picks: picks.map(({ productId, size }) => ({ productId, size })),
      partsLabel: picks.map(({ productId, size }) => ({ name: byId.get(productId)?.name || "Outfit", size })),
    });
    setPicks([]);
  }

  return (
    <div className="mt-6">
      <div className="border border-gold/40 bg-gold-light/40 p-4">
        <p className="label !mb-1 !text-gold-dark">Pick {range} outfits</p>
        <p className="text-sm">
          {tiers.map((t, i) => (
            <span key={t.count}>
              {i > 0 && " · "}
              <strong>{t.count}</strong> for {formatNaira(t.price)}
            </span>
          ))}
        </p>
        <p className="mt-1 text-xs text-muted">Choose from {pick.pool.length} outfits below. You can pick the same outfit more than once, in different sizes.</p>
      </div>

      {/* Your picks: sticky so it stays in view while scrolling the outfits. */}
      <div className="sticky top-24 z-10 mt-4 border border-line bg-white p-4 shadow-sm" aria-live="polite">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <p className="text-sm font-semibold">
            Your picks: {count} of {range}
          </p>
          {price ? (
            <p className="text-sm">
              <strong>{formatNaira(price)}</strong>
              {worth > price && (
                <span className="ml-2 text-muted">
                  worth <span className="line-through">{formatNaira(worth)}</span>
                  <span className="ml-1 text-green-700">save {formatNaira(worth - price)}</span>
                </span>
              )}
            </p>
          ) : (
            <p className="text-sm text-muted">{count < pick.min ? `Pick ${pick.min - count} more` : ""}</p>
          )}
        </div>
        {picks.length > 0 && (
          <ul className="mt-3 flex flex-wrap gap-2">
            {picks.map((p) => {
              const o = byId.get(p.productId);
              return (
                <li key={p.uid} className="flex items-center gap-2 border border-line bg-soft py-1 pl-1 pr-2 text-xs">
                  <ProductImage src={o?.image} alt="" width={28} height={36} className="h-9 w-7 object-cover" />
                  <span>
                    {o?.name}
                    {p.size && <span className="text-muted"> ({p.size})</span>}
                  </span>
                  <button type="button" onClick={() => setPicks((prev) => prev.filter((x) => x.uid !== p.uid))} className="ml-1 text-muted hover:text-red-600" aria-label={`Remove ${o?.name}`}>
                    ✕
                  </button>
                </li>
              );
            })}
          </ul>
        )}
        {next && count >= pick.min && <p className="mt-2 text-xs text-green-700">Add 1 more for {formatNaira(next.price)} in total.</p>}
        <button type="button" onClick={addToBag} disabled={!price} className="btn-primary mt-3 w-full disabled:opacity-40">
          {price ? `Add ${count} outfits to bag, ${formatNaira(price)}` : `Pick ${range} outfits to continue`}
        </button>
      </div>

      <ul className="mt-6 grid grid-cols-2 gap-4 sm:grid-cols-3">
        {pick.pool.map((o) => {
          const chosen = picks.filter((p) => p.productId === o.id).length;
          return (
            <li key={o.id} className={`flex flex-col border p-2 ${chosen ? "border-gold" : "border-line"} ${o.in_stock ? "" : "opacity-50"}`}>
              <div className="relative">
                <ProductImage src={o.image} alt={o.name} width={300} height={400} className="aspect-[3/4] w-full object-cover" />
                {chosen > 0 && <span className="absolute right-2 top-2 bg-gold px-2 py-0.5 text-xs font-semibold text-ink">{chosen} picked</span>}
              </div>
              <Link href={`/product/${o.slug}`} target="_blank" className="mt-2 text-sm leading-snug hover:underline">{o.name}</Link>
              <p className="text-xs text-muted">{formatNaira(o.price)} on its own</p>
              {o.in_stock ? (
                <>
                  {o.sizes.length > 1 && (
                    <select
                      value={sizes[o.id] || ""}
                      onChange={(e) => {
                        setSizes((s) => ({ ...s, [o.id]: e.target.value }));
                        if (hint === o.id) setHint(null);
                      }}
                      className="input mt-2 !py-1.5 text-sm"
                      aria-label={`Size for ${o.name}`}
                    >
                      <option value="">Size…</option>
                      {o.sizes.map((s) => <option key={s} value={s}>{s}</option>)}
                    </select>
                  )}
                  {hint === o.id && <p className="mt-1 text-xs text-red-600" role="alert">Choose a size first</p>}
                  <button type="button" onClick={() => addPick(o)} disabled={full} className="btn-outline mt-2 !py-1.5 !text-xs disabled:opacity-40">
                    {full ? `Max ${pick.max} picked` : chosen ? "Add another" : "Pick this"}
                  </button>
                </>
              ) : (
                <p className="mt-2 text-xs text-muted">Sold out</p>
              )}
            </li>
          );
        })}
      </ul>
      {!pick.pool.length && <p className="mt-6 text-sm text-muted">Outfits for this package are coming soon. Message us on WhatsApp to reserve yours.</p>}
    </div>
  );
}
