import Link from "next/link";
import Image from "next/image";
import { getBanners, listProducts, getCategoryTree, getShowrooms } from "@/lib/catalog";
import { getSettings } from "@/lib/settings";
import ProductGrid from "@/components/ProductGrid";
import HeroSlider from "@/components/HeroSlider";
import ShowroomCards from "@/components/ShowroomCards";

export default async function HomePage() {
  const [banners, featured, newest, packages, categories, showrooms, settings] = await Promise.all([
    getBanners("home_hero"),
    listProducts({ featured: true, limit: 8 }),
    listProducts({ sort: "newest", kind: "product", limit: 8 }),
    listProducts({ kind: "package", limit: 4 }),
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

      {campaign.enabled && (
        <section className="mx-auto mt-16 max-w-7xl px-4">
          <div className="bg-gradient-to-r from-black via-[#1a1405] to-black px-6 py-12 text-center text-white">
            <p className="text-xs uppercase tracking-[0.3em] text-festive">Limited season collection</p>
            <h2 className="mt-3 text-4xl md:text-5xl">{campaign.title}</h2>
            <p className="mx-auto mt-4 max-w-2xl text-white/80">{campaign.subtitle}</p>
            <Link href={`/${campaign.slug}`} className="btn-festive mt-8">
              Explore festive packages
            </Link>
          </div>
          {packages.items.length > 0 && (
            <div className="mt-10">
              <ProductGrid products={packages.items} />
            </div>
          )}
        </section>
      )}

      <section className="mx-auto mt-16 max-w-7xl px-4">
        <div className="mb-8 text-center">
          <h2 className="text-3xl md:text-4xl">{featured.items.length ? "Featured styles" : "New arrivals"}</h2>
          <p className="mt-2 text-muted">Handcrafted African-inspired pieces, made in Lagos.</p>
        </div>
        <ProductGrid products={highlight} priorityCount={4} />
        <div className="mt-10 text-center">
          <Link href="/shop" className="btn-outline">View all products</Link>
        </div>
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
