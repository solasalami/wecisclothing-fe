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

/** Identity of a cart / order line: the same product with other sizes is a separate line. */
export function lineKey(productId, size, parts) {
  const pk = partsKey(parts);
  return `${productId}:${size || ""}${pk ? `:${pk}` : ""}`;
}

/** "Agbada (L), Ankara gown (M), Cap" from [{ name, size }]. */
export function componentsText(components) {
  if (!Array.isArray(components) || !components.length) return "";
  return components.map((c) => (c.size ? `${c.name} (${c.size})` : c.name)).join(", ");
}
