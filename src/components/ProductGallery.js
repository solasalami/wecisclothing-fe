"use client";
import { useState } from "react";
import ProductImage from "./ProductImage";

export default function ProductGallery({ images, name }) {
  const [active, setActive] = useState(0);
  if (!images.length) return <ProductImage src={null} alt={name} className="w-full" />;
  return (
    <div className="flex flex-col-reverse gap-3 md:flex-row">
      {images.length > 1 && (
        <div className="flex gap-2 overflow-x-auto md:w-20 md:flex-col">
          {images.map((img, i) => (
            <button
              key={img.id}
              onClick={() => setActive(i)}
              className={`flex-none border-2 ${i === active ? "border-gold" : "border-transparent"}`}
              aria-label={`View image ${i + 1}`}
            >
              <ProductImage src={img.url} alt={img.alt || name} width={80} height={100} className="h-24 w-20 object-cover" />
            </button>
          ))}
        </div>
      )}
      <div className="flex-1 bg-soft">
        <ProductImage
          src={images[active].url}
          alt={images[active].alt || name}
          width={900}
          height={1125}
          priority
          sizes="(max-width: 768px) 100vw, 50vw"
          className="aspect-[4/5] w-full object-cover"
        />
      </div>
    </div>
  );
}
