"use client";
import { useCallback, useEffect, useRef, useState } from "react";

/**
 * Horizontal, swipeable product row with scroll-snap. Shows ~4 cards on desktop
 * with the next one peeking in, and square prev/next arrows on the edges.
 */
export default function ProductCarousel({ children, label = "Products" }) {
  const track = useRef(null);
  const [edges, setEdges] = useState({ start: true, end: false });

  const update = useCallback(() => {
    const el = track.current;
    if (!el) return;
    setEdges({ start: el.scrollLeft <= 4, end: el.scrollLeft + el.clientWidth >= el.scrollWidth - 4 });
  }, []);

  useEffect(() => {
    const el = track.current;
    if (!el) return;
    const raf = requestAnimationFrame(update);
    el.addEventListener("scroll", update, { passive: true });
    window.addEventListener("resize", update);
    return () => {
      cancelAnimationFrame(raf);
      el.removeEventListener("scroll", update);
      window.removeEventListener("resize", update);
    };
  }, [update]);

  function scroll(dir) {
    const el = track.current;
    const card = el?.firstElementChild;
    if (!card) return;
    el.scrollBy({ left: dir * (card.getBoundingClientRect().width + 24), behavior: "smooth" });
  }

  return (
    <div className="relative" role="region" aria-roledescription="carousel" aria-label={label}>
      <div
        ref={track}
        className="flex snap-x snap-mandatory gap-4 overflow-x-auto scroll-smooth pb-2 [scrollbar-width:none] md:gap-6 [&::-webkit-scrollbar]:hidden"
      >
        {children}
      </div>
      <ArrowButton side="left" hidden={edges.start} onClick={() => scroll(-1)} />
      <ArrowButton side="right" hidden={edges.end} onClick={() => scroll(1)} />
    </div>
  );
}

function ArrowButton({ side, hidden, onClick }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={side === "left" ? "Previous products" : "Next products"}
      className={`absolute top-[38%] z-10 hidden h-9 w-9 -translate-y-1/2 items-center justify-center bg-white/90 text-ink shadow-sm transition hover:bg-gold md:flex ${
        side === "left" ? "left-3" : "right-3"
      } ${hidden ? "pointer-events-none opacity-0" : "opacity-100"}`}
    >
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
        {side === "left" ? <path d="M15 18l-6-6 6-6" /> : <path d="M9 18l6-6-6-6" />}
      </svg>
    </button>
  );
}

/** Wrapper for each slide: ~1.3 cards on mobile, ~2.3 on tablet, ~4.2 on desktop (next card peeks in). */
export function CarouselItem({ children }) {
  return <div className="w-[72%] flex-none snap-start sm:w-[42%] lg:w-[23%]">{children}</div>;
}
