"use client";
import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useCart } from "./CartProvider";
import ProductImage from "./ProductImage";
import { formatNaira } from "@/lib/format";
import { trackViewItem } from "@/lib/analytics";

/**
 * Add-to-bag for a bundle package: lists each included product with its own size picker.
 * The bundle goes in the bag as one line, with the size chosen for every item.
 */
export default function BundleAddToCart({ product, components }) {
  const { add } = useCart();
  // Items with a single size are picked automatically, like AddToCart does.
  const [sizes, setSizes] = useState(() => Object.fromEntries(components.map((c) => [c.id, c.sizes.length === 1 ? c.sizes[0] : ""])));
  const [qty, setQty] = useState(1);
  const [missing, setMissing] = useState(null);

  const viewed = useRef(null);
  useEffect(() => {
    if (viewed.current === product.id) return;
    viewed.current = product.id;
    trackViewItem(product);
  }, [product]);

  function onAdd() {
    const need = components.find((c) => c.sizes.length && !sizes[c.id]);
    if (need) {
      setMissing(need.id);
      document.getElementById(`bundle-item-${need.id}`)?.scrollIntoView({ behavior: "smooth", block: "center" });
      return;
    }
    setMissing(null);
    const parts = Object.fromEntries(components.map((c) => [c.id, c.sizes.length ? sizes[c.id] : null]));
    const partsLabel = components.map((c) => ({ name: c.name, size: parts[c.id] }));
    add(product, { quantity: qty, parts, partsLabel });
  }

  return (
    <div className="mt-6 space-y-5">
      <div className="border border-gold/40 bg-gold-light/40 p-4">
        <div className="mb-3 flex items-baseline justify-between">
          <p className="label !mb-0 !text-gold-dark">What&apos;s included ({components.length} items)</p>
          {components.some((c) => c.sizes.length) && <Link href="/size-guide" target="_blank" className="text-xs underline">Size guide</Link>}
        </div>
        <ul className="divide-y divide-gold/20">
          {components.map((c) => (
            <li key={c.id} id={`bundle-item-${c.id}`} className="flex gap-3 py-3 first:pt-0 last:pb-0">
              <ProductImage src={c.image} alt={c.name} width={56} height={70} className="h-[70px] w-14 flex-none object-cover" />
              <div className="min-w-0 flex-1">
                <p className="text-sm font-medium">
                  {c.is_active ? <Link href={`/product/${c.slug}`} target="_blank" className="hover:underline">{c.name}</Link> : c.name}
                  <span className="ml-2 font-normal text-muted">{formatNaira(c.price)}</span>
                </p>
                {c.sizes.length > 0 ? (
                  <div className="mt-2">
                    <div className="flex flex-wrap gap-1.5" role="radiogroup" aria-label={`Size for ${c.name}`}>
                      {c.sizes.map((s) => (
                        <button
                          key={s}
                          type="button"
                          role="radio"
                          aria-checked={sizes[c.id] === s}
                          onClick={() => {
                            setSizes((prev) => ({ ...prev, [c.id]: s }));
                            if (missing === c.id) setMissing(null);
                          }}
                          className={`min-w-10 border px-2.5 py-1.5 text-xs transition ${sizes[c.id] === s ? "border-gold bg-gold text-ink" : "border-line bg-white hover:border-gold"}`}
                        >
                          {s}
                        </button>
                      ))}
                    </div>
                    {missing === c.id && <p className="mt-1.5 text-xs text-red-600" role="alert">Choose a size for {c.name}</p>}
                  </div>
                ) : (
                  <p className="mt-1 text-xs text-muted">One size</p>
                )}
              </div>
            </li>
          ))}
        </ul>
      </div>

      {product.in_stock ? (
        <div className="flex gap-3">
          <div className="flex items-center border border-line">
            <button type="button" className="px-3 py-3" onClick={() => setQty((q) => Math.max(1, q - 1))} aria-label="Decrease quantity">−</button>
            <span className="w-8 text-center">{qty}</span>
            <button type="button" className="px-3 py-3" onClick={() => setQty((q) => Math.min(20, q + 1))} aria-label="Increase quantity">+</button>
          </div>
          <button type="button" onClick={onAdd} className="btn-primary flex-1">
            Add package to bag
          </button>
        </div>
      ) : (
        <p className="border border-line bg-soft p-4 text-sm">
          This package is currently unavailable{product.out_of_stock_items?.length ? ` (${product.out_of_stock_items.join(", ")} sold out)` : ""}. Message us on WhatsApp to request it.
        </p>
      )}
    </div>
  );
}
