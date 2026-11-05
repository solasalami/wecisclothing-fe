import Image from "next/image";

/** next/image wrapper with a neutral placeholder when a product has no photo yet. */
export default function ProductImage({ src, alt, className = "", width = 600, height = 750, sizes, priority }) {
  if (!src) {
    return (
      <div className={`flex items-center justify-center bg-soft text-xs uppercase tracking-wider text-muted ${className}`} style={{ aspectRatio: `${width}/${height}` }}>
        Photo coming soon
      </div>
    );
  }
  return (
    <Image
      src={src}
      alt={alt || ""}
      width={width}
      height={height}
      sizes={sizes || "(max-width: 768px) 50vw, 25vw"}
      className={className}
      priority={priority}
    />
  );
}
