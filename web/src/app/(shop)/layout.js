import { getSettings } from "@/lib/settings";
import { getCategoryTree, getShowrooms, getFooterPages } from "@/lib/catalog";
import { CartProvider } from "@/components/CartProvider";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import CartDrawer from "@/components/CartDrawer";
import WhatsAppButton from "@/components/WhatsAppButton";
import TrackingListener from "@/components/TrackingListener";
import { GtmHead, GtmNoScript } from "@/components/Gtm";
import { isCampaignLive } from "@/lib/campaign";

export const dynamic = "force-dynamic";

export default async function ShopLayout({ children }) {
  const [settings, categories, showrooms, pages] = await Promise.all([
    getSettings(),
    getCategoryTree(),
    getShowrooms(),
    getFooterPages(),
  ]);
  const { store, campaign, tracking } = settings;

  return (
    <CartProvider>
      <GtmHead gtmId={tracking.gtm_id} />
      <GtmNoScript gtmId={tracking.gtm_id} />
      <TrackingListener />
      <Header categories={categories} store={store} campaign={campaign} />
      <main>{children}</main>
      <Footer store={store} showrooms={showrooms} categories={categories} pages={pages} campaign={isCampaignLive(campaign) ? campaign : null} />
      <CartDrawer />
      <WhatsAppButton phone={store.whatsapp} message={store.whatsapp_message} />
    </CartProvider>
  );
}
