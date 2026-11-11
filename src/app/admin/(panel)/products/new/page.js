import { getAllCategoriesTree } from "@/lib/admin-data";
import ProductForm from "@/components/admin/ProductForm";
import Link from "next/link";
import { PageHeader } from "@/components/admin/Fields";
import { productBack } from "@/lib/admin-back";
import { getSetting } from "@/lib/settings";

export const metadata = { title: "New product" };

export default async function NewProduct({ searchParams }) {
  const { kind, back: backParam } = await searchParams;
  const [categories, campaign] = await Promise.all([getAllCategoriesTree(), getSetting("campaign")]);
  const isPackage = kind === "package";
  const back = productBack(backParam, isPackage ? "package" : "product");
  return (
    <div>
      <Link href={back.href} className="mb-3 inline-flex items-center gap-1.5 text-sm font-semibold text-muted hover:text-ink">
        <span aria-hidden="true">←</span> Back to {back.label}
      </Link>
      <PageHeader title={isPackage ? `New ${campaign.name} package` : "New product"} />
      <ProductForm categories={categories} kind={isPackage ? "package" : "product"} defaultBadge={isPackage ? campaign.package_label : ""} back={back.href} />
    </div>
  );
}
