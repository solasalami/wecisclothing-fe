import Link from "next/link";
import { query } from "@/lib/db";
import { getSetting } from "@/lib/settings";
import { formatNaira } from "@/lib/format";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { Field, TextArea, Check, Card, PageHeader, Badge } from "@/components/admin/Fields";
import RichText from "@/components/admin/RichText";
import { saveCampaign, toggleProduct } from "@/app/admin/actions";

export const metadata = { title: "Detty December" };

export default async function DettyDecemberAdmin() {
  const [campaign, packages] = await Promise.all([
    getSetting("campaign"),
    query(`SELECT p.id, p.name, p.price, p.is_active, (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY sort_order, id LIMIT 1) image
           FROM products p WHERE p.kind = 'package' ORDER BY p.sort_order, p.id DESC`),
  ]);
  return (
    <div className="space-y-8">
      <PageHeader title="Detty December">
        <Link href="/detty-december" target="_blank" className="btn-outline">View landing page</Link>
        <Link href="/admin/products/new?kind=package" className="btn-festive">+ New package</Link>
      </PageHeader>

      <Card title={`Festive packages (${packages.length})`}>
        <p className="text-sm text-muted">
          Packages appear on the Detty December page and homepage. Add a name, price, photos and what&apos;s included — then tick “Visible on website” to publish.
        </p>
        {packages.length === 0 ? (
          <p className="py-4 text-sm">No packages yet. <Link href="/admin/products/new?kind=package" className="underline">Create the first one</Link>.</p>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {packages.map((p) => (
              <div key={p.id} className="border border-line">
                <Link href={`/admin/products/${p.id}`}>
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  {p.image ? <img src={p.image} alt="" className="aspect-[4/5] w-full object-cover" /> : <div className="flex aspect-[4/5] items-center justify-center bg-soft text-xs text-muted">No photo</div>}
                </Link>
                <div className="space-y-1 p-3 text-sm">
                  <Link href={`/admin/products/${p.id}`} className="font-medium underline">{p.name}</Link>
                  <p>{formatNaira(p.price)}</p>
                  <div className="flex items-center justify-between">
                    {p.is_active ? <Badge tone="green">Live</Badge> : <Badge>Hidden</Badge>}
                    <form action={toggleProduct}>
                      <input type="hidden" name="id" value={p.id} />
                      <button className="text-xs underline">{p.is_active ? "Unpublish" : "Publish"}</button>
                    </form>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </Card>

      <Card title="Landing page content">
        <ActionForm action={saveCampaign} className="space-y-4">
          <Check label="Campaign live (page, menu link and homepage section)" name="enabled" defaultChecked={campaign.enabled} />
          <Field label="Headline" name="title" defaultValue={campaign.title} />
          <TextArea label="Sub-headline" name="subtitle" rows={2} defaultValue={campaign.subtitle} />
          <Field label="Countdown end date" name="ends_at" type="date" defaultValue={campaign.ends_at} />
          <div>
            <span className="label">Hero background image</span>
            {campaign.hero_image && (
              <div className="mb-2 flex items-center gap-3">
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img src={campaign.hero_image} alt="" className="h-20 w-36 object-cover" />
                <Check label="Remove" name="remove_hero" />
              </div>
            )}
            <input type="file" name="hero_image" accept="image/jpeg,image/png,image/webp" className="text-sm" />
            <p className="mt-1 text-xs text-muted">Wide image, at least 1800×900.</p>
          </div>
          <RichText label="Extra text (optional)" name="body" defaultValue={campaign.body} />
          <Check label="Show announcement bar at the top of every page" name="show_announcement" defaultChecked={campaign.show_announcement} />
          <Field label="Announcement text" name="announcement" defaultValue={campaign.announcement} />
          <SubmitButton>Save landing page</SubmitButton>
        </ActionForm>
      </Card>
    </div>
  );
}
