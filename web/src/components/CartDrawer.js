"use client";
import Link from "next/link";
import { useCart } from "./CartProvider";
import { CloseIcon } from "./icons";
import { formatNaira } from "@/lib/format";
import ProductImage from "./ProductImage";

export default function CartDrawer() {
  const { lines, subtotal, drawerOpen, setDrawerOpen, update, remove } = useCart();
  if (!drawerOpen) return null;
  return (
    <div className="fixed inset-0 z-[60]">
      <div className="absolute inset-0 bg-black/40" onClick={() => setDrawerOpen(false)} />
      <aside className="absolute right-0 top-0 flex h-full w-[420px] max-w-[92%] flex-col bg-white">
        <div className="flex items-center justify-between border-b border-line p-5">
          <h2 className="text-xl">Your bag</h2>
          <button onClick={() => setDrawerOpen(false)} aria-label="Close cart">
            <CloseIcon />
          </button>
        </div>
        <div className="flex-1 overflow-y-auto p-5">
          {lines.length === 0 ? (
            <p className="text-muted">Your bag is empty.</p>
          ) : (
            <ul className="space-y-5">
              {lines.map((l) => (
                <li key={l.key} className="flex gap-4">
                  <ProductImage src={l.image} alt={l.name} className="h-24 w-20 flex-none object-cover" width={80} height={96} />
                  <div className="flex-1 text-sm">
                    <Link href={`/product/${l.slug}`} onClick={() => setDrawerOpen(false)} className="font-medium hover:text-brand-dark">
                      {l.name}
                    </Link>
                    {l.size && <p className="text-muted">Size: {l.size}</p>}
                    <p className="mt-1">{formatNaira(l.price)}</p>
                    <div className="mt-2 flex items-center gap-3">
                      <div className="flex items-center border border-line">
                        <button className="px-2 py-1" onClick={() => update(l.key, l.quantity - 1)} aria-label="Decrease">−</button>
                        <span className="w-8 text-center">{l.quantity}</span>
                        <button className="px-2 py-1" onClick={() => update(l.key, l.quantity + 1)} aria-label="Increase">+</button>
                      </div>
                      <button onClick={() => remove(l.key)} className="text-xs text-muted underline">Remove</button>
                    </div>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>
        {lines.length > 0 && (
          <div className="space-y-3 border-t border-line p-5">
            <div className="flex justify-between font-medium">
              <span>Subtotal</span>
              <span>{formatNaira(subtotal)}</span>
            </div>
            <Link href="/checkout" onClick={() => setDrawerOpen(false)} className="btn-primary w-full">
              Checkout
            </Link>
            <Link href="/cart" onClick={() => setDrawerOpen(false)} className="btn-outline w-full">
              View bag
            </Link>
          </div>
        )}
      </aside>
    </div>
  );
}
