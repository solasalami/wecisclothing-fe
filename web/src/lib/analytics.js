"use client";
// GA4-ecommerce-shaped dataLayer events consumed by Google Tag Manager.
// GTM maps these to GA4 events and the Google Ads purchase conversion.

export function pushEvent(event, params = {}) {
  if (typeof window === "undefined") return;
  window.dataLayer = window.dataLayer || [];
  if (params.ecommerce) window.dataLayer.push({ ecommerce: null }); // clear previous ecommerce object
  window.dataLayer.push({ event, ...params });
}

export function toItem(p, { quantity = 1, size, index } = {}) {
  return {
    item_id: String(p.sku || p.id || p.productId),
    item_name: p.name,
    item_category: p.kind === "package" ? "Seasonal package" : p.category || undefined,
    item_variant: size || undefined,
    price: Number(p.price ?? p.unit_price),
    quantity,
    index,
  };
}

export const trackViewItem = (p) =>
  pushEvent("view_item", { ecommerce: { currency: "NGN", value: Number(p.price), items: [toItem(p)] } });

export const trackAddToCart = (p, quantity, size) =>
  pushEvent("add_to_cart", {
    ecommerce: { currency: "NGN", value: Number(p.price) * quantity, items: [toItem(p, { quantity, size })] },
  });

export const trackRemoveFromCart = (line) =>
  pushEvent("remove_from_cart", {
    ecommerce: { currency: "NGN", value: line.price * line.quantity, items: [toItem(line, { quantity: line.quantity, size: line.size })] },
  });

export const trackViewCart = (lines, value) =>
  pushEvent("view_cart", {
    ecommerce: { currency: "NGN", value, items: lines.map((l) => toItem(l, { quantity: l.quantity, size: l.size })) },
  });

export const trackBeginCheckout = (lines, value) =>
  pushEvent("begin_checkout", {
    ecommerce: { currency: "NGN", value, items: lines.map((l) => toItem(l, { quantity: l.quantity, size: l.size })) },
  });

export const trackAddShippingInfo = (lines, value, tier) =>
  pushEvent("add_shipping_info", {
    ecommerce: { currency: "NGN", value, shipping_tier: tier, items: lines.map((l) => toItem(l, { quantity: l.quantity, size: l.size })) },
  });

export const trackAddPaymentInfo = (lines, value, type) =>
  pushEvent("add_payment_info", {
    ecommerce: { currency: "NGN", value, payment_type: type, items: lines.map((l) => toItem(l, { quantity: l.quantity, size: l.size })) },
  });

/** Capture first-touch campaign params (gclid, utm_*) for order attribution. */
export function captureAttribution() {
  try {
    const sp = new URLSearchParams(window.location.search);
    const keys = ["gclid", "gbraid", "wbraid", "utm_source", "utm_medium", "utm_campaign", "utm_term", "utm_content"];
    const found = Object.fromEntries(keys.filter((k) => sp.get(k)).map((k) => [k, sp.get(k).slice(0, 200)]));
    if (Object.keys(found).length) {
      localStorage.setItem("wecis_attr", JSON.stringify({ ...found, landing: window.location.pathname, at: Date.now() }));
    }
  } catch {}
}

export function readAttribution() {
  try {
    return JSON.parse(localStorage.getItem("wecis_attr") || "null");
  } catch {
    return null;
  }
}
