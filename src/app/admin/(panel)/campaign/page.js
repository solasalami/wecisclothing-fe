import ImageUpload from "@/components/admin/ImageUpload";
import Link from "next/link";
import { editProductHref } from "@/lib/admin-back";
import { query } from "@/lib/db";
import { getSetting } from "@/lib/settings";
import { campaignStatus, PROMOS_PATH, campaignMenuLabel } from "@/lib/campaign";
import { formatNaira } from "@/lib/format";
import { pickPoolSize, pickRules } from "@/lib/bundles";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { Field, TextArea, Check, Card, PageHeader, Badge } from "@/components/admin/Fields";
import RichText from "@/components/admin/RichText";
import { saveCampaign, toggleProduct } from "@/app/admin/actions";
import CampaignPromo from "@/components/CampaignPromo";

export const metadata = { title: "Seasonal campaign" };

const STATUS = {
  live: ["green", "Live now"],
  scheduled: ["yellow", "Scheduled"],
  ended: ["gray", "Ended"],
  off: ["gray", "Switched off"],
};

export default async function CampaignAdmin({ searchParams }) {
  const { saved } = await searchParams;
  const [c, packages] = await Promise.all([
    getSetting("campaign"),
    query(`SELECT p.id, p.name, p.price, p.is_active, p.pick_category_id, p.pick_min, p.pick_max, p.pick_prices, c.name AS pick_category,
             (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY sort_order, id LIMIT 1) image,
             (SELECT COUNT(*) FROM package_components pc WHERE pc.package_id = p.id) AS component_count
           FROM products p LEFT JOIN categories c ON c.id = p.pick_category_id
           WHERE p.kind = 'package' ORDER BY p.is_active DESC, p.sort_order, p.id DESC`),
  ]);
  // Pick-your-own packages: how many outfits each can draw on.
  const poolSizes = Object.fromEntries(
    await Promise.all(packages.filter((p) => p.pick_min != null).map(async (p) => [p.id, await pickPoolSize(pickRules(p))]))
  );
  const status = campaignStatus(c);
  const [tone, label] = STATUS[status];

  return (
    <div className="space-y-8">
      <PageHeader title="Seasonal campaign">
        <Link href={PROMOS_PATH} target="_blank" className="btn-outline">{status === "live" ? "View page" : "Preview page"}</Link>
        <Link href="/admin/products/new?kind=package&back=%2Fadmin%2Fcampaign" className="btn-primary">+ New package</Link>
      </PageHeader>
      {saved && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Campaign saved.</p>}

      <Card title="Status">
        <div className="flex flex-wrap items-center gap-3 text-sm">
          <Badge tone={tone}>{label}</Badge>
          <span><strong>{c.name}</strong> at <code className="bg-soft px-1">{PROMOS_PATH}</code>, shown in the menu as &ldquo;{campaignMenuLabel(c)}&rdquo;</span>
          <span className="text-muted">
            {c.starts_at ? `from ${c.starts_at}` : "from now"} {c.ends_at ? `until ${c.ends_at}` : "with no end date"}
            {c.ends_at && (c.hide_after_end ? " (hides automatically after)" : " (stays up after)")}
          </span>
        </div>
        <p className="text-xs text-muted">
          When live, the campaign adds a menu item, an announcement bar, a homepage section and its landing page. Outside the dates everything
          disappears automatically. You can still preview the page while signed in as admin.
        </p>
      </Card>

      <Card title={`Packages (${packages.length})`}>
        <p className="text-sm text-muted">
          A package is a fixed bundle of real products (the shopper picks a size for each), a pick-your-own bundle (the shopper chooses a number of outfits from a list), or a single item with a list of “what’s included”. Packages appear on the promo page{c.hide_packages_when_off ? " and are hidden from the shop outside the campaign dates" : ""}.
          Unpublish last season’s packages before starting a new campaign.
        </p>
        {packages.length === 0 ? (
          <p className="py-2 text-sm">No packages yet. <Link href="/admin/products/new?kind=package&back=%2Fadmin%2Fcampaign" className="underline">Create the first one</Link>.</p>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {packages.map((p) => (
              <div key={p.id} className="border border-line">
                <Link href={editProductHref(p.id, "/admin/campaign")}>
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  {p.image ? <img src={p.image} alt="" className="aspect-[4/5] w-full object-cover" /> : <div className="flex aspect-[4/5] items-center justify-center bg-soft text-xs text-muted">No photo</div>}
                </Link>
                <div className="space-y-1 p-3 text-sm">
                  <Link href={editProductHref(p.id, "/admin/campaign")} className="font-medium underline">{p.name}</Link>
                  <p>{p.pick_min != null ? `From ${formatNaira(p.price)}` : formatNaira(p.price)}</p>
                  <p className="text-xs text-muted">
                    {p.pick_min != null
                      ? `Pick ${p.pick_min === p.pick_max ? p.pick_min : `${p.pick_min} to ${p.pick_max}`} from ${poolSizes[p.id] ?? 0} outfits${p.pick_category ? ` (incl. ${p.pick_category})` : ""}`
                      : Number(p.component_count) > 0
                        ? `Fixed bundle of ${p.component_count} items`
                        : "Simple package"}
                  </p>
                  <div className="flex items-center justify-between">
                    {p.is_active ? <Badge tone="green">Published</Badge> : <Badge>Hidden</Badge>}
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

      <ActionForm action={saveCampaign} className="space-y-6">
        <Card title="Campaign & schedule">
          <Check label="Campaign switched on" name="enabled" defaultChecked={c.enabled} hint="Master switch. Off = hidden regardless of dates." />
          <div className="grid gap-4 sm:grid-cols-2">
            <Field label="Campaign name" name="name" defaultValue={c.name} required hint="Used on the page, badges and in admin, e.g. Detty December, Eid Collection." />
            <Field label="Menu label" name="menu_label" defaultValue={c.menu_label} placeholder="Promos" maxLength={40} hint="Shown in the shop menu and footer. Blank = Promos." />
            <Field label="Start date" name="starts_at" type="date" defaultValue={c.starts_at} hint="Lagos time. Blank = immediately." />
            <Field label="End date" name="ends_at" type="date" defaultValue={c.ends_at} hint="Lagos time. Blank = no end." />
          </div>
          <p className="text-xs text-muted">
            Page address: <strong>wecisclothing.com{PROMOS_PATH}</strong>, the same for every campaign, so ads and printed links never need changing. Older addresses (e.g. /detty-december) redirect there.
          </p>
          <Check label="Hide everything automatically after the end date" name="hide_after_end" defaultChecked={c.hide_after_end} />
          <Check label="Show countdown to the end date" name="show_countdown" defaultChecked={c.show_countdown} />
          <Check label="Hide packages from the shop (and stop sales) when the campaign isn't live" name="hide_packages_when_off" defaultChecked={c.hide_packages_when_off} />
        </Card>

        <Card title="Landing page">
          <Field label="Small heading above the title" name="eyebrow" defaultValue={c.eyebrow} />
          <Field label="Title" name="title" defaultValue={c.title} required />
          <TextArea label="Sub-heading" name="subtitle" rows={2} defaultValue={c.subtitle} />
          <div>
            <span className="label">Hero background image</span>
            {c.hero_image && (
              <div className="mb-2 flex items-center gap-3">
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img src={c.hero_image} alt="" className="h-20 w-36 object-cover" />
                <Check label="Remove" name="remove_hero" />
              </div>
            )}
            <ImageUpload name="hero_image" buttonLabel={c.hero_image ? "Replace image" : "Choose image"} hint="Optional · wide photo, at least 1800×900, shown behind the title. Without one, the homepage banner image (below) is shown at the top of the campaign page instead." />
          </div>
          <Field label="Main button text" name="cta_label" defaultValue={c.cta_label} />
          <RichText label="Extra text (optional)" name="body" defaultValue={c.body} />
          <div className="grid gap-4 sm:grid-cols-2">
            <Field label="Packages heading" name="packages_heading" defaultValue={c.packages_heading} />
            <Field label="Package badge label" name="package_label" defaultValue={c.package_label} hint="e.g. Festive package, Eid package" />
          </div>
          <Field label="Packages sub-heading" name="packages_subheading" defaultValue={c.packages_subheading} />
          <Field label="Message when no packages are published yet" name="empty_message" defaultValue={c.empty_message} />
          <Field label="Pre-filled WhatsApp message" name="whatsapp_message" defaultValue={c.whatsapp_message} />
        </Card>

        <Card title="Homepage section">
          <Check
            label="Publish this section on the homepage"
            name="show_on_home"
            defaultChecked={c.show_on_home}
            hint="Shown only while the campaign is live. Links to the campaign page."
          />

          <div>
            <span className="label">Current preview</span>
            <div className="border border-dashed border-line bg-white p-3">
              <div className="pointer-events-none origin-top-left">
                <CampaignPromo campaign={c} />
              </div>
            </div>
            <p className="mt-1 text-xs text-muted">
              {c.home_image ? "Showing your uploaded image." : "No image uploaded, so the text design below is used as a placeholder."}
            </p>
          </div>

          <div className="grid gap-6 md:grid-cols-2">
            <div>
              <span className="label">Banner image (desktop)</span>
              {c.home_image && (
                <div className="mb-2 flex items-center gap-3">
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img src={c.home_image} alt="" className="h-16 w-40 border border-line object-cover" />
                  <Check label="Remove" name="remove_home_image" />
                </div>
              )}
              <ImageUpload name="home_image" buttonLabel={c.home_image ? "Replace image" : "Choose image"} hint="Wide, e.g. 1800×600 · put any text inside the image" compact />
            </div>
            <div>
              <span className="label">Mobile image (optional)</span>
              {c.home_image_mobile && (
                <div className="mb-2 flex items-center gap-3">
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img src={c.home_image_mobile} alt="" className="h-16 w-12 border border-line object-cover" />
                  <Check label="Remove" name="remove_home_image_mobile" />
                </div>
              )}
              <ImageUpload name="home_image_mobile" buttonLabel={c.home_image_mobile ? "Replace image" : "Choose image"} hint="Portrait, e.g. 900×1100 · falls back to the desktop image" compact />
            </div>
          </div>
          <Field label="Image description (for screen readers & SEO)" name="home_image_alt" defaultValue={c.home_image_alt} placeholder="e.g. Detty December 2026: festive outfits and packages" />

          <p className="pt-2 text-xs uppercase tracking-[0.15em] text-muted">Text (used when there&apos;s no image)</p>
          <div className="grid gap-4 sm:grid-cols-2">
            <Field label="Small heading" name="home_eyebrow" defaultValue={c.home_eyebrow} />
            <Field label="Button text" name="home_cta" defaultValue={c.home_cta} />
          </div>
          <Field label="Title" name="home_title" defaultValue={c.home_title} placeholder={c.title} hint="Blank = same as the landing page title." />
          <TextArea label="Sub-heading" name="home_subtitle" rows={2} defaultValue={c.home_subtitle} placeholder={c.subtitle} hint="Blank = same as the landing page sub-heading." />
          <Check label="Show featured packages under this section" name="home_show_packages" defaultChecked={c.home_show_packages} />
          <p className="-mt-2 text-xs text-muted">Only packages with &quot;Feature on homepage&quot; ticked appear here (up to 4). Every visible package is always listed on the campaign page.</p>
          <Field
            label="Button under the packages"
            name="home_packages_cta"
            defaultValue={c.home_packages_cta}
            placeholder="Explore packages"
            hint={`Links to ${PROMOS_PATH}. Leave blank to hide the button.`}
          />
        </Card>

        <Card title="Announcement bar">
          <Check label="Show the scrolling announcement at the top of every page" name="show_announcement" defaultChecked={c.show_announcement} />
          <Field label="Announcement text" name="announcement" defaultValue={c.announcement} />
        </Card>

        <SubmitButton>Save campaign</SubmitButton>
      </ActionForm>
    </div>
  );
}
