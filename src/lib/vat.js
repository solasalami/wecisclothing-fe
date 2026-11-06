// VAT helpers shared by checkout, order pages, emails and admin. No database imports,
// so client components can use them too.
//
// Each product is either VAT inclusive (the shelf price already contains VAT) or
// VAT exclusive (VAT is added on top at checkout). VAT is rounded to the nearest
// naira per line so the amounts shown always match the amount charged.

export const DEFAULT_TAX = { vat_enabled: true, vat_rate: 7.5, vat_label: "VAT" };

export function vatRate(tax) {
  const rate = Number(tax?.vat_rate);
  return tax?.vat_enabled && rate > 0 ? rate : 0;
}

/** VAT contained in, or to be added to, one line. */
export function lineVat(lineTotal, inclusive, rate) {
  if (!rate) return 0;
  const amount = Number(lineTotal) || 0;
  return Math.round(inclusive ? (amount * rate) / (100 + rate) : (amount * rate) / 100);
}

/**
 * Adds `vat_amount` and `vat_inclusive` to each item and returns the VAT totals.
 * `vat_added` is charged on top of the subtotal; `vat_included` is already inside it.
 */
export function applyVat(items, tax) {
  const rate = vatRate(tax);
  let added = 0;
  let included = 0;
  const out = items.map((it) => {
    const inclusive = !!it.vat_inclusive;
    const vat = lineVat(it.line_total, inclusive, rate);
    if (inclusive) included += vat;
    else added += vat;
    return { ...it, vat_inclusive: inclusive ? 1 : 0, vat_amount: vat };
  });
  return { items: out, rate, vat_added: added, vat_included: included, vat_amount: added + included };
}

function pct(rate) {
  return `${Number(rate).toLocaleString("en-NG", { maximumFractionDigits: 2 })}%`;
}

/**
 * Rows to show under the subtotal, for an order row or a checkout quote:
 * `{ vat_rate, vat_added, vat_included, vat_label? }`.
 * "added" rows count towards the total; "included" rows are for information.
 */
export function vatRows(o) {
  const rate = Number(o?.vat_rate) || 0;
  const label = o?.vat_label || "VAT";
  const rows = [];
  if (Number(o?.vat_added) > 0) rows.push({ kind: "added", label: `${label} (${pct(rate)})`, amount: Number(o.vat_added) });
  if (Number(o?.vat_included) > 0) rows.push({ kind: "included", label: `Includes ${label} (${pct(rate)})`, amount: Number(o.vat_included) });
  return rows;
}

/** Short note for a product price, e.g. "Price includes VAT" / "+ 7.5% VAT at checkout". */
export function priceVatNote(inclusive, tax) {
  const rate = vatRate(tax);
  if (!rate) return "";
  const label = tax?.vat_label || "VAT";
  return inclusive ? `Price includes ${pct(rate)} ${label}` : `+ ${pct(rate)} ${label} added at checkout`;
}
