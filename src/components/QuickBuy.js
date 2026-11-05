"use client";
import { useState } from "react";
import { useCart } from "./CartProvider";

/**
 * Gold "Quick buy" bar that slides up over the product photo on hover (desktop).
 * Products with sizes show a size picker first; one-size items go straight to the bag.
 */
export default function QuickBuy({ product }) {
  const { add } = useCart();
  const [picking, setPicking] = useState(false);

  function onQuickBuy() {
    if (product.sizes.length > 1) setPicking(true);
    else add(product, { quantity: 1, size: product.sizes[0] || null });
  }

  function pick(size) {
    add(product, { quantity: 1, size });
    setPicking(false);
  }

  return (
    <div
      className={`absolute inset-x-3 bottom-3 hidden transition duration-300 md:block ${
        picking ? "translate-y-0 opacity-100" : "translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 focus-within:translate-y-0 focus-within:opacity-100"
      }`}
      onMouseLeave={() => setPicking(false)}
    >
      {picking ? (
        <div className="bg-white/95 p-3 shadow-lg backdrop-blur">
          <p className="mb-2 text-center text-[11px] uppercase tracking-[0.18em] text-muted">Select size</p>
          <div className="flex flex-wrap justify-center gap-1.5">
            {product.sizes.map((s) => (
              <button
                key={s}
                type="button"
                onClick={() => pick(s)}
                className="min-w-10 border border-line px-2 py-1.5 text-xs transition hover:border-gold hover:bg-gold"
              >
                {s}
              </button>
            ))}
          </div>
        </div>
      ) : (
        <button type="button" onClick={onQuickBuy} className="btn-primary w-full !py-3.5 text-sm" aria-label={`Quick buy ${product.name}`}>
          Quick buy
        </button>
      )}
    </div>
  );
}
