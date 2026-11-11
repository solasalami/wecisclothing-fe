// "Back" link on the product editor: returns to the list the admin came from, carried in
// ?back= (the Seasonal campaign page, or the Products list with its filters), so it still
// works after saving. Without one, packages go back to the campaign and products to Products.

export function productBack(back, kind) {
  const v = typeof back === "string" ? back : "";
  if (v === "/admin/campaign") return { href: v, label: "Seasonal campaign" };
  if (v === "/admin/products" || v.startsWith("/admin/products?")) return { href: v, label: "Products" };
  return kind === "package" ? { href: "/admin/campaign", label: "Seasonal campaign" } : { href: "/admin/products", label: "Products" };
}

/** Link to a product's editor that remembers where to go back to. */
export const editProductHref = (id, back) => `/admin/products/${id}?back=${encodeURIComponent(back)}`;
