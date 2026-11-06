import { formatNaira } from "@/lib/format";
import { vatRows } from "@/lib/vat";

/**
 * Subtotal, VAT, delivery and total rows. Works with a checkout quote or a saved order:
 * pass `{ subtotal, vat_rate, vat_added, vat_included, vat_label?, fee | shipping_fee, total }`.
 */
export default function OrderTotals({ o, deliveryLabel = "Delivery", loading = false, className = "", totalClassName = "text-lg font-medium" }) {
  const fee = o ? Number(o.fee ?? o.shipping_fee ?? 0) : 0;
  const rows = vatRows(o);
  return (
    <dl className={`space-y-2 text-sm ${className}`}>
      <div className="flex justify-between"><dt>Subtotal</dt><dd>{formatNaira(o?.subtotal ?? 0)}</dd></div>
      {rows.filter((r) => r.kind === "added").map((r) => (
        <div key={r.kind} className="flex justify-between"><dt>{r.label}</dt><dd>{formatNaira(r.amount)}</dd></div>
      ))}
      <div className="flex justify-between"><dt>{deliveryLabel}</dt><dd>{loading || !o ? "…" : fee ? formatNaira(fee) : "Free"}</dd></div>
      <div className={`flex justify-between border-t border-line pt-2 ${totalClassName}`}><dt>Total</dt><dd>{formatNaira(o?.total ?? 0)}</dd></div>
      {rows.filter((r) => r.kind === "included").map((r) => (
        <div key={r.kind} className="flex justify-between text-xs text-muted"><dt>{r.label}</dt><dd>{formatNaira(r.amount)}</dd></div>
      ))}
    </dl>
  );
}
