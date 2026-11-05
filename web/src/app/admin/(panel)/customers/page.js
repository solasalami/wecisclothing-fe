import { query } from "@/lib/db";
import { formatDate, formatNaira } from "@/lib/format";
import { PageHeader } from "@/components/admin/Fields";

export const metadata = { title: "Customers" };

export default async function CustomersAdmin({ searchParams }) {
  const { q } = await searchParams;
  const params = q ? Array(3).fill(`%${q}%`) : [];
  // Everyone who has ordered (guest or registered), grouped by email.
  const rows = await query(
    `SELECT o.email, MAX(CONCAT(o.first_name,' ',o.last_name)) name, MAX(o.phone) phone, COUNT(*) orders,
        SUM(CASE WHEN o.payment_status='paid' THEN o.total ELSE 0 END) spent, MAX(o.created_at) last_order,
        MAX(c.id IS NOT NULL) registered
     FROM orders o LEFT JOIN customers c ON c.email = o.email
     ${q ? "WHERE o.email LIKE ? OR o.phone LIKE ? OR CONCAT(o.first_name,' ',o.last_name) LIKE ?" : ""}
     GROUP BY o.email ORDER BY last_order DESC LIMIT 500`,
    params
  );
  return (
    <div>
      <PageHeader title="Customers" />
      <form className="mb-4 flex gap-2"><input name="q" defaultValue={q || ""} placeholder="Name, email or phone" className="input max-w-xs" /><button className="btn-outline !py-2">Search</button></form>
      <div className="overflow-x-auto border border-line bg-white">
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted"><tr><th className="p-3">Name</th><th>Email</th><th>Phone</th><th>Orders</th><th>Paid total</th><th>Last order</th></tr></thead>
          <tbody>
            {rows.map((r) => (
              <tr key={r.email} className="border-b border-line">
                <td className="p-3">{r.name}{r.registered ? <span className="ml-1 text-xs text-muted">(account)</span> : null}</td>
                <td><a href={`/admin/orders?q=${encodeURIComponent(r.email)}`} className="underline">{r.email}</a></td>
                <td>{r.phone}</td><td>{r.orders}</td><td>{formatNaira(r.spent)}</td><td>{formatDate(r.last_order)}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {!rows.length && <p className="p-6 text-center text-muted">No customers yet.</p>}
      </div>
    </div>
  );
}
