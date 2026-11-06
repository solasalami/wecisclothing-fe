// Size guide data and the size-finder logic. No database imports, so the
// client-side size finder can use it too.
//
// Measurements are body measurements in inches (what most Nigerian tailors use),
// written as ranges like "37-39". The site converts to centimetres on request.

export const SIZE_MEASURES = {
  women: [
    ["bust", "Bust"],
    ["waist", "Waist"],
    ["hips", "Hips"],
  ],
  men: [
    ["chest", "Chest"],
    ["waist", "Waist"],
    ["hips", "Hips / seat"],
  ],
};

export const DEFAULT_SIZE_GUIDE = {
  intro:
    "Our ready-to-wear pieces are cut to Nigerian sizing. Use the size finder or the charts below, and if you are between sizes or want a perfect fit, choose Custom and we will make it to your measurements.",
  women: [
    { size: "S", bust: "33-34", waist: "26-27", hips: "36-37" },
    { size: "M", bust: "35-36", waist: "28-29", hips: "38-39" },
    { size: "L", bust: "37-39", waist: "30-32", hips: "40-42" },
    { size: "XL", bust: "40-42", waist: "33-35", hips: "43-45" },
    { size: "XXL", bust: "43-45", waist: "36-38", hips: "46-48" },
  ],
  men: [
    { size: "S", chest: "35-37", waist: "29-31", hips: "36-38" },
    { size: "M", chest: "38-40", waist: "32-34", hips: "39-41" },
    { size: "L", chest: "41-43", waist: "35-37", hips: "42-44" },
    { size: "XL", chest: "44-46", waist: "38-40", hips: "45-47" },
    { size: "XXL", chest: "47-49", waist: "41-43", hips: "48-50" },
  ],
  fit_note:
    "Agbada and kaftans are cut loose, so take your usual size. Senator and native suits sit closer to the body: if you are between sizes, size up or choose Custom.",
};

/** "37-39" -> [37, 39]; "40" -> [40, 40]; anything else -> null. */
export function parseRange(value) {
  const nums = String(value ?? "")
    .split(/[-to\s]+/i)
    .map((s) => Number(s))
    .filter((n) => Number.isFinite(n) && n > 0);
  if (!nums.length) return null;
  return [Math.min(...nums), Math.max(...nums)];
}

export const toCm = (inches) => Math.round(inches * 2.54);

/** Show a range in inches or cm. */
export function formatRange(value, unit) {
  const r = parseRange(value);
  if (!r) return "";
  const [a, b] = unit === "cm" ? r.map(toCm) : r;
  return a === b ? `${a}` : `${a} to ${b}`;
}

/**
 * Pick a size from body measurements (in inches).
 * Each measurement picks the smallest size it fits; the largest of those wins,
 * because a garment has to fit the fullest part of the body.
 * fit: "fitted" | "regular" | "relaxed". Relaxed goes one size up; when a measurement
 * falls between two sizes, fitted rounds down and regular/relaxed round up.
 * Returns { size, index, custom } where custom = true means "beyond the chart".
 */
export function recommendSize(rows, measurements, fit = "regular") {
  const sizes = (rows || []).filter((r) => r.size);
  if (!sizes.length) return null;
  let pick = -1;
  for (const [key, value] of Object.entries(measurements)) {
    const m = Number(value);
    if (!(m > 0)) continue;
    let idx = sizes.findIndex((r) => {
      const range = parseRange(r[key]);
      return range && m <= range[1];
    });
    if (idx === -1) return { custom: true };
    const range = parseRange(sizes[idx][key]);
    // Between the previous size's top and this size's bottom: fitted shoppers round down.
    if (fit === "fitted" && idx > 0 && m < range[0]) idx -= 1;
    pick = Math.max(pick, idx);
  }
  if (pick === -1) return null;
  if (fit === "relaxed") {
    if (pick + 1 >= sizes.length) return { custom: true };
    pick += 1;
  }
  return { size: sizes[pick].size, index: pick, custom: false };
}
