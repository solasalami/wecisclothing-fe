"use client";
import { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";

export default function HeroSlider({ banners }) {
  const [i, setI] = useState(0);
  useEffect(() => {
    if (banners.length < 2) return;
    const t = setInterval(() => setI((v) => (v + 1) % banners.length), 6000);
    return () => clearInterval(t);
  }, [banners.length]);
  if (!banners.length) return null;

  return (
    <section className="relative w-full overflow-hidden bg-soft" style={{ aspectRatio: "1800/718" }}>
      {banners.map((b, idx) => {
        const img = (
          <Image
            src={b.image}
            alt={b.title || "Wecis Clothing"}
            fill
            priority={idx === 0}
            sizes="100vw"
            className="object-cover"
          />
        );
        return (
          <div key={b.id} className={`absolute inset-0 transition-opacity duration-1000 ${idx === i ? "opacity-100" : "pointer-events-none opacity-0"}`}>
            {b.link ? <Link href={b.link}>{img}</Link> : img}
            {(b.subtitle || b.button_label) && (
              <div className="absolute inset-x-0 bottom-6 flex flex-col items-center gap-3 text-center">
                {b.subtitle && <p className="bg-white/80 px-3 py-1 text-sm">{b.subtitle}</p>}
                {b.button_label && b.link && <Link href={b.link} className="btn-primary">{b.button_label}</Link>}
              </div>
            )}
          </div>
        );
      })}
      {banners.length > 1 && (
        <div className="absolute bottom-3 left-1/2 flex -translate-x-1/2 gap-2">
          {banners.map((b, idx) => (
            <button
              key={b.id}
              onClick={() => setI(idx)}
              aria-label={`Show banner ${idx + 1}`}
              className={`h-2 rounded-full transition-all ${idx === i ? "w-6 bg-ink" : "w-2 bg-ink/30"}`}
            />
          ))}
        </div>
      )}
    </section>
  );
}
