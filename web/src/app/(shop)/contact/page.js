import { getShowrooms } from "@/lib/catalog";
import { getSettings } from "@/lib/settings";
import { telLink, whatsappLink } from "@/lib/format";
import ShowroomCards from "@/components/ShowroomCards";
import { PhoneIcon, WhatsAppIcon, MailIcon } from "@/components/icons";

export const metadata = {
  title: "Contact us & showrooms",
  description: "Visit Wecis Clothing showrooms in Ikeja and Victoria Island, Lagos, or call/WhatsApp our sales team.",
};

export default async function ContactPage() {
  const [showrooms, { store }] = await Promise.all([getShowrooms(), getSettings()]);
  return (
    <div className="mx-auto max-w-6xl px-4 py-12">
      <div className="text-center">
        <h1 className="text-4xl">Contact us</h1>
        <p className="mx-auto mt-3 max-w-xl text-muted">Our sales representatives are happy to help with sizing, custom orders and delivery.</p>
      </div>
      <div className="mx-auto mt-10 grid max-w-4xl gap-4 sm:grid-cols-3">
        <a href={telLink(store.phone)} data-track-location="contact_page" className="flex flex-col items-center gap-2 border border-line p-6 hover:border-gold">
          <PhoneIcon /> <span className="font-medium">Call sales</span> <span className="text-sm text-muted">{store.phone}</span>
        </a>
        <a href={whatsappLink(store.whatsapp, store.whatsapp_message)} target="_blank" rel="noopener noreferrer" data-track-location="contact_page" className="flex flex-col items-center gap-2 border border-line p-6 hover:border-whatsapp">
          <WhatsAppIcon className="text-whatsapp" /> <span className="font-medium">WhatsApp</span> <span className="text-sm text-muted">{store.whatsapp}</span>
        </a>
        <a href={`mailto:${store.email}`} className="flex flex-col items-center gap-2 border border-line p-6 hover:border-gold">
          <MailIcon /> <span className="font-medium">Email</span> <span className="text-sm text-muted">{store.email}</span>
        </a>
      </div>
      <h2 className="mb-6 mt-16 text-center text-3xl">Our showrooms</h2>
      <ShowroomCards showrooms={showrooms} store={store} location="contact_page_showroom" />
    </div>
  );
}
