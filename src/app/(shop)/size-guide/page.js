import Link from "next/link";
import { getSettings } from "@/lib/settings";
import { whatsappLink } from "@/lib/format";
import SizeGuide from "@/components/SizeGuide";

export const metadata = {
  title: "Size guide",
  description: "Find your Wecis Clothing size for native wear, agbada, kaftans and ready-to-wear, in inches or centimetres, or order a custom fit.",
  alternates: { canonical: "/size-guide" },
};

const HOW_TO = [
  ["Bust / chest", "Wrap the tape around the fullest part, under your arms and across your shoulder blades. Keep it level."],
  ["Waist", "Measure around your natural waist, usually just above the navel. Breathe out normally; don't hold your stomach in."],
  ["Hips / seat", "Stand with your feet together and measure around the fullest part of your hips and seat."],
  ["Height", "Stand straight against a wall without shoes. Helpful for agbada, kaftan and gown lengths on custom orders."],
];

const CUSTOM = [
  ["Shoulder", "From the edge of one shoulder to the other, across the back."],
  ["Sleeve length", "From the shoulder edge down to where you want the sleeve to end (wrist for long sleeves)."],
  ["Top length", "From the highest point of the shoulder, down the front, to where the top should end."],
  ["Round sleeve / bicep", "Around the fullest part of the upper arm."],
  ["Neck", "Around the base of the neck. Add a finger's width for comfort."],
  ["Trouser length", "From the waist down the outside of the leg to the ankle or floor."],
  ["Thigh and ankle", "Around the fullest part of the thigh, and around the ankle for trouser openings."],
  ["Cap (fila) / gele", "Around the head, across the forehead and just above the ears."],
];

export default async function SizeGuidePage({ searchParams }) {
  const { for: forParam } = await searchParams;
  const { size_guide: guide, store } = await getSettings();
  return (
    <div className="mx-auto max-w-4xl px-4 py-12">
      <div className="text-center">
        <h1 className="text-4xl">Size guide</h1>
        {guide.intro && <p className="mx-auto mt-3 max-w-2xl text-muted">{guide.intro}</p>}
      </div>

      <div className="mt-10">
        <SizeGuide guide={guide} whatsapp={store.whatsapp} initialGender={forParam} />
      </div>

      {guide.fit_note && (
        <p className="mt-8 border-l-4 border-gold bg-gold-light/40 p-4 text-sm">{guide.fit_note}</p>
      )}

      <section className="mt-12">
        <h2 className="text-2xl">How to measure</h2>
        <p className="mt-1 text-sm text-muted">
          Use a soft tailor&apos;s tape over light clothing. Keep the tape snug but not tight. If you are between two sizes, choose the larger one.
        </p>
        <ol className="mt-5 grid gap-4 sm:grid-cols-2">
          {HOW_TO.map(([title, text], i) => (
            <li key={title} className="flex gap-3 border border-line p-4">
              <span className="flex h-7 w-7 flex-none items-center justify-center rounded-full bg-gold text-sm font-medium">{i + 1}</span>
              <span>
                <span className="block font-medium">{title}</span>
                <span className="block text-sm text-muted">{text}</span>
              </span>
            </li>
          ))}
        </ol>
      </section>

      <section className="mt-12 border border-line p-6 md:p-8">
        <h2 className="text-2xl">Custom fit (made to measure)</h2>
        <p className="mt-2 text-sm">
          Want it tailored to you? Choose <strong>Custom</strong> as your size when you order, then send us these measurements on WhatsApp,
          or visit our Ikeja or Victoria Island showroom and our tailors will measure you. Custom pieces usually take 7 to 14 working days.
        </p>
        <dl className="mt-5 grid gap-x-8 gap-y-3 text-sm sm:grid-cols-2">
          {CUSTOM.map(([title, text]) => (
            <div key={title}>
              <dt className="font-medium">{title}</dt>
              <dd className="text-muted">{text}</dd>
            </div>
          ))}
        </dl>
        <div className="mt-6 flex flex-wrap gap-3">
          <a
            href={whatsappLink(store.whatsapp, "Hello Wecis Clothing, I'd like a custom fit. Here are my measurements:")}
            target="_blank"
            rel="noopener noreferrer"
            data-track-location="size_guide_custom"
            className="btn-whatsapp"
          >
            Send measurements on WhatsApp
          </a>
          <Link href="/contact" className="btn-outline">Visit a showroom</Link>
        </div>
      </section>

      <p className="mt-10 text-center text-sm text-muted">
        Wrong size? See our <Link href="/pages/shipping-and-returns" className="underline">shipping and returns policy</Link> for exchanges.
      </p>
    </div>
  );
}
