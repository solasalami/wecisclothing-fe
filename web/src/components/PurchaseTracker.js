"use client";
import { useEffect, useRef } from "react";
import { pushEvent } from "@/lib/analytics";
import { useCart } from "./CartProvider";

/**
 * Emits the GA4 / Google Ads `purchase` event exactly once per order:
 *  1. the server only provides `purchase` on the first paid render (DB claim),
 *  2. a sessionStorage/localStorage guard stops React re-mounts/back-forward cache,
 *  3. transaction_id lets GA4 and Google Ads de-duplicate anything that slips through.
 */
export default function PurchaseTracker({ purchase, orderNumber, clearCart }) {
  const { clear } = useCart();
  const done = useRef(false);

  useEffect(() => {
    if (clearCart) clear();
  }, [clearCart, clear]);

  useEffect(() => {
    if (!purchase || done.current) return;
    const key = `wecis_purchase_${orderNumber}`;
    try {
      if (localStorage.getItem(key)) return;
      localStorage.setItem(key, "1");
    } catch {}
    done.current = true;
    const { email, phone, ...ecommerce } = purchase;
    pushEvent("purchase", {
      ecommerce,
      // For Google Ads Enhanced Conversions (GTM "User-provided data" variable).
      user_data: { email, phone_number: phone },
    });
  }, [purchase, orderNumber]);

  return null;
}
