import { notFound } from "next/navigation";
import Link from "next/link";
import { getOrderById, ORDER_STATUSES, DELIVERY_METHODS } from "@/lib/orders";
import { formatNaira, formatDate, whatsappLink, telLink } from "@/lib/format";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { Card, Badge, paymentTone, statusTone, Field } from "@/components/admin/Fields";
import { updateOrder, markPaidManually, resendOrderEmail } from "@/app/admin/actions";
import { emailEnabled, emailMissingVars } from "@/lib/email";
import { Check } from "@/components/admin/Fields";
import { parseJson } from "@/lib/db";

export const metadata = { title: "Order" };

export default async function OrderAdmin({ params, searchParams }) {
  const { id } = await params;
  const { saved } = await searchParams;
  const o = await getOrderById(Number(id));
  if (!o) notFound();
  const utm = parseJson(o.utm, null);
  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <Link href="/admin/orders" className="text-sm underline">← Orders</Link>
          <h1 className="mt-1 text-3xl">Order {o.order_number}</h1>
          <p className="text-sm text-muted">{formatDate(o.created_at)}</p>
        </div>
        <div className="flex gap-2">
          <Badge tone={paymentTone(o.payment_status)}>{o.payment_status}</Badge>
          <Badge tone={statusTone(o.status)}>{o.status}</Badge>
        </div>
      </div>
      {saved && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}

      <div className="grid gap-6 lg:grid-cols-[1fr_340px]">
        <div className="space-y-6">
          <Card title="Items">
            <table className="w-full text-sm">
              <tbody>
                {o.items.map((i) => (
                  <tr key={i.id} className="border-b border-line">
                    <td className="py-2">
                      {i.product_id ? <Link href={`/admin/products/${i.product_id}`} className="underline">{i.name}</Link> : i.name}
                      {i.size && <span className="text-muted"> · Size {i.size}</span>}
                    </td>
                    <td className="text-right">{i.quantity} × {formatNaira(i.unit_price)}</td>
                    <td className="w-32 text-right">{formatNaira(i.line_total)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            <dl className="ml-auto max-w-xs space-y-1 text-sm">
              <div className="flex justify-between"><dt>Subtotal</dt><dd>{formatNaira(o.subtotal)}</dd></div>
              <div className="flex justify-between"><dt>Delivery</dt><dd>{formatNaira(o.shipping_fee)}</dd></div>
              <div className="flex justify-between font-medium"><dt>Total</dt><dd>{formatNaira(o.total)}</dd></div>
            </dl>
          </Card>
          <Card title="Payments">
            <p className="text-sm">Method: <strong className="capitalize">{o.payment_method.replace("_", " ")}</strong>{o.paid_at && <> · Paid {formatDate(o.paid_at)}</>}</p>
            {o.payments.length > 0 && (
              <table className="w-full text-left text-xs">
                <thead className="text-muted"><tr><th>Reference</th><th>Provider</th><th>Status</th><th>Amount</th><th>Updated</th></tr></thead>
                <tbody>{o.payments.map((p) => <tr key={p.id}><td className="py-1 font-mono">{p.reference}</td><td>{p.provider}</td><td>{p.status}</td><td>{formatNaira(p.amount)}</td><td>{formatDate(p.updated_at)}</td></tr>)}</tbody>
              </table>
            )}
            {o.payment_status !== "paid" && (
              <form action={markPaidManually} className="flex flex-wrap items-end gap-2 border-t border-line pt-4">
                <input type="hidden" name="id" value={o.id} />
                <Field label="Bank transfer reference (optional)" name="reference" className="flex-1" />
                <ConfirmButton message="Mark this order as PAID? Only do this after confirming the money is in the account." className="btn-primary !py-2.5">Mark as paid</ConfirmButton>
              </form>
            )}
          </Card>
          {utm && (
            <Card title="Marketing attribution">
              <dl className="grid grid-cols-2 gap-1 text-xs">{Object.entries(utm).map(([k, v]) => <div key={k} className="contents"><dt className="text-muted">{k}</dt><dd className="break-all">{String(v)}</dd></div>)}</dl>
            </Card>
          )}
        </div>

        <div className="space-y-6">
          <Card title="Fulfilment">
            <ActionForm action={updateOrder} className="space-y-3">
              <input type="hidden" name="id" value={o.id} />
              <select name="status" defaultValue={o.status} className="input capitalize">
                {ORDER_STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
              </select>
              <SubmitButton className="btn-primary w-full">Update status</SubmitButton>
            </ActionForm>
          </Card>
          <Card title="Emails">
            {o.payment_status === "paid" ? (
              <p className="text-sm text-muted">The order confirmation is sent automatically when an order is paid.</p>
            ) : (
              <p className="text-sm text-muted">The confirmation is sent automatically once this order is paid.</p>
            )}
            <a href={`/admin/orders/${o.id}/email`} target="_blank" className="block text-sm underline">Preview confirmation email</a>
            {o.payment_status === "paid" &&
              (emailEnabled() ? (
                <ActionForm action={resendOrderEmail} className="space-y-2">
                  <input type="hidden" name="id" value={o.id} />
                  <Check label="Also notify the store (ADMIN_EMAIL)" name="include_admin" />
                  <SubmitButton className="btn-outline w-full !py-2.5">Resend confirmation email</SubmitButton>
                </ActionForm>
              ) : (
                <p className="text-xs text-red-700">Email is off. Missing: {emailMissingVars().join(", ")}.</p>
              ))}
          </Card>
          <Card title="Customer">
            <p className="text-sm font-medium">{o.first_name} {o.last_name}</p>
            <p className="text-sm"><a href={`mailto:${o.email}`} className="underline">{o.email}</a></p>
            <div className="flex gap-3 text-sm">
              <a href={telLink(o.phone)} className="underline">{o.phone}</a>
              <a href={whatsappLink(o.phone, `Hello ${o.first_name}, this is Wecis Clothing about your order ${o.order_number}.`)} target="_blank" rel="noopener noreferrer" className="text-green-700 underline">WhatsApp</a>
            </div>
          </Card>
          <Card title="Delivery">
            <p className="text-sm">{DELIVERY_METHODS[o.delivery_method] || o.delivery_method}</p>
            {o.address_line && <p className="text-sm">{o.address_line}<br />{o.city}, {o.state}</p>}
            {o.notes && <p className="whitespace-pre-wrap border-t border-line pt-3 text-sm"><span className="label">Customer notes</span>{o.notes}</p>}
          </Card>
        </div>
      </div>
    </div>
  );
}
