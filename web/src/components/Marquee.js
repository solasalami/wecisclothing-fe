import Link from "next/link";

/**
 * Right-to-left scrolling announcement (pure CSS, no JS).
 * Two identical groups slide by -50% for a seamless loop; each group repeats the
 * message so the strip is always full. Pauses on hover/focus and stays still for
 * visitors who prefer reduced motion. Screen readers get the message once.
 */
export default function Marquee({ href, children, repeat = 3, seconds = 28, className = "" }) {
  const group = (hidden) => (
    <span className="flex flex-none items-center" aria-hidden={hidden || undefined}>
      {Array.from({ length: repeat }, (_, i) => (
        <span key={i} className="flex flex-none items-center whitespace-nowrap px-8" aria-hidden={(!hidden && i > 0) || undefined}>
          {children}
        </span>
      ))}
    </span>
  );

  return (
    <Link href={href} className={`marquee group relative block overflow-hidden ${className}`}>
      <span className="marquee-track flex w-max" style={{ "--marquee-duration": `${seconds}s` }}>
        {group(false)}
        {group(true)}
      </span>
    </Link>
  );
}
