"use client";
import { useEffect, useRef, useState } from "react";
import { useCart } from "./CartProvider";
import { trackViewItem } from "@/lib/analytics";

export default function AddToCart({ product }) {
  const { add } = useCart();
  const [size, setSize] = useState(product.sizes.length === 1 ? product.sizes[0] : "");
  const [qty, setQty] = useState(1);
  const [error, setError] = useState("");

  const viewed = useRef(null);
  useEffect(() => {
    if (viewed.current === product.id) return; // guard against double effects
    viewed.current = product.id;
    trackViewItem(product);
  }, [product]);

  function onAdd() {
    if (product.sizes.length && !size) {
      setError("Please select a size");
      return;
    }
    setError("");
    add(product, { quantity: qty, size: size || null });
  }

  if (!product.in_stock) {
    return <p className="mt-6 border border-line bg-soft p-4 text-sm">This item is currently sold out. Message us on WhatsApp to request it.</p>;
  }

  return (
    <div className="mt-6 space-y-5">
      {product.sizes.length > 0 && (
        <div>
          <p className="label">Size</p>
          <div className="flex flex-wrap gap-2">
            {product.sizes.map((s) => (
              <button
                key={s}
                type="button"
                onClick={() => setSize(s)}
                className={`min-w-12 border px-3 py-2 text-sm transition ${size === s ? "border-ink bg-ink text-white" : "border-line hover:border-ink"}`}
              >
                {s}
              </button>
            ))}
          </div>
          {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
        </div>
      )}
      <div className="flex gap-3">
        <div className="flex items-center border border-line">
          <button type="button" className="px-3 py-3" onClick={() => setQty((q) => Math.max(1, q - 1))} aria-label="Decrease quantity">−</button>
          <span className="w-8 text-center">{qty}</span>
          <button type="button" className="px-3 py-3" onClick={() => setQty((q) => Math.min(20, q + 1))} aria-label="Increase quantity">+</button>
        </div>
        <button type="button" onClick={onAdd} className="btn-primary flex-1">
          Add to bag
        </button>
      </div>
    </div>
  );
}
