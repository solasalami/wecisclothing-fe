"use client";
import { useState } from "react";
import { SIZE_MEASURES, formatRange, recommendSize } from "@/lib/size-guide";
import { whatsappLink } from "@/lib/format";
import { WhatsAppIcon } from "./icons";

const FITS = [
  ["fitted", "Fitted", "Close to the body"],
  ["regular", "True to size", "How we cut it"],
  ["relaxed", "Relaxed", "Roomier, one size up"],
];

const HINTS = {
  bust: "Fullest part of the bust",
  chest: "Fullest part of the chest, under the arms",
  waist: "Narrowest part, around the navel",
  hips: "Fullest part of the hips and seat",
};

/** Interactive size finder plus the size charts. Shares one inches/cm switch. */
export default function SizeGuide({ guide, whatsapp, initialGender = "women" }) {
  const [gender, setGender] = useState(initialGender === "men" ? "men" : "women");
  const [unit, setUnit] = useState("in");
  const [values, setValues] = useState({});
  const [fit, setFit] = useState("regular");

  const measures = SIZE_MEASURES[gender];
  const rows = (guide[gender] || []).filter((r) => r.size);
  const toInches = (v) => (unit === "cm" ? Number(v) / 2.54 : Number(v));
  const entered = Object.fromEntries(
    measures.map(([key]) => [key, values[`${gender}.${key}`]]).filter(([, v]) => Number(v) > 0).map(([k, v]) => [k, toInches(v)])
  );
  const result = Object.keys(entered).length ? recommendSize(rows, entered, fit) : null;

  const unitLabel = unit === "cm" ? "cm" : "inches";
  const measurementText = measures
    .filter(([key]) => values[`${gender}.${key}`])
    .map(([key, label]) => `${label}: ${values[`${gender}.${key}`]} ${unitLabel}`)
    .join(", ");
  const waMessage = result?.custom
    ? `Hello Wecis Clothing, I'd like a custom fit. My measurements: ${measurementText}.`
    : `Hello Wecis Clothing, the size finder suggested ${result?.size} (${gender === "men" ? "men" : "women"}, ${FITS.find((f) => f[0] === fit)[1].toLowerCase()} fit). My measurements: ${measurementText}. Can you confirm?`;

  return (
    <div className="space-y-12">
      <section className="border border-line bg-soft p-6 md:p-8">
        <h2 className="text-2xl">Find your size</h2>
        <p className="mt-1 text-sm text-muted">Enter your body measurements, not the measurements of a garment.</p>

        <div className="mt-6 flex flex-wrap gap-6">
          <Toggle label="Shopping for" value={gender} onChange={setGender} options={[["women", "Women"], ["men", "Men"]]} />
          <Toggle label="Units" value={unit} onChange={setUnit} options={[["in", "Inches"], ["cm", "Centimetres"]]} />
        </div>

        <div className="mt-6 grid gap-4 sm:grid-cols-3">
          {measures.map(([key, label]) => (
            <div key={`${gender}.${key}`}>
              <label className="label" htmlFor={`m-${key}`}>{label} ({unit})</label>
              <input
                id={`m-${key}`}
                type="number"
                inputMode="decimal"
                min="0"
                step="0.5"
                className="input"
                value={values[`${gender}.${key}`] ?? ""}
                onChange={(e) => setValues((v) => ({ ...v, [`${gender}.${key}`]: e.target.value }))}
              />
              <p className="mt-1 text-xs text-muted">{HINTS[key]}</p>
            </div>
          ))}
        </div>

        <fieldset className="mt-6">
          <legend className="label">How do you like it to fit?</legend>
          <div className="grid gap-2 sm:grid-cols-3">
            {FITS.map(([id, label, hint]) => (
              <label key={id} className={`flex cursor-pointer items-start gap-3 border p-3 ${fit === id ? "border-gold bg-gold-light/40" : "border-line bg-white"}`}>
                <input type="radio" name="fit" value={id} checked={fit === id} onChange={() => setFit(id)} className="mt-1" />
                <span>
                  <span className="block text-sm font-medium">{label}</span>
                  <span className="block text-xs text-muted">{hint}</span>
                </span>
              </label>
            ))}
          </div>
        </fieldset>

        <div className="mt-6 border-t border-line pt-6" aria-live="polite">
          {!result && <p className="text-sm text-muted">Your recommended size will appear here.</p>}
          {result && !result.custom && (
            <div className="flex flex-wrap items-center gap-4">
              <p>
                <span className="block text-xs uppercase tracking-widest text-muted">Your Wecis size</span>
                <span className="font-display text-5xl">{result.size}</span>
              </p>
              <a href={whatsappLink(whatsapp, waMessage)} target="_blank" rel="noopener noreferrer" data-track-location="size_guide" className="btn-whatsapp">
                <WhatsAppIcon /> Confirm on WhatsApp
              </a>
            </div>
          )}
          {result?.custom && (
            <div className="space-y-3">
              <p>
                <span className="block text-xs uppercase tracking-widest text-muted">Your Wecis size</span>
                <span className="font-display text-4xl">Custom</span>
              </p>
              <p className="text-sm">Your measurements are outside our standard sizes. Choose <strong>Custom</strong> when ordering and we will make it to your measurements.</p>
              <a href={whatsappLink(whatsapp, waMessage)} target="_blank" rel="noopener noreferrer" data-track-location="size_guide" className="btn-whatsapp">
                <WhatsAppIcon /> Send measurements on WhatsApp
              </a>
            </div>
          )}
        </div>
      </section>

      {["women", "men"].map((g) => (
        <section key={g}>
          <h2 className="text-2xl">{g === "women" ? "Women" : "Men"}: body measurements ({unitLabel})</h2>
          <div className="mt-4 overflow-x-auto">
            <table className="w-full min-w-[420px] border-collapse text-sm">
              <thead>
                <tr className="bg-ink text-left text-white">
                  <th className="px-4 py-3 font-medium">Size</th>
                  {SIZE_MEASURES[g].map(([key, label]) => <th key={key} className="px-4 py-3 font-medium">{label}</th>)}
                </tr>
              </thead>
              <tbody>
                {(guide[g] || []).filter((r) => r.size).map((r) => (
                  <tr key={r.size} className={`border-b border-line ${gender === g && result?.size === r.size ? "bg-gold-light/60" : ""}`}>
                    <td className="px-4 py-3 font-medium">{r.size}</td>
                    {SIZE_MEASURES[g].map(([key]) => <td key={key} className="px-4 py-3">{formatRange(r[key], unit)}</td>)}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
      ))}
    </div>
  );
}

function Toggle({ label, value, onChange, options }) {
  return (
    <div>
      <p className="label">{label}</p>
      <div className="inline-flex border border-line bg-white">
        {options.map(([id, text]) => (
          <button
            key={id}
            type="button"
            aria-pressed={value === id}
            onClick={() => onChange(id)}
            className={`px-4 py-2 text-sm transition ${value === id ? "bg-gold text-ink" : "hover:bg-soft"}`}
          >
            {text}
          </button>
        ))}
      </div>
    </div>
  );
}
