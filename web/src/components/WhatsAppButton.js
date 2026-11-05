import { whatsappLink } from "@/lib/format";
import { WhatsAppIcon } from "./icons";

/** Always-visible floating WhatsApp button (bottom-right, above the mobile safe area). */
export default function WhatsAppButton({ phone, message }) {
  if (!phone) return null;
  return (
    <a
      href={whatsappLink(phone, message)}
      target="_blank"
      rel="noopener noreferrer"
      data-track-location="floating_button"
      aria-label="Chat with Wecis Clothing on WhatsApp"
      className="fixed bottom-5 right-4 z-50 flex items-center gap-2 rounded-full bg-whatsapp px-4 py-3 text-white shadow-lg shadow-black/20 transition hover:scale-105 md:bottom-8 md:right-8"
      style={{ marginBottom: "env(safe-area-inset-bottom)" }}
    >
      <WhatsAppIcon width={26} height={26} />
      <span className="hidden text-sm font-medium sm:inline">Chat on WhatsApp</span>
    </a>
  );
}
