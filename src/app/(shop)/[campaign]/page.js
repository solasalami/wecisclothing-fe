import { notFound, permanentRedirect } from "next/navigation";
import Image from "next/image";
import Link from "next/link";
import { getSettings } from "@/lib/settings";
import { getAdmin } from "@/lib/auth";
import { listProducts, getShowrooms } from "@/lib/catalog";
import { campaignStatus, countdownEnd } from "@/lib/campaign";
import { whatsappLink, telLink, stripHtml } from "@/lib/format";
import ProductGrid from "@/components/ProductGrid";
import ShowroomCards from "@/components/ShowroomCards";
import Countdown from "@/components/Countdown";
import { WhatsAppIcon, PhoneIcon } from "@/components/icons";

// Seasonal campaign landing page. The URL, wording, dates and imagery all come
// from Admin → Seasonal campaign, so the same page serves every season.

async function resolve(slug) {
  const { campaign, store } = await getSettings();
  if (slug !== campaign.slug) {
    if ((campaign.previous_slugs || []).includes(slug)) permanentRedirect(`/${campaign.slug}`);
    return null;
  }
  return { campaign, store, status: campaignStatus(campaign) };
}

export async function generateMetadata({ params }) {
  const { campaign: slug } = await params;
  const r = await resolve(slug);
  if (!r) return {};
  const { campaign, status } = r;
  return {
    title: campaign.title,
    description: campaign.subtitle || stripHtml(campaign.body).slice(0, 160),
    alternates: { canonical: `/${campaign.slug}` },
    robots: status === "live" ? undefined : { index: false },
    openGraph: { title: campaign.title, description: campaign.subtitle, images: campaign.hero_image ? [campaign.hero_image] : [] },
  };
}

export default async function CampaignPage({ params }) {
  const { campaign: slug } = await params;
  const r = await resolve(slug);
  if (!r) notFound();
  const { campaign, store, status } = r;

  // Admins can preview a scheduled/ended/disabled campaign; shoppers get a 404.
  const isPreview = status !== "live";
  if (isPreview && !(await getAdmin())) notFound();

  const [packages, showrooms] = await Promise.all([listProducts({ kind: "package", limit: 48 }), getShowrooms()]);
  const end = countdownEnd(campaign);
  const hasHero = Boolean(campaign.hero_image);

  return (
    <div>
      {isPreview && (
        <div className="bg-ink px-4 py-2 text-center text-xs uppercase tracking-[0.15em] text-white">
          Admin preview: this campaign is <strong>{status}</strong> and hidden from shoppers.{" "}
          <Link href="/admin/campaign" className="underline">Edit campaign</Link>
        </div>
      )}

      {/* Champagne hero by default; with an uploaded photo, a soft dark overlay keeps text readable. */}
      <section className={`relative overflow-hidden ${hasHero ? "bg-ink text-white" : "border-b border-gold/40 bg-gold-light text-ink"}`}>
        {hasHero && (
          <>
            <Image src={campaign.hero_image} alt={campaign.title} fill priority sizes="100vw" className="object-cover" />
            <div className="absolute inset-0 bg-gradient-to-b from-black/55 via-black/40 to-black/60" aria-hidden="true" />
          </>
        )}
        <div className="relative mx-auto max-w-5xl px-4 py-20 text-center md:py-28">
          {campaign.eyebrow && <p className={`text-xs uppercase tracking-[0.35em] ${hasHero ? "text-gold" : "text-gold-dark"}`}>{campaign.eyebrow}</p>}
          <h1 className="mt-4 text-5xl leading-tight md:text-7xl">{campaign.title}</h1>
          {campaign.subtitle && <p className={`mx-auto mt-5 max-w-2xl text-lg ${hasHero ? "text-white/85" : "text-ink/70"}`}>{campaign.subtitle}</p>}
          {end && (
            <div className="mt-8">
              <Countdown endsAt={end} tone={hasHero ? "dark" : "light"} />
            </div>
          )}
          <div className="mt-10 flex flex-wrap justify-center gap-3">
            <a href="#packages" className="btn-primary">{campaign.cta_label || "Shop now"}</a>
            <a
              href={whatsappLink(store.whatsapp, campaign.whatsapp_message || store.whatsapp_message)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="campaign_hero"
              className="btn-whatsapp"
            >
              <WhatsAppIcon width={18} height={18} /> Order on WhatsApp
            </a>
          </div>
        </div>
      </section>

      {campaign.body && (
        <section className="mx-auto max-w-3xl px-4 pt-14">
          <div className="prose-wecis text-center" dangerouslySetInnerHTML={{ __html: campaign.body }} />
        </section>
      )}

      <section id="packages" className="mx-auto max-w-7xl scroll-mt-32 px-4 pt-14">
        <h2 className="mb-2 text-center text-4xl">{campaign.packages_heading}</h2>
        {campaign.packages_subheading && <p className="mb-10 text-center text-muted">{campaign.packages_subheading}</p>}
        {packages.items.length ? (
          <ProductGrid products={packages.items} priorityCount={4} />
        ) : (
          <div className="mx-auto max-w-xl border border-gold/40 bg-gold-light/50 p-8 text-center">
            <p className="text-lg">{campaign.empty_message}</p>
            <p className="mt-2 text-muted">Message us to reserve yours or book a fitting.</p>
            <a
              href={whatsappLink(store.whatsapp, `Hello Wecis Clothing, please notify me when the ${campaign.name} collection is available.`)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="campaign_empty"
              className="btn-whatsapp mt-6"
            >
              <WhatsAppIcon width={18} height={18} /> Notify me on WhatsApp
            </a>
          </div>
        )}
      </section>

      <section className="mx-auto mt-20 grid max-w-7xl gap-6 px-4 text-center md:grid-cols-3">
        {[
          ["Made in Lagos", "Handcrafted by our in-house tailors with premium fabrics."],
          ["Custom fit available", "Get measured at our Ikeja or Victoria Island showroom."],
          ["Pay securely online", "Checkout with card, bank transfer or USSD via OPay."],
        ].map(([t, d]) => (
          <div key={t} className="border border-line p-6">
            <h3 className="text-xl">{t}</h3>
            <p className="mt-2 text-sm text-muted">{d}</p>
          </div>
        ))}
      </section>

      <section className="mx-auto mt-20 max-w-7xl px-4">
        <div className="mb-8 text-center">
          <h2 className="text-3xl">Talk to a sales representative</h2>
          <div className="mt-5 flex flex-wrap justify-center gap-3">
            <a href={telLink(store.phone)} data-track-location="campaign_contact" className="btn-primary">
              <PhoneIcon width={18} height={18} /> Call {store.phone}
            </a>
            <a href={whatsappLink(store.whatsapp, store.whatsapp_message)} target="_blank" rel="noopener noreferrer" data-track-location="campaign_contact" className="btn-whatsapp">
              <WhatsAppIcon width={18} height={18} /> WhatsApp
            </a>
          </div>
        </div>
        <ShowroomCards showrooms={showrooms} store={store} location="campaign_showroom" />
        <p className="mt-8 text-center">
          <Link href="/shop" className="underline">Or browse the full collection</Link>
        </p>
      </section>
    </div>
  );
}
