"use client";
import { createContext, useCallback, useContext, useMemo, useState, useSyncExternalStore } from "react";
import { trackAddToCart, trackRemoveFromCart } from "@/lib/analytics";

const CartContext = createContext(null);
const KEY = "wecis_cart_v1";
const EMPTY = [];

// localStorage-backed store (also syncs between open tabs).
const listeners = new Set();
let raw = null;
let cache = EMPTY;
function readCart() {
  const r = localStorage.getItem(KEY) || "[]";
  if (r !== raw) {
    raw = r;
    try {
      cache = JSON.parse(r);
    } catch {
      cache = EMPTY;
    }
  }
  return cache;
}
function subscribe(listener) {
  listeners.add(listener);
  window.addEventListener("storage", listener);
  return () => {
    listeners.delete(listener);
    window.removeEventListener("storage", listener);
  };
}
function setLines(updater) {
  const next = typeof updater === "function" ? updater(readCart()) : updater;
  localStorage.setItem(KEY, JSON.stringify(next));
  listeners.forEach((l) => l());
}

export function CartProvider({ children }) {
  const lines = useSyncExternalStore(subscribe, readCart, () => EMPTY);
  const ready = useSyncExternalStore(subscribe, () => true, () => false);
  const [drawerOpen, setDrawerOpen] = useState(false);

  const add = useCallback((product, { quantity = 1, size = null } = {}) => {
    setLines((prev) => {
      const key = `${product.id}:${size || ""}`;
      const existing = prev.find((l) => l.key === key);
      if (existing) return prev.map((l) => (l.key === key ? { ...l, quantity: Math.min(l.quantity + quantity, 20) } : l));
      return [
        ...prev,
        {
          key,
          productId: product.id,
          name: product.name,
          slug: product.slug,
          sku: product.sku,
          kind: product.kind,
          price: Number(product.price),
          image: product.image,
          size,
          quantity,
        },
      ];
    });
    trackAddToCart(product, quantity, size);
    setDrawerOpen(true);
  }, []);

  const update = useCallback((key, quantity) => {
    setLines((prev) => prev.map((l) => (l.key === key ? { ...l, quantity: Math.max(1, Math.min(quantity, 20)) } : l)));
  }, []);

  const remove = useCallback((key) => {
    setLines((prev) => {
      const line = prev.find((l) => l.key === key);
      if (line) trackRemoveFromCart(line);
      return prev.filter((l) => l.key !== key);
    });
  }, []);

  const clear = useCallback(() => setLines([]), []);

  /** Replace local prices with the server's authoritative prices. */
  const syncPrices = useCallback((items) => {
    const priceMap = new Map(items.map((i) => [`${i.product_id}:${i.size || ""}`, i.unit_price]));
    setLines((prev) => prev.map((l) => (priceMap.has(l.key) ? { ...l, price: priceMap.get(l.key) } : l)));
  }, []);

  const value = useMemo(() => {
    const count = lines.reduce((s, l) => s + l.quantity, 0);
    const subtotal = lines.reduce((s, l) => s + l.price * l.quantity, 0);
    return { lines, ready, count, subtotal, add, update, remove, clear, syncPrices, drawerOpen, setDrawerOpen };
  }, [lines, ready, add, update, remove, clear, syncPrices, drawerOpen]);

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

export function useCart() {
  const ctx = useContext(CartContext);
  if (!ctx) throw new Error("useCart must be used inside CartProvider");
  return ctx;
}
