export default function robots() {
  const base = (process.env.NEXT_PUBLIC_SITE_URL || "https://wecisclothing.com").replace(/\/$/, "");
  return {
    rules: [{ userAgent: "*", allow: "/", disallow: ["/admin", "/checkout", "/cart", "/account", "/api"] }],
    sitemap: `${base}/sitemap.xml`,
  };
}
