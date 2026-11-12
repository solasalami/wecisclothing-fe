"use client";
import Link from "next/link";
import { useEffect, useRef } from "react";
import { useCart } from "./CartProvider";
import ProductImage from "./ProductImage";
import { formatNaira } from "@/lib/format";
import { trackViewCart } from "@/lib/analytics";
import { componentsText } from "@/lib/bundle-format";

export default function CartView() {
  const { lines, subtotal, ready, update, remove } = useCart();
  const tracked = useRef(false);
  useEffect(() => {
    if (ready && !tracked.current && lines.length) {
      tracked.current = true;
      trackViewCart(lines, subtotal);
    }
  }, [ready, lines, subtotal]);

  if (!ready) return <div className="min-h-[50vh]" />;
  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <h1 className="mb-8 text-4xl">Your bag</h1>
      {lines.length === 0 ? (
        <div className="py-10 text-center">
          <p className="text-muted">Your bag is empty.</p>
          <Link href="/shop" className="btn-primary mt-6">Continue shopping</Link>
        </div>
      ) : (
        <div className="grid gap-10 lg:grid-cols-[1fr_320px]">
          <ul className="divide-y divide-line border-y border-line">
            {lines.map((l) => (
              <li key={l.key} className="flex gap-4 py-5">
                <ProductImage src={l.image} alt={l.name} width={96} height={120} className="h-30 w-24 flex-none object-cover" />
                <div className="flex flex-1 flex-col justify-between gap-2 sm:flex-row">
                  <div>
                    <Link href={`/product/${l.slug}`} className="font-medium hover:text-gold-dark">{l.name}</Link>
                    {l.size && <p className="text-sm text-muted">Size: {l.size}</p>}
                    {l.partsLabel && <p className="max-w-md text-sm text-muted">Includes: {componentsText(l.partsLabel)}</p>}
                    <p className="text-sm">{formatNaira(l.price)}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <div className="flex items-center border border-line">
                      <button className="px-3 py-2" onClick={() => update(l.key, l.quantity - 1)} aria-label="Decrease">−</button>
                      <span className="w-8 text-center">{l.quantity}</span>
                      <button className="px-3 py-2" onClick={() => update(l.key, l.quantity + 1)} aria-label="Increase">+</button>
                    </div>
                    <span className="w-28 text-right font-medium">{formatNaira(l.price * l.quantity)}</span>
                    <button onClick={() => remove(l.key)} className="text-xs text-muted underline">Remove</button>
                  </div>
                </div>
              </li>
            ))}
          </ul>
          <aside className="h-fit bg-soft p-6">
            <div className="flex justify-between text-lg">
              <span>Subtotal</span>
              <span className="font-medium">{formatNaira(subtotal)}</span>
            </div>
            <p className="mt-2 text-xs text-muted">VAT and delivery calculated at checkout. Free pick-up from our Ikeja and VI showrooms.</p>
            <Link href="/checkout" className="btn-primary mt-6 w-full">Checkout</Link>
            <Link href="/shop" className="mt-3 block text-center text-sm underline">Continue shopping</Link>
          </aside>
        </div>
      )}
    </div>
  );
}
