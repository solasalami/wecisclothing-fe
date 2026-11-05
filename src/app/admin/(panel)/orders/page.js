import { query } from "@/lib/db";
import { PageHeader } from "@/components/admin/Fields";
import OrdersTable from "@/components/admin/OrdersTable";
import { ORDER_STATUSES, PAYMENT_STATUSES } from "@/lib/orders";

export const metadata = { title: "Orders" };

export default async function OrdersAdmin({ searchParams }) {
  const sp = await searchParams;
  const where = ["1=1"];
  const params = [];
  if (sp.q) { where.push("(order_number LIKE ? OR email LIKE ? OR phone LIKE ? OR CONCAT(first_name,' ',last_name) LIKE ?)"); params.push(...Array(4).fill(`%${sp.q}%`)); }
  if (sp.status === "open") where.push("status IN ('pending','processing','ready')");
  else if (ORDER_STATUSES.includes(sp.status)) { where.push("status = ?"); params.push(sp.status); }
  if (PAYMENT_STATUSES.includes(sp.payment)) { where.push("payment_status = ?"); params.push(sp.payment); }
  const orders = await query(
    `SELECT id, order_number, first_name, last_name, total, status, payment_status, payment_method, created_at FROM orders WHERE ${where.join(" AND ")} ORDER BY id DESC LIMIT 300`,
    params
  );
  return (
    <div>
      <PageHeader title="Orders" />
      <form className="mb-4 flex flex-wrap gap-2">
        <input name="q" defaultValue={sp.q || ""} placeholder="Order no, name, email, phone" className="input max-w-xs" />
        <select name="status" defaultValue={sp.status || ""} className="input max-w-40">
          <option value="">Any status</option><option value="open">Open (to fulfil)</option>
          {ORDER_STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
        </select>
        <select name="payment" defaultValue={sp.payment || ""} className="input max-w-40">
          <option value="">Any payment</option>
          {PAYMENT_STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
        </select>
        <button className="btn-outline !py-2">Filter</button>
      </form>
      <div className="border border-line bg-white p-4"><OrdersTable orders={orders} /></div>
    </div>
  );
}
