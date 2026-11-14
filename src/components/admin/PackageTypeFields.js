"use client";
import { useState } from "react";
import BundlePicker from "./BundlePicker";
import { formatNaira } from "@/lib/format";

const TYPES = [
  ["simple", "Simple package", "One item with a written list of what's included."],
  ["fixed", "Fixed items", "Set products sold together; the shopper picks a size for each."],
  ["pick", "Shopper picks from a list", "The shopper chooses a number of outfits from a list, at a fixed price per number."],
];

/**
 * Admin, package editor: what kind of package this is, and its fields.
 * categories: flat [{ id, path, product_count }]; pick: { categoryId, min, max, prices } or null.
 */
export default function PackageTypeFields({ initialType, bundleProducts, componentIds, categories, pick }) {
  const [type, setType] = useState(initialType);
  const [categoryId, setCategoryId] = useState(pick?.categoryId ? String(pick.categoryId) : "");
  const [min, setMin] = useState(pick?.min || 3);
  const [max, setMax] = useState(pick?.max || 5);
  const [prices, setPrices] = useState(() => Object.fromEntries(Object.entries(pick?.prices || {}).map(([k, v]) => [k, String(v)])));

  const lo = Math.max(1, Math.min(Number(min) || 1, 10));
  const hi = Math.max(lo, Math.min(Number(max) || lo, 10));
  const counts = Array.from({ length: hi - lo + 1 }, (_, i) => lo + i);
  const cat = categories.find((c) => String(c.id) === categoryId);

  return (
    <div className="space-y-4">
      <input type="hidden" name="package_type" value={type} />
      <div className="grid gap-2 sm:grid-cols-3" role="radiogroup" aria-label="Package type">
        {TYPES.map(([id, label, hint]) => (
          <button
            key={id}
            type="button"
            role="radio"
            aria-checked={type === id}
            onClick={() => setType(id)}
            className={`border p-3 text-left text-sm transition ${type === id ? "border-gold bg-gold-light/50" : "border-line hover:border-gold"}`}
          >
            <span className="block font-semibold">{label}</span>
            <span className="mt-1 block text-xs text-muted">{hint}</span>
          </button>
        ))}
      </div>

      {/* One list for both: the bundle's items (fixed) or the outfits shoppers choose from (pick). */}
      {(type === "fixed" || type === "pick") && (
        <div>
          {type === "pick" && <p className="label">Outfits shoppers can choose from</p>}
          <BundlePicker products={bundleProducts} initial={componentIds} mode={type} />
        </div>
      )}

      {type === "pick" && (
        <div className="space-y-4">
          <div>
            <label className="label" htmlFor="pick_category_id">Also include a whole category (optional)</label>
            <select id="pick_category_id" name="pick_category_id" value={categoryId} onChange={(e) => setCategoryId(e.target.value)} className="input">
              <option value="">No category, just the list above</option>
              {categories.map((c) => (
                <option key={c.id} value={c.id}>{c.path}</option>
              ))}
            </select>
            <p className="mt-1 text-xs text-muted">
              {cat
                ? `Adds the ${cat.pool_count} visible product${cat.pool_count === 1 ? "" : "s"} in this category (and its sub-categories) to the list above, including any added to the category later.`
                : "Handy for big collections: put the outfits in a category (Admin, Products, Add to category) and choose it here."}
            </p>
          </div>
          <div className="grid max-w-sm grid-cols-2 gap-4">
            <div>
              <label className="label" htmlFor="pick_min">Fewest outfits</label>
              <input id="pick_min" name="pick_min" type="number" min="1" max="10" required value={min} onChange={(e) => setMin(e.target.value)} className="input" />
            </div>
            <div>
              <label className="label" htmlFor="pick_max">Most outfits</label>
              <input id="pick_max" name="pick_max" type="number" min="1" max="10" required value={max} onChange={(e) => setMax(e.target.value)} className="input" />
            </div>
          </div>
          <div>
            <p className="label">Price for each number of outfits (₦)</p>
            <div className="grid gap-3 sm:grid-cols-3">
              {counts.map((n) => (
                <div key={n}>
                  <label className="mb-1 block text-xs text-muted" htmlFor={`pick_price_${n}`}>{n} outfits</label>
                  <input
                    id={`pick_price_${n}`}
                    name={`pick_price_${n}`}
                    type="number"
                    min="1"
                    step="1"
                    required
                    value={prices[n] ?? ""}
                    onChange={(e) => setPrices((p) => ({ ...p, [n]: e.target.value }))}
                    className="input"
                  />
                </div>
              ))}
            </div>
            <p className="mt-1 text-xs text-muted">
              The shopper pays this price whichever outfits they pick, and can pick the same outfit more than once.
              {Number(prices[lo]) > 0 && ` Shown in the shop as “From ${formatNaira(prices[lo])}”.`}
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
