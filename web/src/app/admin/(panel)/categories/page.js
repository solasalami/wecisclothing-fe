import Link from "next/link";
import { getAllCategoriesTree } from "@/lib/admin-data";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { Field, TextArea, Check, Card, PageHeader, Badge } from "@/components/admin/Fields";
import { saveCategory, deleteCategory } from "@/app/admin/actions";

export const metadata = { title: "Categories" };

function flatten(tree, depth = 0, out = []) {
  for (const c of tree) { out.push({ ...c, depth }); flatten(c.children, depth + 1, out); }
  return out;
}

export default async function CategoriesAdmin({ searchParams }) {
  const { edit, saved } = await searchParams;
  const flat = flatten(await getAllCategoriesTree());
  const current = edit ? flat.find((c) => c.id === Number(edit)) : null;
  return (
    <div>
      <PageHeader title="Categories" />
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <div className="border border-line bg-white">
          <table className="w-full text-left text-sm">
            <tbody>
              {flat.map((c) => (
                <tr key={c.id} className="border-b border-line">
                  <td className="p-3" style={{ paddingLeft: 12 + c.depth * 24 }}>
                    <Link href={`/admin/categories?edit=${c.id}`} className="underline">{c.name}</Link>
                    <span className="ml-2 text-xs text-muted">/{c.slug}</span>
                  </td>
                  <td className="space-x-1 text-right">
                    {!c.is_active && <Badge>Hidden</Badge>}
                    {!c.show_in_menu && <Badge>Not in menu</Badge>}
                  </td>
                  <td className="w-20 pr-3 text-right">
                    <form action={deleteCategory}>
                      <input type="hidden" name="id" value={c.id} />
                      <ConfirmButton message={`Delete "${c.name}"? Sub-categories move to the top level; products are not deleted.`}>Delete</ConfirmButton>
                    </form>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <Card title={current ? `Edit “${current.name}”` : "New category"} actions={current && <Link href="/admin/categories" className="text-xs underline">+ New instead</Link>}>
          <ActionForm action={saveCategory} className="space-y-4" key={current?.id || "new"}>
            <input type="hidden" name="id" value={current?.id || ""} />
            <Field label="Name" name="name" defaultValue={current?.name} required />
            <div>
              <label className="label" htmlFor="parent_id">Parent</label>
              <select id="parent_id" name="parent_id" defaultValue={current?.parent_id || ""} className="input">
                <option value="">— Top level —</option>
                {flat.filter((c) => c.id !== current?.id).map((c) => <option key={c.id} value={c.id}>{"— ".repeat(c.depth)}{c.name}</option>)}
              </select>
            </div>
            <Field label="URL slug" name="slug" defaultValue={current?.slug} hint="Leave blank to generate." />
            <TextArea label="Description" name="description" rows={3} defaultValue={current?.description || ""} />
            <div>
              <span className="label">Image (used on the homepage for Men / Women)</span>
              {current?.image && (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={current.image} alt="" className="mb-2 h-20 w-36 object-cover" />
              )}
              <input type="file" name="image" accept="image/jpeg,image/png,image/webp" className="text-sm" />
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
