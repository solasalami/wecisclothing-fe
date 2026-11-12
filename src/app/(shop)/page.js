import Link from "next/link";
import Image from "next/image";
import { getBanners, listProducts, getCategoryTree, getShowrooms } from "@/lib/catalog";
import { getSettings } from "@/lib/settings";
import ProductGrid from "@/components/ProductGrid";
import ProductCard from "@/components/ProductCard";
import ProductCarousel, { CarouselItem } from "@/components/ProductCarousel";
import HeroSlider from "@/components/HeroSlider";
import ShowroomCards from "@/components/ShowroomCards";
import { isCampaignLive, campaignPath } from "@/lib/campaign";
import CampaignPromo from "@/components/CampaignPromo";

export default async function HomePage() {
  const [banners, featured, newest, packages, categories, showrooms, settings] = await Promise.all([
    getBanners("home_hero"),
    listProducts({ featured: true, limit: 12 }),
    listProducts({ sort: "newest", kind: "product", limit: 12 }),
    // Only packages ticked "Feature on homepage"; the campaign page lists every visible package.
    listProducts({ kind: "package", featured: true, limit: 4 }),
    getCategoryTree(),
    getShowrooms(),
    getSettings(),
  ]);
  const { campaign, store } = settings;
  const highlight = featured.items.length ? featured.items : newest.items;

  return (
    <>
      <HeroSlider banners={banners} />

      {/* Shop by gender */}
      <section className="mx-auto mt-12 grid max-w-7xl gap-4 px-4 sm:grid-cols-2">
        {categories.slice(0, 2).map((c) => (
          <Link key={c.id} href={`/category/${c.slug}`} className="group relative block h-56 overflow-hidden bg-ink sm:h-72">
            {c.image && <Image src={c.image} alt={c.name} fill sizes="(max-width:640px) 100vw, 50vw" className="object-cover opacity-70 transition duration-700 group-hover:scale-105" />}
            <div className="absolute inset-0 flex flex-col items-center justify-center text-white">
              <h2 className="text-4xl">{c.name}</h2>
              <span className="mt-3 border-b border-white pb-0.5 text-xs uppercase tracking-widest">Shop the collection</span>
            </div>
          </Link>
        ))}
      </section>

      {isCampaignLive(campaign) && campaign.show_on_home && (
        <section className="mx-auto mt-16 max-w-7xl px-4">
          <CampaignPromo campaign={campaign} />
          {campaign.home_show_packages && packages.items.length > 0 && (
            <div className="mt-10">
              <ProductGrid products={packages.items} />
              {campaign.home_packages_cta && (
                <div className="mt-10 text-center">
                  <Link href={campaignPath(campaign)} className="btn-primary" data-track-location="home_packages">
                    {campaign.home_packages_cta}
                  </Link>
                </div>
              )}
            </div>
          )}
        </section>
      )}

      <section className="mx-auto mt-20 max-w-[1500px] px-4 md:px-8">
        <div className="mb-8 text-center">
          <h2 className="text-3xl md:text-4xl">{featured.items.length ? "Featured styles" : "New arrivals"}</h2>
          <Link href="/shop" className="mt-3 inline-block border-b border-transparent text-xs font-medium uppercase tracking-[0.2em] text-gold-dark hover:border-gold-dark">
            View all
          </Link>
        </div>
        <ProductCarousel label="Featured styles">
          {highlight.map((p, i) => (
            <CarouselItem key={p.id}>
              <ProductCard product={p} priority={i < 4} sizes="(max-width: 640px) 72vw, (max-width: 1024px) 42vw, 23vw" />
            </CarouselItem>
          ))}
        </ProductCarousel>
      </section>

      <section className="mx-auto mt-20 max-w-7xl px-4">
        <div className="mb-8 text-center">
          <h2 className="text-3xl md:text-4xl">Visit our showrooms</h2>
          <p className="mt-2 text-muted">Try on, get measured and talk to a stylist in Ikeja or Victoria Island.</p>
        </div>
        <ShowroomCards showrooms={showrooms} store={store} />
      </section>
    </>
  );
}
