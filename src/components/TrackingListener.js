"use client";
import { useEffect } from "react";
import { usePathname } from "next/navigation";
import { pushEvent, captureAttribution } from "@/lib/analytics";

/**
 * One delegated click listener for every WhatsApp and phone link on the site,
 * so new buttons are tracked automatically. Links may set data-track-location
 * (e.g. "floating_button", "header", "product_page") for reporting.
 */
export default function TrackingListener() {
  const pathname = usePathname();

  useEffect(() => {
    captureAttribution();
  }, []);

  useEffect(() => {
    function onClick(e) {
      const a = e.target.closest?.("a[href]");
      if (!a) return;
      const href = a.getAttribute("href") || "";
      const location = a.dataset.trackLocation || "unspecified";
      if (/^https:\/\/(wa\.me|api\.whatsapp\.com)/.test(href)) {
        pushEvent("whatsapp_click", { contact_method: "whatsapp", link_location: location, page_path: pathname, link_url: href.split("?")[0] });
      } else if (href.startsWith("tel:")) {
        pushEvent("phone_click", { contact_method: "phone", link_location: location, page_path: pathname, phone_number: href.slice(4) });
      }
    }
    document.addEventListener("click", onClick, { capture: true });
    return () => document.removeEventListener("click", onClick, { capture: true });
  }, [pathname]);

  return null;
}
