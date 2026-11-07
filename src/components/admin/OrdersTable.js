import Link from "next/link";
import { formatNaira, formatDate } from "@/lib/format";
import { Badge, paymentTone, statusTone } from "./Fields";
import { SortHeader } from "./TableControls";

/**
 * Orders list. Pass `sortable={{ basePath, sp, table }}` to make Date and Total
 * sortable (the Orders page); the dashboard preview leaves it out.
 */
export default function OrdersTable({ orders, sortable, empty = "No orders yet." }) {
  if (!orders.length) return <p className="p-4 text-sm text-muted">{empty}</p>;
  return (
    <div className="overflow-x-auto">
      <table className="w-full text-left text-sm">
        <thead className="border-b border-line text-xs uppercase text-muted">
          <tr>
            <th className="py-2">Order</th><th>Customer</th><Sort label="Date" column="date" sortable={sortable} /><th>Payment</th><th>Status</th>
            <Sort label="Total" column="total" align="right" sortable={sortable} />
          </tr>
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

function Sort({ label, column, align, sortable }) {
  if (!sortable) return <th className={align === "right" ? "text-right" : ""}>{label}</th>;
  return <SortHeader label={label} column={column} align={align} {...sortable} />;
}
