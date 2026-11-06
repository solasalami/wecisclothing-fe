import { query } from "@/lib/db";
import { getSetting } from "@/lib/settings";
import { isCampaignLive } from "@/lib/campaign";

export const dynamic = "force-dynamic";

export default async function sitemap() {
  const base = (process.env.NEXT_PUBLIC_SITE_URL || "https://wecisclothing.com").replace(/\/$/, "");
  const campaign = await getSetting("campaign");
  const [products, categories, pages] = await Promise.all([
    query("SELECT slug, updated_at FROM products WHERE is_active = 1"),
    query("SELECT slug, updated_at FROM categories WHERE is_active = 1"),
    query("SELECT slug, updated_at FROM pages WHERE is_active = 1"),
  ]);
  return [
    { url: `${base}/`, changeFrequency: "daily", priority: 1 },
    ...(isCampaignLive(campaign) ? [{ url: `${base}/${campaign.slug}`, changeFrequency: "daily", priority: 0.9 }] : []),
    { url: `${base}/shop`, changeFrequency: "daily", priority: 0.8 },
    { url: `${base}/contact`, priority: 0.6 },
    { url: `${base}/size-guide`, priority: 0.5 },
    ...categories.map((c) => ({ url: `${base}/category/${c.slug}`, lastModified: c.updated_at, priority: 0.8 })),
    ...products.map((p) => ({ url: `${base}/product/${p.slug}`, lastModified: p.updated_at, priority: 0.7 })),
    ...pages.map((p) => ({ url: `${base}/pages/${p.slug}`, lastModified: p.updated_at, priority: 0.3 })),
  ];
}
