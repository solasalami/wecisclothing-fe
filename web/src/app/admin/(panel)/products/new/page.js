import { getAllCategoriesTree } from "@/lib/admin-data";
import ProductForm from "@/components/admin/ProductForm";
import { PageHeader } from "@/components/admin/Fields";
import { getSetting } from "@/lib/settings";

export const metadata = { title: "New product" };

export default async function NewProduct({ searchParams }) {
  const { kind } = await searchParams;
  const [categories, campaign] = await Promise.all([getAllCategoriesTree(), getSetting("campaign")]);
  const isPackage = kind === "package";
  return (
    <div>
      <PageHeader title={isPackage ? `New ${campaign.name} package` : "New product"} />
      <ProductForm categories={categories} kind={isPackage ? "package" : "product"} defaultBadge={isPackage ? campaign.package_label : ""} />
    </div>
  );
}
