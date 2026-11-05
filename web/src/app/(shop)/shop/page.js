import { listProducts } from "@/lib/catalog";
import Listing from "@/components/Listing";

export const metadata = { title: "Shop all", description: "Shop all Wecis Clothing men's and women's African fashion." };
const PER_PAGE = 24;

export default async function ShopPage({ searchParams }) {
  const sp = await searchParams;
  const page = Math.max(1, parseInt(sp.page, 10) || 1);
  const q = (sp.q || "").toString().slice(0, 80);
  const result = await listProducts({ search: q || undefined, sort: sp.sort, limit: PER_PAGE, offset: (page - 1) * PER_PAGE });
  return (
    <Listing
      basePath="/shop"
      title={q ? `Search: “${q}”` : "Shop all"}
      result={result}
      page={page}
      perPage={PER_PAGE}
      sort={sp.sort}
      q={q}
    />
  );
}
