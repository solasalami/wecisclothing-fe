import Link from "next/link";
import { getSettings } from "@/lib/settings";
import { telLink, whatsappLink } from "@/lib/format";
import { TOPICS, createChallenge } from "@/lib/contact";
import ContactForm from "@/components/ContactForm";
import { PhoneIcon, WhatsAppIcon, MailIcon } from "@/components/icons";

export const dynamic = "force-dynamic"; // a fresh captcha question on every visit

export const metadata = {
  title: "Contact us",
  description: "Send Wecis Clothing a message about orders, custom fits, sizing, delivery or festive packages. We reply within one working day.",
  alternates: { canonical: "/contact-us" },
};

export default async function ContactUsPage() {
  const [{ store }, challenge] = await Promise.all([getSettings(), createChallenge()]);
  return (
    <div className="mx-auto max-w-5xl px-4 py-12">
      <div className="text-center">
        <h1 className="text-4xl">Contact us</h1>
        <p className="mx-auto mt-3 max-w-xl text-muted">
          Questions about an order, a custom fit or our festive packages? Send us a message and we&apos;ll reply within one working day.
        </p>
      </div>

      <div className="mt-10 grid gap-10 lg:grid-cols-[1fr_280px]">
        <section aria-labelledby="form-heading" className="border border-line p-6 md:p-8">
          <h2 id="form-heading" className="mb-6 text-2xl">Send a message</h2>
          <ContactForm topics={TOPICS} initialChallenge={challenge} />
        </section>

        <aside className="space-y-4 text-sm">
          <h2 className="text-xl">Prefer to talk?</h2>
          <a href={whatsappLink(store.whatsapp, store.whatsapp_message)} target="_blank" rel="noopener noreferrer" data-track-location="contact_us" className="flex items-center gap-3 border border-line p-4 hover:border-whatsapp">
            <WhatsAppIcon className="text-whatsapp" /> <span><span className="block font-medium">WhatsApp</span>{store.whatsapp}</span>
          </a>
          <a href={telLink(store.phone)} data-track-location="contact_us" className="flex items-center gap-3 border border-line p-4 hover:border-gold">
            <PhoneIcon /> <span><span className="block font-medium">Call sales</span>{store.phone}</span>
          </a>
          <a href={`mailto:${store.email}`} className="flex items-center gap-3 border border-line p-4 hover:border-gold">
            <MailIcon /> <span><span className="block font-medium">Email</span>{store.email}</span>
          </a>
          <p className="text-muted">
            Want to see the clothes or get measured? <Link href="/contact" className="underline">Visit our showrooms</Link> in Ikeja and Victoria Island.
          </p>
        </aside>
      </div>
    </div>
  );
}
