import ImageUpload from "@/components/admin/ImageUpload";
import Link from "next/link";
import { getAllCategoriesTree, flattenCategories } from "@/lib/admin-data";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { Field, TextArea, Check, Card, PageHeader } from "@/components/admin/Fields";
import { CategoryManager } from "@/components/admin/CategoryTree";
import { saveCategory, deleteCategory } from "@/app/admin/actions";

export const metadata = { title: "Categories" };

export default async function CategoriesAdmin({ searchParams }) {
  const { edit, saved } = await searchParams;
  const tree = await getAllCategoriesTree();
  const flat = flattenCategories(tree);
  const current = edit ? flat.find((c) => c.id === Number(edit)) : null;
  // A category can't move inside itself or its own sub-categories.
  const parentOptions = current ? flat.filter((c) => c.id !== current.id && !current.descendantIds.includes(c.id)) : flat;
  return (
    <div>
      <PageHeader title="Categories" />
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <CategoryManager tree={tree} selectedId={current?.id} deleteAction={deleteCategory} />
        <Card title={current ? `Edit “${current.name}”` : "New category"} actions={current && <Link href="/admin/categories" className="text-xs underline">+ New instead</Link>}>
          <ActionForm action={saveCategory} className="space-y-4" key={current?.id || "new"}>
            <input type="hidden" name="id" value={current?.id || ""} />
            <Field label="Name" name="name" defaultValue={current?.name} required />
            <div>
              <label className="label" htmlFor="parent_id">Parent</label>
              <select id="parent_id" name="parent_id" defaultValue={current?.parent_id || ""} className="input">
                <option value="">None (top level)</option>
                {parentOptions.map((c) => <option key={c.id} value={c.id}>{c.path}</option>)}
              </select>
            </div>
            {current && <p className="-mt-2 text-xs text-muted">Currently: {current.path}</p>}
            <Field label="URL slug" name="slug" defaultValue={current?.slug} hint="Leave blank to generate." />
            <TextArea label="Description" name="description" rows={3} defaultValue={current?.description || ""} />
            <div>
              <span className="label">Image (used on the homepage for Men / Women)</span>
              {current?.image && (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={current.image} alt="" className="mb-2 h-20 w-36 object-cover" />
              )}
              <ImageUpload name="image" buttonLabel={current?.image ? "Replace image" : "Choose image"} hint="JPG, PNG or WebP up to 8 MB" compact />
            </div>
            <Field label="Sort order" name="sort_order" type="number" defaultValue={current?.sort_order || 0} />
            <Check label="Active" name="is_active" defaultChecked={current ? current.is_active : true} />
            <Check label="Show in menu" name="show_in_menu" defaultChecked={current ? current.show_in_menu : true} />
            <SubmitButton className="btn-primary w-full" />
          </ActionForm>
        </Card>
      </div>
    </div>
  );
}
