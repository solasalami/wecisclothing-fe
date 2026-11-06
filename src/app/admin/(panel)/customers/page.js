import { query } from "@/lib/db";
import { formatDate, formatNaira } from "@/lib/format";
import { PageHeader } from "@/components/admin/Fields";

export const metadata = { title: "Customers" };

const day = (v) => formatDate(v, { dateOnly: true });

export default async function CustomersAdmin({ searchParams }) {
  const { q } = await searchParams;
  const like = q ? `%${q}%` : null;
  // Everyone who has registered or ordered, one row per email. Orders count whether
  // they were placed as a guest or signed in.
  const rows = await query(
    `SELECT e.email,
        COALESCE(CONCAT(c.first_name,' ',c.last_name), o.name) name,
        COALESCE(c.phone, o.phone) phone,
        c.created_at registered_at, c.email_verified_at,
        o.first_order, o.last_order, COALESCE(o.orders, 0) orders, COALESCE(o.spent, 0) spent,
        LEAST(COALESCE(c.created_at, o.first_order), COALESCE(o.first_order, c.created_at)) since
     FROM (SELECT email FROM orders UNION SELECT email FROM customers) e
     LEFT JOIN customers c ON c.email = e.email
     LEFT JOIN (
       SELECT email, MAX(CONCAT(first_name,' ',last_name)) name, MAX(phone) phone, COUNT(*) orders,
         SUM(CASE WHEN payment_status='paid' THEN total ELSE 0 END) spent,
         MIN(created_at) first_order, MAX(created_at) last_order
       FROM orders GROUP BY email
     ) o ON o.email = e.email
     ${like ? "HAVING email LIKE ? OR phone LIKE ? OR name LIKE ?" : ""}
     ORDER BY GREATEST(COALESCE(o.last_order, c.created_at), COALESCE(c.created_at, o.last_order)) DESC
     LIMIT 500`,
    like ? [like, like, like] : []
  );
  return (
    <div>
      <PageHeader title="Customers" />
      <form className="mb-4 flex gap-2"><input name="q" defaultValue={q || ""} placeholder="Name, email or phone" className="input max-w-xs" /><button className="btn-outline !py-2">Search</button></form>
      <div className="overflow-x-auto border border-line bg-white">
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted">
            <tr>
              <th className="p-3">Name</th><th>Email</th><th>Phone</th><th>Customer since</th><th>Registered</th><th>First order</th>
              <th>Orders</th><th>Paid total</th><th>Last order</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r) => (
              <tr key={r.email} className="border-b border-line align-top">
                <td className="p-3">{r.name}</td>
                <td><a href={`/admin/orders?q=${encodeURIComponent(r.email)}`} className="underline">{r.email}</a></td>
                <td>{r.phone}</td>
                <td className="font-medium">{day(r.since)}</td>
                <td>
                  {r.registered_at ? (
                    <>
                      {day(r.registered_at)}
                      <span className="block text-xs text-muted">{r.email_verified_at ? "Email confirmed" : "Email not confirmed"}</span>
                    </>
                  ) : (
                    <span className="text-muted">Guest</span>
                  )}
                </td>
                <td>{r.first_order ? day(r.first_order) : <span className="text-muted">None yet</span>}</td>
                <td>{r.orders}</td>
                <td>{formatNaira(r.spent)}</td>
                <td>{r.last_order ? formatDate(r.last_order) : ""}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {!rows.length && <p className="p-6 text-center text-muted">No customers yet.</p>}
      </div>
    </div>
  );
}
