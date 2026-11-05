import Link from "next/link";
import ProductImage from "./ProductImage";
import { formatNaira } from "@/lib/format";

export default function ProductCard({ product, priority }) {
  const onSale = product.compare_at_price && Number(product.compare_at_price) > Number(product.price);
  return (
    <Link href={`/product/${product.slug}`} className="group block">
      <div className="relative overflow-hidden bg-soft">
        <ProductImage
          src={product.image}
          alt={product.name}
          priority={priority}
          className="aspect-[4/5] w-full object-cover transition duration-500 group-hover:scale-105"
        />
        {product.image_alt && (
          <ProductImage
            src={product.image_alt}
            alt=""
            className="absolute inset-0 aspect-[4/5] w-full object-cover opacity-0 transition duration-500 group-hover:opacity-100"
          />
        )}
        <div className="absolute left-2 top-2 flex flex-col gap-1">
          {product.kind === "package" && <span className="bg-festive px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider">Package</span>}
          {onSale && <span className="bg-ink px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider text-white">Sale</span>}
          {!product.in_stock && <span className="bg-white px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider">Sold out</span>}
        </div>
      </div>
      <div className="mt-3 text-center">
        <h3 className="font-sans text-sm leading-snug group-hover:text-brand-dark">{product.name}</h3>
        <p className="mt-1 text-sm font-medium">
          {formatNaira(product.price)}
          {onSale && <span className="ml-2 text-muted line-through">{formatNaira(product.compare_at_price)}</span>}
        </p>
      </div>
    </Link>
  );
}
