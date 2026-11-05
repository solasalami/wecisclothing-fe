import { telLink, whatsappLink } from "@/lib/format";
import { PinIcon, ClockIcon, PhoneIcon, WhatsAppIcon } from "./icons";

export default function ShowroomCards({ showrooms, store, location = "showroom_card" }) {
  return (
    <div className="grid gap-6 md:grid-cols-2">
      {showrooms.map((s) => (
        <div key={s.id} className="border border-line p-6">
          <h3 className="flex items-center gap-2 text-2xl">
            <PinIcon className="text-brand-dark" /> {s.name}
          </h3>
          <p className="mt-3">{s.address}</p>
          {s.hours && (
            <p className="mt-2 flex items-center gap-2 text-sm text-muted">
              <ClockIcon width={16} height={16} /> {s.hours}
            </p>
          )}
          <div className="mt-5 flex flex-wrap gap-3">
            <a href={telLink(s.phone || store.phone)} data-track-location={location} className="btn-primary !px-4 !py-2.5">
              <PhoneIcon width={16} height={16} /> Call
            </a>
            <a
              href={whatsappLink(s.whatsapp || store.whatsapp, `Hello Wecis Clothing, I'd like to visit your ${s.name}.`)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location={location}
              className="btn-whatsapp !px-4 !py-2.5"
            >
              <WhatsAppIcon width={16} height={16} /> WhatsApp
            </a>
            {s.map_url && (
              <a href={s.map_url} target="_blank" rel="noopener noreferrer" className="btn-outline !px-4 !py-2.5">
                Directions
              </a>
            )}
          </div>
        </div>
      ))}
    </div>
  );
}
