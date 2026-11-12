import Link from "next/link";
import { ActionForm, SubmitButton } from "./Form";
import { Field, TextArea, Check, Card } from "./Fields";
import RichText from "./RichText";
import ImageManager from "./ImageManager";
import { saveProduct } from "@/app/admin/actions";
import { CategoryPicker } from "./CategoryTree";
import BundlePicker from "./BundlePicker";

// bundleProducts: packages only, every normal product that can be included in the bundle.
export default function ProductForm({ product, categories, kind = "product", defaultBadge = "", back = "", bundleProducts = [] }) {
  const p = product || { kind, badge: defaultBadge, is_active: 1, sizes: kind === "package" ? [] : ["S", "M", "L", "XL", "XXL"], images: [], categoryIds: [], package_items: [] };
  const isPackage = (p.kind || kind) === "package";
  const isBundle = isPackage && (p.componentIds || []).length > 0;
  return (
    <ActionForm action={saveProduct} className="grid gap-6 xl:grid-cols-[1fr_340px]">
      <input type="hidden" name="id" value={p.id || ""} />
      <input type="hidden" name="kind" value={isPackage ? "package" : "product"} />
      <input type="hidden" name="back" value={back} />
      <div className="space-y-6">
        <Card title="Details">
          <Field label={isPackage ? "Package name" : "Product name"} name="name" defaultValue={p.name} required placeholder={isPackage ? "e.g. Owambe Couple Package" : "e.g. Men Native - Burgundy"} />
          <TextArea label="Short summary" name="short_description" rows={2} defaultValue={p.short_description || ""} hint="One or two sentences shown near the price." />
          {isPackage && (
            <TextArea
              label={isBundle ? "Also included (optional, one per line)" : "What's included (one per line)"}
              name="package_items"
              rows={isBundle ? 3 : 5}
              defaultValue={(p.package_items || []).join("\n")}
              hint={isBundle ? "Extras that aren't products, e.g. Free delivery in Lagos · Gift wrapping" : "e.g. Agbada (3 piece) · Matching fila · Free delivery in Lagos. Or add real products below to make a bundle."}
            />
          )}
          <RichText label="Full description" name="description" defaultValue={p.description || ""} />
        </Card>

        {isPackage && (
          <Card title="Products in this package">
            <BundlePicker products={bundleProducts} initial={p.componentIds || []} />
          </Card>
        )}

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
          <Check label="Visible on website" name="is_active" defaultChecked={p.is_active} hint="Listed in the shop, its categories and search (packages also on the campaign page)." />
          <Check label="Feature on homepage" name="is_featured" defaultChecked={p.is_featured} hint="Also shown on the homepage (needs Visible on website)." />
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
          <Check
            label="Price includes VAT"
            name="vat_inclusive"
            defaultChecked={p.vat_inclusive}
            hint="Ticked: VAT is already inside the price. Unticked: VAT is added on top at checkout."
          />
          <Field label="SKU / code" name="sku" defaultValue={p.sku || ""} />
        </Card>

        <Card title="Sizes & stock">
          {isBundle ? (
            <p className="text-sm text-muted">Sizes come from each product in the package; shoppers pick one for every item.</p>
          ) : (
            <Field
              label="Sizes (comma separated)"
              name="sizes"
              defaultValue={(p.sizes || []).join(", ")}
              hint={isPackage ? "Leave blank if you add products above (each has its own sizes)." : "e.g. S, M, L, XL, XXL, Custom. Leave blank for one-size."}
            />
          )}
          <Check
            label="Track stock"
            name="track_stock"
            defaultChecked={p.track_stock}
            hint={isPackage ? "Optional limit on how many packages can be sold. Stock of each included product is always checked." : "Leave off for made-to-order items."}
          />
          <Field label="Quantity in stock" name="stock_qty" type="number" min="0" defaultValue={p.stock_qty || 0} />
        </Card>

        <Card title="Categories">
          <CategoryPicker tree={categories} defaultChecked={p.categoryIds} />
        </Card>
      </div>
    </ActionForm>
  );
}
