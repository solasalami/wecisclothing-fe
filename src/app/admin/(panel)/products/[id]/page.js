import { notFound } from "next/navigation";
import { getAllCategoriesTree, getProductForEdit, getBundleCandidates } from "@/lib/admin-data";
import ProductForm from "@/components/admin/ProductForm";
import Link from "next/link";
import { PageHeader } from "@/components/admin/Fields";
import { productBack } from "@/lib/admin-back";
import { ConfirmButton } from "@/components/admin/Form";
import { deleteProduct } from "@/app/admin/actions";

export const metadata = { title: "Edit product" };

export default async function EditProduct({ params, searchParams }) {
  const { id } = await params;
  const { saved, back: backParam } = await searchParams;
  const [product, categories] = await Promise.all([getProductForEdit(Number(id)), getAllCategoriesTree()]);
  if (!product) notFound();
  const bundleProducts = product.kind === "package" ? await getBundleCandidates() : [];
  const back = productBack(backParam, product.kind);
  return (
    <div>
      <Link href={back.href} className="mb-3 inline-flex items-center gap-1.5 text-sm font-semibold text-muted hover:text-ink">
        <span aria-hidden="true">←</span> Back to {back.label}
      </Link>
      <PageHeader title={product.name}>
        <form action={deleteProduct}>
          <input type="hidden" name="id" value={product.id} />
          <input type="hidden" name="return_to" value={product.kind === "package" ? "packages" : "products"} />
          <ConfirmButton message="Delete this product? (If it has orders it will be hidden instead.)">Delete</ConfirmButton>
        </form>
      </PageHeader>
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <ProductForm key={product.updated_at?.toString()} product={product} categories={categories} back={back.href} bundleProducts={bundleProducts} />
    </div>
  );
}
