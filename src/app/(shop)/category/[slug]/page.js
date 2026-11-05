import { notFound } from "next/navigation";
import { getCategoryBySlug, listProducts } from "@/lib/catalog";
import { excerpt } from "@/lib/format";
import Listing from "@/components/Listing";

const PER_PAGE = 24;

export async function generateMetadata({ params }) {
  const { slug } = await params;
  const c = await getCategoryBySlug(slug);
  if (!c) return {};
  return {
    title: c.parent ? `${c.parent.name}'s ${c.name}` : `${c.name}'s Clothing`,
    description: excerpt(c.description, 160) || `Shop ${c.name} at Wecis Clothing, Lagos.`,
    alternates: { canonical: `/category/${c.slug}` },
  };
}

export default async function CategoryPage({ params, searchParams }) {
  const { slug } = await params;
  const sp = await searchParams;
  const category = await getCategoryBySlug(slug);
  if (!category) notFound();
  const page = Math.max(1, parseInt(sp.page, 10) || 1);
  const result = await listProducts({ categoryId: category.id, sort: sp.sort, limit: PER_PAGE, offset: (page - 1) * PER_PAGE });
  return (
    <Listing
      basePath={`/category/${category.slug}`}
      title={category.parent ? `${category.parent.name} · ${category.name}` : category.name}
      intro={category.description}
      aboutTitle={category.parent ? `About ${category.parent.name}\u2019s ${category.name}` : `About our ${category.name.toLowerCase()}\u2019s collection`}
      subcategories={category.children}
      result={result}
      page={page}
      perPage={PER_PAGE}
      sort={sp.sort}
    />
  );
}
