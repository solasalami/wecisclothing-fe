// Shared by the browser (cart) and the server (pricing, orders, emails): how a bundle
// package's chosen sizes are keyed and shown. No server-only imports here.

/** Stable text for a bundle's chosen sizes, e.g. "12=L,15=M,18=". Empty for normal items. */
export function partsKey(parts) {
  if (!parts || typeof parts !== "object") return "";
  return Object.keys(parts)
    .map(Number)
    .filter((id) => id > 0)
    .sort((a, b) => a - b)
    .map((id) => `${id}=${parts[id] || ""}`)
    .join(",");
}

/** Pick-your-own bundles: the chosen outfits as stable text, repeats kept, e.g. "4=L,4=M,9=". */
export function picksKey(picks) {
  if (!Array.isArray(picks) || !picks.length) return "";
  return picks
    .map((p) => `${Number(p.productId)}=${p.size || ""}`)
    .sort()
    .join(",");
}

/** Identity of a cart / order line: the same product with other sizes (or picks) is a separate line. */
export function lineKey(productId, size, parts, picks) {
  const pk = partsKey(parts) || picksKey(picks);
  return `${productId}:${size || ""}${pk ? `:${pk}` : ""}`;
}

/** Pick-your-own bundles: the price for each number of outfits, from min to max. */
export function pickTiers(pick) {
  const out = [];
  if (!pick) return out;
  for (let n = Number(pick.min); n <= Number(pick.max); n++) {
    const price = Number(pick.prices?.[n]);
    if (price > 0) out.push({ count: n, price });
  }
  return out;
}

/** "Agbada (L), Ankara gown (M), Cap" from [{ name, size }]. */
export function componentsText(components) {
  if (!Array.isArray(components) || !components.length) return "";
  return components.map((c) => (c.size ? `${c.name} (${c.size})` : c.name)).join(", ");
}
