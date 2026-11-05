import ProductCard from "./ProductCard";

export default function ProductGrid({ products, priorityCount = 0 }) {
  if (!products.length) return <p className="py-10 text-center text-muted">No products found.</p>;
  return (
    <div className="grid grid-cols-2 gap-x-4 gap-y-10 md:grid-cols-3 lg:grid-cols-4">
      {products.map((p, i) => (
        <ProductCard key={p.id} product={p} priority={i < priorityCount} />
      ))}
    </div>
  );
}
