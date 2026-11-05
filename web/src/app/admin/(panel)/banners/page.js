import Link from "next/link";
import { query } from "@/lib/db";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { Field, Check, Card, PageHeader, Badge } from "@/components/admin/Fields";
import { saveBanner, deleteBanner } from "@/app/admin/actions";

export const metadata = { title: "Home banners" };

export default async function BannersAdmin({ searchParams }) {
  const { edit, saved } = await searchParams;
  const banners = await query("SELECT * FROM banners ORDER BY sort_order, id");
  const current = edit ? banners.find((b) => b.id === Number(edit)) : null;
  return (
    <div>
      <PageHeader title="Homepage banners" />
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <div className="space-y-3">
          {banners.map((b) => (
            <div key={b.id} className="flex items-center gap-4 border border-line bg-white p-3">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={b.image} alt="" className="h-16 w-40 object-cover" />
              <div className="flex-1 text-sm">
                <Link href={`/admin/banners?edit=${b.id}`} className="font-medium underline">{b.title || "Untitled banner"}</Link>
                <p className="text-xs text-muted">Order {b.sort_order} {b.link && `· → ${b.link}`}</p>
              </div>
              {!b.is_active && <Badge>Hidden</Badge>}
              <form action={deleteBanner}>
                <input type="hidden" name="id" value={b.id} />
                <ConfirmButton message="Delete this banner?">Delete</ConfirmButton>
              </form>
            </div>
          ))}
        </div>
        <Card title={current ? "Edit banner" : "New banner"} actions={current && <Link href="/admin/banners" className="text-xs underline">+ New instead</Link>}>
          <ActionForm action={saveBanner} className="space-y-4" key={current?.id || "new"}>
            <input type="hidden" name="id" value={current?.id || ""} />
            <div>
              <span className="label">Image (1800×718 recommended)</span>
              <input type="file" name="image" accept="image/jpeg,image/png,image/webp" className="text-sm" required={!current} />
            </div>
            <Field label="Title (for accessibility)" name="title" defaultValue={current?.title || ""} />
            <Field label="Link" name="link" defaultValue={current?.link || ""} placeholder="/detty-december" />
            <Field label="Caption (optional)" name="subtitle" defaultValue={current?.subtitle || ""} />
            <Field label="Button label (optional)" name="button_label" defaultValue={current?.button_label || ""} placeholder="Shop now" />
            <Field label="Sort order" name="sort_order" type="number" defaultValue={current?.sort_order || 0} />
            <Check label="Active" name="is_active" defaultChecked={current ? current.is_active : true} />
            <SubmitButton className="btn-primary w-full" />
          </ActionForm>
        </Card>
      </div>
    </div>
  );
}
