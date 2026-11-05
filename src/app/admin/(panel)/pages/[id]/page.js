import { notFound } from "next/navigation";
import { queryOne } from "@/lib/db";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { Field, TextArea, Check, Card, PageHeader } from "@/components/admin/Fields";
import RichText from "@/components/admin/RichText";
import { savePage, deletePage } from "@/app/admin/actions";

export const metadata = { title: "Edit page" };

export default async function EditPage({ params }) {
  const { id } = await params;
  const page = id === "new" ? { is_active: 1 } : await queryOne("SELECT * FROM pages WHERE id = ?", [Number(id)]);
  if (!page) notFound();
  return (
    <div className="max-w-4xl">
      <PageHeader title={page.id ? page.title : "New page"}>
        {page.id && (
          <form action={deletePage}>
            <input type="hidden" name="id" value={page.id} />
            <ConfirmButton message="Delete this page?">Delete</ConfirmButton>
          </form>
        )}
      </PageHeader>
      <Card>
        <ActionForm action={savePage} className="space-y-4">
          <input type="hidden" name="id" value={page.id || ""} />
          <Field label="Title" name="title" defaultValue={page.title} required />
          <Field label="URL slug" name="slug" defaultValue={page.slug} hint="Leave blank to generate." />
          <RichText label="Content" name="body" defaultValue={page.body || ""} />
          <TextArea label="Meta description" name="meta_description" rows={2} defaultValue={page.meta_description || ""} />
          <Field label="Sort order" name="sort_order" type="number" defaultValue={page.sort_order || 0} />
          <Check label="Published (shown in footer)" name="is_active" defaultChecked={page.is_active} />
          <SubmitButton />
        </ActionForm>
      </Card>
    </div>
  );
}
