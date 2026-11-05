import { getAllCategoriesTree } from "@/lib/admin-data";
import ProductForm from "@/components/admin/ProductForm";
import { PageHeader } from "@/components/admin/Fields";

export const metadata = { title: "New product" };

export default async function NewProduct({ searchParams }) {
  const { kind } = await searchParams;
  const categories = await getAllCategoriesTree();
  const isPackage = kind === "package";
  return (
    <div>
      <PageHeader title={isPackage ? "New Detty December package" : "New product"} />
      <ProductForm categories={categories} kind={isPackage ? "package" : "product"} />
    </div>
  );
}
