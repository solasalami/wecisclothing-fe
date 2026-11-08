import Link from "next/link";
import { query } from "@/lib/db";
import { formatNaira } from "@/lib/format";
import OrdersTable from "@/components/admin/OrdersTable";

export const metadata = { title: "Dashboard" };

export default async function Dashboard() {
  const [[today], [month], [pending], recent, [drafts], [unread]] = await Promise.all([
    query("SELECT COUNT(*) n, COALESCE(SUM(total),0) v FROM orders WHERE payment_status='paid' AND paid_at >= DATE(UTC_TIMESTAMP() + INTERVAL 1 HOUR) - INTERVAL 1 HOUR"),
    query("SELECT COUNT(*) n, COALESCE(SUM(total),0) v FROM orders WHERE payment_status='paid' AND paid_at >= CAST(DATE_FORMAT(UTC_TIMESTAMP() + INTERVAL 1 HOUR, '%Y-%m-01') AS DATETIME) - INTERVAL 1 HOUR"),
    query("SELECT COUNT(*) n FROM orders WHERE status IN ('pending','processing','ready') AND (payment_status='paid' OR payment_method='bank_transfer')"),
    query("SELECT id, order_number, first_name, last_name, total, status, payment_status, payment_method, created_at FROM orders ORDER BY id DESC LIMIT 10"),
    query("SELECT COUNT(*) n FROM products WHERE is_active = 0"),
    query("SELECT COUNT(*) n FROM contact_messages WHERE read_at IS NULL").catch(() => [{ n: 0 }]),
  ]);
  return (
    <div className="space-y-8">
      <h1 className="text-3xl">Dashboard</h1>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
        <Stat label="Paid today" value={formatNaira(today.v)} sub={`${today.n} orders`} />
        <Stat label="Paid this month" value={formatNaira(month.v)} sub={`${month.n} orders`} />
        <Stat label="Orders to fulfil" value={pending.n} href="/admin/orders?status=open" />
        <Stat label="Hidden products" value={drafts.n} href="/admin/products?status=hidden" />
        <Stat label="Unread messages" value={unread.n} href="/admin/messages?status=unread" />
      </div>


      <section className="border border-line bg-white p-5">
        <div className="mb-3 flex items-center justify-between">
          <h2 className="font-sans text-sm font-bold uppercase tracking-wider">Recent orders</h2>
          <Link href="/admin/orders" className="text-sm underline">All orders</Link>
        </div>
        <OrdersTable orders={recent} />
      </section>
    </div>
  );
}

function Stat({ label, value, sub, href }) {
  const body = (
    <div className="border border-line bg-white p-5">
      <p className="text-xs uppercase tracking-wider text-muted">{label}</p>
      <p className="mt-2 text-2xl font-medium">{value}</p>
      {sub && <p className="text-xs text-muted">{sub}</p>}
    </div>
  );
  return href ? <Link href={href}>{body}</Link> : body;
}
