import Link from "next/link";
import { query } from "@/lib/db";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { Field, Check, Card, PageHeader } from "@/components/admin/Fields";
import { saveShowroom, deleteShowroom } from "@/app/admin/actions";

export const metadata = { title: "Showrooms" };

export default async function ShowroomsAdmin({ searchParams }) {
  const { edit, saved } = await searchParams;
  const rows = await query("SELECT * FROM showrooms ORDER BY sort_order, id");
  const current = edit ? rows.find((r) => r.id === Number(edit)) : null;
  return (
    <div>
      <PageHeader title="Showrooms" />
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <div className="space-y-3">
          {rows.map((s) => (
            <div key={s.id} className="flex items-start justify-between gap-4 border border-line bg-white p-4 text-sm">
              <div>
                <Link href={`/admin/showrooms?edit=${s.id}`} className="font-medium underline">{s.name}</Link>
                <p>{s.address}</p>
                <p className="text-muted">{s.phone} {s.hours && `· ${s.hours}`}</p>
              </div>
              <form action={deleteShowroom}>
                <input type="hidden" name="id" value={s.id} />
                <ConfirmButton message="Delete this showroom?">Delete</ConfirmButton>
              </form>
            </div>
          ))}
        </div>
        <Card title={current ? `Edit ${current.name}` : "New showroom"} actions={current && <Link href="/admin/showrooms" className="text-xs underline">+ New instead</Link>}>
          <ActionForm action={saveShowroom} className="space-y-4" key={current?.id || "new"}>
            <input type="hidden" name="id" value={current?.id || ""} />
            <Field label="Name" name="name" defaultValue={current?.name} required />
            <Field label="Address" name="address" defaultValue={current?.address} required />
            <Field label="Phone" name="phone" defaultValue={current?.phone || ""} />
            <Field label="WhatsApp" name="whatsapp" defaultValue={current?.whatsapp || ""} />
            <Field label="Opening hours" name="hours" defaultValue={current?.hours || ""} placeholder="Mon–Sat 9am–7pm" />
            <Field label="Google Maps link" name="map_url" defaultValue={current?.map_url || ""} />
            <Field label="Sort order" name="sort_order" type="number" defaultValue={current?.sort_order || 0} />
            <Check label="Active" name="is_active" defaultChecked={current ? current.is_active : true} />
            <SubmitButton className="btn-primary w-full" />
          </ActionForm>
        </Card>
      </div>
    </div>
  );
}
