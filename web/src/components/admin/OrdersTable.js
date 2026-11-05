import Link from "next/link";
import { formatNaira, formatDate } from "@/lib/format";
import { Badge, paymentTone, statusTone } from "./Fields";

export default function OrdersTable({ orders }) {
  if (!orders.length) return <p className="text-sm text-muted">No orders yet.</p>;
  return (
    <div className="overflow-x-auto">
      <table className="w-full text-left text-sm">
        <thead className="border-b border-line text-xs uppercase text-muted">
          <tr><th className="py-2">Order</th><th>Customer</th><th>Date</th><th>Payment</th><th>Status</th><th className="text-right">Total</th></tr>
        </thead>
        <tbody>
          {orders.map((o) => (
            <tr key={o.id} className="border-b border-line">
              <td className="py-2"><Link href={`/admin/orders/${o.id}`} className="font-medium underline">{o.order_number}</Link></td>
              <td>{o.first_name} {o.last_name}</td>
              <td className="whitespace-nowrap">{formatDate(o.created_at)}</td>
              <td><Badge tone={paymentTone(o.payment_status)}>{o.payment_status}</Badge> <span className="text-xs text-muted">{o.payment_method.replace("_", " ")}</span></td>
              <td><Badge tone={statusTone(o.status)}>{o.status}</Badge></td>
              <td className="text-right">{formatNaira(o.total)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
