"use client";
import Link from "next/link";

// Fallback for any other unexpected error on storefront pages.
export default function ShopError({ reset }) {
  return (
    <div className="mx-auto max-w-lg px-4 py-24 text-center">
      <p className="text-xs uppercase tracking-[0.3em] text-gold-dark">Something went wrong</p>
      <h1 className="mt-3 text-4xl">Sorry, this page didn&apos;t load</h1>
      <p className="mt-4 text-muted">Please try again. If it keeps happening, message us on WhatsApp and we&apos;ll help you complete your order.</p>
      <div className="mt-8 flex justify-center gap-3">
        <button onClick={() => reset()} className="btn-primary">Try again</button>
        <Link href="/" className="btn-outline">Home</Link>
      </div>
    </div>
  );
}
