import Link from "next/link";
import { query } from "@/lib/db";
import { PageHeader, Badge } from "@/components/admin/Fields";

export const metadata = { title: "Info pages" };

export default async function PagesAdmin({ searchParams }) {
  const { saved } = await searchParams;
  const pages = await query("SELECT id, slug, title, is_active FROM pages ORDER BY sort_order, title");
  return (
    <div>
      <PageHeader title="Information pages"><Link href="/admin/pages/new" className="btn-primary">New page</Link></PageHeader>
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="border border-line bg-white">
        {pages.map((p) => (
          <div key={p.id} className="flex items-center justify-between border-b border-line p-3 text-sm">
            <Link href={`/admin/pages/${p.id}`} className="underline">{p.title}</Link>
            <span className="flex items-center gap-3 text-xs text-muted">/pages/{p.slug} {!p.is_active && <Badge>Hidden</Badge>}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
