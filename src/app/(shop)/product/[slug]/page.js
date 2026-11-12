import { notFound } from "next/navigation";
import Link from "next/link";
import { getProductBySlug, getRelatedProducts, packagesAvailable } from "@/lib/catalog";
import { isCampaignLive, campaignPath } from "@/lib/campaign";
import { getSettings } from "@/lib/settings";
import { formatNaira, whatsappLink, telLink, stripHtml } from "@/lib/format";
import { priceVatNote } from "@/lib/vat";
import ProductGallery from "@/components/ProductGallery";
import AddToCart from "@/components/AddToCart";
import BundleAddToCart from "@/components/BundleAddToCart";
import ProductGrid from "@/components/ProductGrid";
import { WhatsAppIcon, PhoneIcon } from "@/components/icons";

export async function generateMetadata({ params }) {
  const { slug } = await params;
  const p = await getProductBySlug(slug);
  if (!p) return {};
  const description = p.meta_description || p.short_description || stripHtml(p.description).slice(0, 160) || `${p.name}, ${formatNaira(p.price)}`;
  return {
    title: p.meta_title || p.name,
    description,
    alternates: { canonical: `/product/${p.slug}` },
    openGraph: { title: p.name, description, images: p.images.slice(0, 1).map((i) => i.url) },
  };
}

export default async function ProductPage({ params }) {
  const { slug } = await params;
  const product = await getProductBySlug(slug);
  if (!product) notFound();
  const [related, { store, campaign, tax }, packagesOk] = await Promise.all([getRelatedProducts(product), getSettings(), packagesAvailable()]);
  const isPackage = product.kind === "package";
  const campaignLive = isCampaignLive(campaign);
  // Seasonal packages can't be bought outside their campaign (if configured).
  const purchasable = product.in_stock && (!isPackage || packagesOk);
  const vatNote = priceVatNote(product.vat_inclusive, tax);
  const isBundle = Boolean(product.components?.length);
  // Bundles show what the items would cost separately ("Worth"), from compare-at or their total.
  const wasPrice = isBundle ? product.worth : product.compare_at_price;
  const onSale = wasPrice && Number(wasPrice) > Number(product.price);
  const url = `${process.env.NEXT_PUBLIC_SITE_URL || ""}/product/${product.slug}`;

  // Only pass serialisable, client-safe fields to client components.
  const clientProduct = {
    id: product.id,
    name: product.name,
    slug: product.slug,
    sku: product.sku,
    kind: product.kind,
    price: Number(product.price),
    image: product.images[0]?.url || null,
    sizes: product.sizes,
    in_stock: purchasable,
    category: product.categories[0]?.name,
  };

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    image: product.images.map((i) => i.url),
    description: product.short_description || stripHtml(product.description),
    sku: product.sku || String(product.id),
    brand: { "@type": "Brand", name: "Wecis Clothing" },
    offers: {
      "@type": "Offer",
      priceCurrency: "NGN",
      price: Number(product.price),
      availability: purchasable ? "https://schema.org/InStock" : "https://schema.org/OutOfStock",
      url,
    },
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-8">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd).replace(/</g, "\\u003c") }} />
      <nav className="mb-6 text-xs uppercase tracking-wider text-muted">
        <Link href="/" className="hover:text-ink">Home</Link>
        {product.categories[0] && (
          <>
            {" / "}
            <Link href={`/category/${product.categories[0].slug}`} className="hover:text-ink">{product.categories[0].name}</Link>
          </>
        )}
        {" / "}
        <span className="text-ink">{product.name}</span>
      </nav>

      <div className="grid gap-10 md:grid-cols-2">
        <ProductGallery images={product.images} name={product.name} />

        <div>
          {isPackage && campaignLive && (
            <Link href={campaignPath(campaign)} className="mb-3 inline-block bg-gold px-3 py-1 text-xs uppercase tracking-[0.12em] text-white">
              {campaign.name} · {campaign.package_label}
            </Link>
          )}
          {isPackage && !packagesOk && (
            <p className="mb-3 border border-line bg-soft p-3 text-sm">This seasonal package is no longer available. <Link href="/shop" className="underline">Browse the collection</Link></p>
          )}
          <h1 className="text-3xl md:text-4xl">{product.name}</h1>
          <p className="mt-4 text-2xl">
            {formatNaira(product.price)}
            {onSale && (isBundle ? (
              <span className="ml-3 text-lg text-muted">
                Worth <span className="line-through">{formatNaira(wasPrice)}</span>
                <span className="ml-2 text-sm text-green-700">You save {formatNaira(Number(wasPrice) - Number(product.price))}</span>
              </span>
            ) : (
              <span className="ml-3 text-lg text-muted line-through">{formatNaira(wasPrice)}</span>
            ))}
          </p>
          {vatNote && <p className="mt-1 text-xs text-muted">{vatNote}</p>}
          {product.short_description && <p className="mt-4 text-muted">{product.short_description}</p>}

          {product.package_items.length > 0 && (
            <div className="mt-6 border border-gold/40 bg-gold-light/50 p-4">
              <p className="label !text-gold-dark">{isBundle ? "Also included" : <>What&apos;s included</>}</p>
              <ul className="list-disc space-y-1 pl-5 text-sm">
                {product.package_items.map((it, i) => <li key={i}>{it}</li>)}
              </ul>
            </div>
          )}

          {isBundle ? (
            <BundleAddToCart
              product={{ ...clientProduct, out_of_stock_items: product.out_of_stock_items }}
              components={product.components.map(({ id, name, slug, price, sizes, image, is_active }) => ({ id, name, slug, price, sizes, image, is_active }))}
            />
          ) : (
            <AddToCart product={clientProduct} />
          )}

          <div className="mt-6 grid gap-3 sm:grid-cols-2">
            <a
              href={whatsappLink(store.whatsapp, `Hello Wecis Clothing, I'm interested in "${product.name}" (${formatNaira(product.price)}). ${url}`)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="product_page"
              className="btn-whatsapp"
            >
              <WhatsAppIcon width={18} height={18} /> Ask on WhatsApp
            </a>
            <a href={telLink(store.phone)} data-track-location="product_page" className="btn-outline">
              <PhoneIcon width={18} height={18} /> Call sales
            </a>
          </div>
          <p className="mt-3 text-xs text-muted">
            Need a custom fit? Use our <Link href="/size-guide" className="underline">size guide</Link> or visit our Ikeja or Victoria Island showroom to get measured.
          </p>
          <p className="mt-1 text-xs text-muted">
            Delivery across Nigeria or free showroom pick-up. <Link href="/pages/shipping-and-returns" className="underline">Shipping &amp; returns</Link>
          </p>

          {product.description && stripHtml(product.description) && stripHtml(product.description) !== product.short_description && (
            <div className="mt-8 border-t border-line pt-6">
              <h2 className="mb-3 text-xl">Description</h2>
              <div className="prose-wecis text-sm" dangerouslySetInnerHTML={{ __html: product.description }} />
            </div>
          )}
        </div>
      </div>

      {related.length > 0 && (
        <section className="mt-20">
          <h2 className="mb-8 text-center text-3xl">You may also like</h2>
          <ProductGrid products={related} />
        </section>
      )}
    </div>
  );
}
