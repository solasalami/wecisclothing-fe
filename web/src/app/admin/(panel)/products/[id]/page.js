import { notFound } from "next/navigation";
import { getAllCategoriesTree, getProductForEdit } from "@/lib/admin-data";
import ProductForm from "@/components/admin/ProductForm";
import { PageHeader } from "@/components/admin/Fields";
import { ConfirmButton } from "@/components/admin/Form";
import { deleteProduct } from "@/app/admin/actions";

export const metadata = { title: "Edit product" };

export default async function EditProduct({ params, searchParams }) {
  const { id } = await params;
  const { saved } = await searchParams;
  const [product, categories] = await Promise.all([getProductForEdit(Number(id)), getAllCategoriesTree()]);
  if (!product) notFound();
  return (
    <div>
      <PageHeader title={product.name}>
        <form action={deleteProduct}>
          <input type="hidden" name="id" value={product.id} />
          <input type="hidden" name="return_to" value={product.kind === "package" ? "packages" : "products"} />
          <ConfirmButton message="Delete this product? (If it has orders it will be hidden instead.)">Delete</ConfirmButton>
        </form>
      </PageHeader>
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <ProductForm key={product.updated_at?.toString()} product={product} categories={categories} />
    </div>
  );
}
