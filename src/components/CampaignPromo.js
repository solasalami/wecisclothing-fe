import Link from "next/link";
import Image from "next/image";

/**
 * Homepage promotion block for the seasonal campaign (Admin → Seasonal campaign → Homepage section).
 * - With an uploaded image: shows the image (optional separate mobile image), linked to the campaign page.
 * - Without one: the champagne text placeholder (eyebrow, title, sub-heading, gold button).
 */
export default function CampaignPromo({ campaign }) {
  const href = `/${campaign.slug}`;
  const title = campaign.home_title || campaign.title;
  const subtitle = campaign.home_subtitle || campaign.subtitle;
  const cta = campaign.home_cta || `Shop ${campaign.name}`;

  if (campaign.home_image) {
    const alt = campaign.home_image_alt || `${title}${subtitle ? `: ${subtitle}` : ""}`;
    return (
      <Link href={href} className="group block overflow-hidden" aria-label={`${title}: ${cta}`}>
        <Image
          src={campaign.home_image}
          alt={alt}
          width={1800}
          height={600}
          sizes="(max-width: 1280px) 100vw, 1280px"
          className={`h-auto w-full transition duration-700 group-hover:scale-[1.01] ${campaign.home_image_mobile ? "hidden md:block" : ""}`}
        />
        {campaign.home_image_mobile && (
          <Image
            src={campaign.home_image_mobile}
            alt={alt}
            width={900}
            height={1100}
            sizes="100vw"
            className="h-auto w-full md:hidden"
          />
        )}
      </Link>
    );
  }

  return (
    <div className="relative border border-gold/50 bg-gold-light px-6 py-14 text-center">
      <div className="pointer-events-none absolute inset-2 border border-gold/30" aria-hidden="true" />
      {campaign.home_eyebrow && <p className="text-xs uppercase tracking-[0.3em] text-gold-dark">{campaign.home_eyebrow}</p>}
      <h2 className="mt-3 text-4xl text-ink md:text-5xl">{title}</h2>
      {subtitle && <p className="mx-auto mt-4 max-w-2xl text-ink/70">{subtitle}</p>}
      <Link href={href} className="btn-primary relative mt-8">
        {cta}
      </Link>
    </div>
  );
}
