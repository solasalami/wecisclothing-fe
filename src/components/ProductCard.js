import Link from "next/link";
import ProductImage from "./ProductImage";
import QuickBuy from "./QuickBuy";
import { formatNaira } from "@/lib/format";

/** Cumo-inspired card: tall portrait photo, corner badge, hover "Quick buy", centred title + price. */
export default function ProductCard({ product, priority, sizes = "(max-width: 768px) 70vw, 25vw" }) {
  const onSale = product.compare_at_price && Number(product.compare_at_price) > Number(product.price);
  const badge = !product.in_stock
    ? "Sold out"
    : product.kind === "package"
      ? product.display_badge || product.package_label || "Package"
      : onSale
        ? "Sale"
        : product.display_badge;

  const quick = {
    id: product.id,
    name: product.name,
    slug: product.slug,
    sku: product.sku,
    kind: product.kind,
    price: Number(product.price),
    image: product.image,
    sizes: product.sizes || [],
    in_stock: product.in_stock,
  };

  return (
    <div className="group">
      <div className="relative overflow-hidden bg-soft">
        <Link href={`/product/${product.slug}`} tabIndex={-1} aria-hidden="true" className="block">
          <ProductImage
            src={product.image}
            alt={product.name}
            priority={priority}
            width={600}
            height={900}
            sizes={sizes}
            className="aspect-[2/3] w-full object-cover transition duration-700 ease-out group-hover:scale-[1.03]"
          />
          {product.image_alt && (
            <ProductImage
              src={product.image_alt}
              alt=""
              width={600}
              height={900}
              sizes={sizes}
              className="absolute inset-0 aspect-[2/3] w-full object-cover opacity-0 transition duration-700 group-hover:opacity-100"
            />
          )}
        </Link>
        {badge && (
          <span
            className={`absolute left-3 top-3 px-3 py-1 text-xs tracking-wide ${badge === "Sold out" ? "bg-ink/80 text-white" : "bg-gold text-white"}`}
          >
            {badge}
          </span>
        )}
        {product.in_stock &&
          (product.is_bundle || product.is_pick_bundle ? (
            // A bundle needs a size for each item, so it goes to the product page instead of quick buy.
            <Link
              href={`/product/${product.slug}`}
              className="absolute inset-x-3 bottom-3 hidden translate-y-4 bg-gold py-3 text-center text-xs font-semibold uppercase tracking-[0.18em] text-ink opacity-0 transition duration-300 hover:bg-gold-dark hover:text-white focus:translate-y-0 focus:opacity-100 group-hover:translate-y-0 group-hover:opacity-100 md:block"
            >
              {product.is_pick_bundle ? "Choose outfits" : "Choose sizes"}
            </Link>
          ) : (
            <QuickBuy product={quick} />
          ))}
      </div>
      <Link href={`/product/${product.slug}`} className="mt-4 block px-1 text-center">
        <h3 className="font-sans text-[15px] leading-snug text-ink group-hover:text-gold-dark">{product.name}</h3>
        <p className="mt-1.5 text-[15px] font-medium tracking-wide">
          {product.is_pick_bundle && <span className="mr-1 font-normal text-muted">From</span>}
          {formatNaira(product.price)}
          {onSale && <span className="ml-2 font-normal text-muted line-through">{formatNaira(product.compare_at_price)}</span>}
        </p>
      </Link>
    </div>
  );
}
