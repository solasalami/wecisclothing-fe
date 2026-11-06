import { NextResponse } from "next/server";
import { queryOne } from "@/lib/db";

// Old OpenCart links (/index.php?route=...) still live in Google results, WhatsApp
// chats, social bios and past ads. Send each one to the matching page on the new
// site with a permanent (301) redirect, so visitors land on the right page and
// search engines move their ranking across. "/?route=..." is sent here by proxy.js.

export const dynamic = "force-dynamic";

// OpenCart category_id -> new category slug (from the catalogue import).
const CATEGORIES = {
  20: "men", 25: "women",
  17: "men-safari", 24: "men-fila", 26: "men-casual", 27: "men-suit", 43: "men-agbada", 59: "men-kaftan",
  37: "men-long-sleeves-without-cuffs", 38: "men-long-sleeves-with-cuffs", 39: "men-plaited-short-sleeves", 40: "men-short-sleeves",
  49: "men-office-suit", 50: "men-conductor", 51: "men-safari-plain", 52: "men-safari-with-stripes",
  53: "men-shirts", 54: "men-round-neck-shirts", 55: "men-trousers", 56: "men-customised-t-shirts",
  28: "women-casual", 30: "women-skirt-and-blouse", 31: "women-short-dress", 32: "women-haute-couture",
  35: "women-pants", 60: "women-bubu", 61: "women-long-dress",
};

// OpenCart information_id -> info page.
const INFORMATION = { 3: "/pages/privacy-policy", 4: "/pages/about-us", 5: "/pages/terms-and-conditions", 6: "/pages/shipping-and-returns" };

const id = (v) => {
  const n = parseInt(String(v || ""), 10);
  return n > 0 ? n : 0;
};

async function destination(sp) {
  const route = String(sp.get("route") || "common/home").toLowerCase();

  if (route === "product/product") {
    const legacy = id(sp.get("product_id"));
    if (legacy) {
      const p = await queryOne("SELECT slug FROM products WHERE legacy_id = ? AND is_active = 1", [legacy]).catch(() => null);
      if (p) return `/product/${p.slug}`;
    }
    return "/shop";
  }

  if (route === "product/category") {
    // path=20_43_37: the last id is the category itself; fall back to its parents.
    const ids = String(sp.get("path") || "").split("_").map(id).filter(Boolean).reverse();
    for (const legacy of ids) {
      const slug = CATEGORIES[legacy];
      if (!slug) continue;
      const c = await queryOne("SELECT slug FROM categories WHERE slug = ? AND is_active = 1", [slug]).catch(() => null);
      if (c) return `/category/${c.slug}`;
    }
    return "/shop";
  }

  if (route === "product/search") {
    const q = String(sp.get("search") || sp.get("tag") || "").slice(0, 80);
    return q ? `/shop?q=${encodeURIComponent(q)}` : "/shop";
  }

  if (route === "information/information") return INFORMATION[id(sp.get("information_id"))] || "/";
  if (route === "information/contact") return "/contact";
  if (route.startsWith("account/")) return "/account";
  if (route === "checkout/cart") return "/cart";
  if (route.startsWith("checkout/")) return "/checkout";
  if (route.startsWith("product/")) return "/shop"; // specials, manufacturers, compare
  return "/";
}

export async function GET(request) {
  const url = new URL(request.url);
  const to = new URL(await destination(url.searchParams), url);
  // Keep ad and campaign tracking parameters.
  for (const [k, v] of url.searchParams) {
    if (/^(utm_|gclid$|gbraid$|wbraid$|fbclid$)/.test(k)) to.searchParams.set(k, v);
  }
  return NextResponse.redirect(to, 301);
}

export const HEAD = GET;
