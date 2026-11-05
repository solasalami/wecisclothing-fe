import Link from "next/link";
import { telLink, whatsappLink } from "@/lib/format";
import { PinIcon, PhoneIcon, MailIcon, WhatsAppIcon, ClockIcon } from "./icons";

export default function Footer({ store, showrooms, categories, pages }) {
  return (
    <footer className="mt-20 bg-ink text-sm text-white/80">
      {/* Showrooms strip */}
      <div className="border-b border-white/10">
        <div className="mx-auto grid max-w-7xl gap-6 px-4 py-10 md:grid-cols-2">
          {showrooms.map((s) => (
            <div key={s.id} className="flex gap-4">
              <PinIcon className="mt-1 flex-none text-brand" />
              <div>
                <h3 className="font-display text-lg text-white">{s.name}</h3>
                <p>{s.address}</p>
                {s.hours && (
                  <p className="mt-1 flex items-center gap-1.5 text-white/60">
                    <ClockIcon width={14} height={14} /> {s.hours}
                  </p>
                )}
                <div className="mt-2 flex flex-wrap gap-4">
                  {s.phone && (
                    <a href={telLink(s.phone)} data-track-location={`footer_showroom_${s.id}`} className="text-brand hover:underline">
                      Call {s.phone}
                    </a>
                  )}
                  {s.map_url && (
                    <a href={s.map_url} target="_blank" rel="noopener noreferrer" className="hover:underline">
                      Get directions
                    </a>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="mx-auto grid max-w-7xl gap-10 px-4 py-12 sm:grid-cols-2 lg:grid-cols-4">
        <div>
          <h3 className="mb-4 font-display text-xl text-white">{store.name}</h3>
          <p className="leading-relaxed">{store.tagline}. Est. 2015.</p>
        </div>
        <div>
          <h4 className="mb-4 text-xs font-bold uppercase tracking-widest text-white">Shop</h4>
          <ul className="space-y-2">
            {categories.map((c) => (
              <li key={c.slug}>
                <Link href={`/category/${c.slug}`} className="hover:text-brand">{c.name}</Link>
              </li>
            ))}
            <li><Link href="/detty-december" className="hover:text-brand">Detty December</Link></li>
            <li><Link href="/shop" className="hover:text-brand">All products</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="mb-4 text-xs font-bold uppercase tracking-widest text-white">Information</h4>
          <ul className="space-y-2">
            {pages.map((p) => (
              <li key={p.slug}>
                <Link href={`/pages/${p.slug}`} className="hover:text-brand">{p.title}</Link>
              </li>
            ))}
            <li><Link href="/contact" className="hover:text-brand">Contact &amp; showrooms</Link></li>
            <li><Link href="/account" className="hover:text-brand">My account</Link></li>
          </ul>
        </div>
        <div>
          <h4 className="mb-4 text-xs font-bold uppercase tracking-widest text-white">Talk to sales</h4>
          <ul className="space-y-3">
            <li>
              <a href={telLink(store.phone)} data-track-location="footer" className="flex items-center gap-2 hover:text-brand">
                <PhoneIcon width={16} height={16} /> {store.phone}
              </a>
            </li>
            <li>
              <a
                href={whatsappLink(store.whatsapp, store.whatsapp_message)}
                target="_blank"
                rel="noopener noreferrer"
                data-track-location="footer"
                className="flex items-center gap-2 hover:text-brand"
              >
                <WhatsAppIcon width={16} height={16} /> WhatsApp {store.whatsapp}
              </a>
            </li>
            <li>
              <a href={`mailto:${store.email}`} className="flex items-center gap-2 hover:text-brand">
                <MailIcon width={16} height={16} /> {store.email}
              </a>
            </li>
          </ul>
        </div>
      </div>
      <div className="border-t border-white/10 py-5 text-center text-xs text-white/50">
        © {new Date().getFullYear()} {store.name}. All rights reserved. Prices in Nigerian Naira (₦).
      </div>
    </footer>
  );
}
