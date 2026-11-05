import { notFound } from "next/navigation";
import Image from "next/image";
import Link from "next/link";
import { getSettings } from "@/lib/settings";
import { listProducts, getShowrooms } from "@/lib/catalog";
import { whatsappLink, telLink } from "@/lib/format";
import ProductGrid from "@/components/ProductGrid";
import ShowroomCards from "@/components/ShowroomCards";
import Countdown from "@/components/Countdown";
import { WhatsAppIcon, PhoneIcon } from "@/components/icons";

export async function generateMetadata() {
  const { campaign } = await getSettings();
  return {
    title: campaign.title,
    description: campaign.subtitle,
    alternates: { canonical: "/detty-december" },
    openGraph: { title: campaign.title, description: campaign.subtitle, images: campaign.hero_image ? [campaign.hero_image] : [] },
  };
}

export default async function DettyDecemberPage() {
  const [{ campaign, store }, packages, showrooms] = await Promise.all([
    getSettings(),
    listProducts({ kind: "package", limit: 48 }),
    getShowrooms(),
  ]);
  if (!campaign.enabled) notFound();

  return (
    <div>
      {/* Hero */}
      <section className="relative overflow-hidden bg-black text-white">
        {campaign.hero_image && (
          <Image src={campaign.hero_image} alt={campaign.title} fill priority sizes="100vw" className="object-cover opacity-50" />
        )}
        <div className="relative mx-auto max-w-5xl px-4 py-20 text-center md:py-28">
          <p className="text-xs uppercase tracking-[0.35em] text-festive">Wecis Clothing presents</p>
          <h1 className="mt-4 text-5xl leading-tight md:text-7xl">{campaign.title}</h1>
          <p className="mx-auto mt-5 max-w-2xl text-lg text-white/85">{campaign.subtitle}</p>
          {campaign.ends_at && (
            <div className="mt-8">
              <Countdown endsAt={campaign.ends_at} />
            </div>
          )}
          <div className="mt-10 flex flex-wrap justify-center gap-3">
            <a href="#packages" className="btn-festive">Shop the packages</a>
            <a
              href={whatsappLink(store.whatsapp, "Hello Wecis Clothing, I'd like to order a Detty December package.")}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="detty_december_hero"
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

      {/* Packages */}
      <section id="packages" className="mx-auto max-w-7xl scroll-mt-32 px-4 pt-14">
        <h2 className="mb-2 text-center text-4xl">Festive packages</h2>
        <p className="mb-10 text-center text-muted">Curated looks for owambe, concerts, Christmas and New Year.</p>
        {packages.items.length ? (
          <ProductGrid products={packages.items} priorityCount={4} />
        ) : (
          <div className="mx-auto max-w-xl border border-festive/40 bg-festive/5 p-8 text-center">
            <p className="text-lg">Our Detty December packages are dropping soon.</p>
            <p className="mt-2 text-muted">Message us to reserve yours or book a fitting.</p>
            <a
              href={whatsappLink(store.whatsapp, "Hello Wecis Clothing, please notify me when Detty December packages are available.")}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="detty_december_empty"
              className="btn-whatsapp mt-6"
            >
              <WhatsAppIcon width={18} height={18} /> Notify me on WhatsApp
            </a>
          </div>
        )}
      </section>

      {/* Why / trust */}
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

      {/* Contact */}
      <section className="mx-auto mt-20 max-w-7xl px-4">
        <div className="mb-8 text-center">
          <h2 className="text-3xl">Talk to a sales representative</h2>
          <div className="mt-5 flex flex-wrap justify-center gap-3">
            <a href={telLink(store.phone)} data-track-location="detty_december_contact" className="btn-primary">
              <PhoneIcon width={18} height={18} /> Call {store.phone}
            </a>
            <a href={whatsappLink(store.whatsapp, store.whatsapp_message)} target="_blank" rel="noopener noreferrer" data-track-location="detty_december_contact" className="btn-whatsapp">
              <WhatsAppIcon width={18} height={18} /> WhatsApp
            </a>
          </div>
        </div>
        <ShowroomCards showrooms={showrooms} store={store} location="detty_december_showroom" />
        <p className="mt-8 text-center">
          <Link href="/shop" className="underline">Or browse the full collection</Link>
        </p>
      </section>
    </div>
  );
}
