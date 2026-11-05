import Link from "next/link";
import { ActionForm, SubmitButton } from "./Form";
import { Field, TextArea, Check, Card } from "./Fields";
import RichText from "./RichText";
import ImageManager from "./ImageManager";
import { saveProduct } from "@/app/admin/actions";
import { CategoryPicker } from "./CategoryTree";

export default function ProductForm({ product, categories, kind = "product", defaultBadge = "" }) {
  const p = product || { kind, badge: defaultBadge, is_active: 1, sizes: kind === "package" ? [] : ["S", "M", "L", "XL", "XXL"], images: [], categoryIds: [], package_items: [] };
  const isPackage = (p.kind || kind) === "package";
  return (
    <ActionForm action={saveProduct} className="grid gap-6 xl:grid-cols-[1fr_340px]">
      <input type="hidden" name="id" value={p.id || ""} />
      <input type="hidden" name="kind" value={isPackage ? "package" : "product"} />
      <div className="space-y-6">
        <Card title="Details">
          <Field label={isPackage ? "Package name" : "Product name"} name="name" defaultValue={p.name} required placeholder={isPackage ? "e.g. Owambe Couple Package" : "e.g. Men Native - Burgundy"} />
          <TextArea label="Short summary" name="short_description" rows={2} defaultValue={p.short_description || ""} hint="One or two sentences shown near the price." />
          {isPackage && (
            <TextArea
              label="What's included (one per line)"
              name="package_items"
              rows={5}
              defaultValue={(p.package_items || []).join("\n")}
              hint="e.g. Agbada (3 piece) · Matching fila · Free delivery in Lagos"
            />
          )}
          <RichText label="Full description" name="description" defaultValue={p.description || ""} />
        </Card>

        <Card title="Photos">
          <ImageManager images={p.images} />
        </Card>

        <Card title="Search engine listing (optional)">
          <Field label="URL slug" name="slug" defaultValue={p.slug} hint="Leave blank to generate from the name." />
          <Field label="Meta title" name="meta_title" defaultValue={p.meta_title || ""} />
          <TextArea label="Meta description" name="meta_description" rows={2} defaultValue={p.meta_description || ""} />
        </Card>
      </div>

      <div className="space-y-6">
        <Card title="Publish">
          <Check label="Visible on website" name="is_active" defaultChecked={p.is_active} />
          <Check label="Feature on homepage" name="is_featured" defaultChecked={p.is_featured} />
          <Field label="Badge (optional)" name="badge" defaultValue={p.badge || ""} list="badge-suggestions" placeholder="e.g. New arrival" hint="Shown on the product photo. Blank = automatic “New arrival” for 45 days." />
          <datalist id="badge-suggestions">
            {["New arrival", "Bestseller", "Limited edition", "Back in stock", "Pre-order"].map((b) => <option key={b} value={b} />)}
          </datalist>
          <Field label="Sort order" name="sort_order" type="number" defaultValue={p.sort_order || 0} hint="Lower numbers show first." />
          <SubmitButton className="btn-primary w-full">{p.id ? "Save changes" : isPackage ? "Publish package" : "Create product"}</SubmitButton>
          {p.id && (
            <Link href={`/product/${p.slug}`} target="_blank" className="block text-center text-sm underline">
              View on website
            </Link>
          )}
        </Card>

        <Card title="Pricing (₦)">
          <Field label="Price" name="price" type="number" min="0" step="1" defaultValue={p.price != null ? Number(p.price) : ""} required />
          <Field label="Compare-at price" name="compare_at_price" type="number" min="0" step="1" defaultValue={p.compare_at_price ? Number(p.compare_at_price) : ""} hint="Optional old price, shown struck through." />
          <Field label="SKU / code" name="sku" defaultValue={p.sku || ""} />
        </Card>

        <Card title="Sizes & stock">
          <Field label="Sizes (comma separated)" name="sizes" defaultValue={(p.sizes || []).join(", ")} hint="e.g. S, M, L, XL, XXL, Custom. Leave blank for one-size." />
          <Check label="Track stock" name="track_stock" defaultChecked={p.track_stock} hint="Leave off for made-to-order items." />
          <Field label="Quantity in stock" name="stock_qty" type="number" min="0" defaultValue={p.stock_qty || 0} />
        </Card>

        <Card title="Categories">
          <CategoryPicker tree={categories} defaultChecked={p.categoryIds} />
        </Card>
      </div>
    </ActionForm>
  );
}
