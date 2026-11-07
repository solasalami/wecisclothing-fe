import { query } from "@/lib/db";
import { formatDate, formatNaira } from "@/lib/format";
import { PageHeader } from "@/components/admin/Fields";
import { tableParams, dateRangeSql } from "@/lib/admin-table";
import { SortHeader, Pagination, KeepTableState, TableToolbar, DateRangeFields } from "@/components/admin/TableControls";

export const metadata = { title: "Customers" };

const BASE = "/admin/customers";
const day = (v) => formatDate(v, { dateOnly: true });

// Everyone who has registered or ordered, one row per email. Orders count whether
// they were placed as a guest or signed in.
const CUSTOMERS_SQL = `
  SELECT e.email,
    COALESCE(CONCAT(c.first_name,' ',c.last_name), o.name) name,
    COALESCE(c.phone, o.phone) phone,
    c.created_at registered_at, c.email_verified_at,
    o.first_order, o.last_order, COALESCE(o.orders, 0) orders, COALESCE(o.spent, 0) spent,
    LEAST(COALESCE(c.created_at, o.first_order), COALESCE(o.first_order, c.created_at)) since,
    GREATEST(COALESCE(o.last_order, c.created_at), COALESCE(c.created_at, o.last_order)) last_activity
  FROM (SELECT email FROM orders UNION SELECT email FROM customers) e
  LEFT JOIN customers c ON c.email = e.email
  LEFT JOIN (
    SELECT email, MAX(CONCAT(first_name,' ',last_name)) name, MAX(phone) phone, COUNT(*) orders,
      SUM(CASE WHEN payment_status='paid' THEN total ELSE 0 END) spent,
      MIN(created_at) first_order, MAX(created_at) last_order
    FROM orders GROUP BY email
  ) o ON o.email = e.email`;

export default async function CustomersAdmin({ searchParams }) {
  const sp = await searchParams;
  const q = sp.q || "";
  const like = q ? `%${q}%` : null;
  const table = tableParams(sp, {
    sorts: { since: "since", registered: "registered_at", first_order: "first_order", last_order: "last_order", orders: "orders", spent: "spent" },
    fallback: "last_activity DESC, email",
    tiebreak: "email",
  });
  const sortProps = { basePath: BASE, sp, table };
  const conds = [];
  const params = [];
  if (like) {
    conds.push("(t.email LIKE ? OR t.phone LIKE ? OR t.name LIKE ?)");
    params.push(like, like, like);
  }
  const dates = dateRangeSql(sp, "t.since");
  conds.push(...dates.where);
  params.push(...dates.params);
  const filter = conds.length ? `WHERE ${conds.join(" AND ")}` : "";
  const [rows, [{ total }]] = await Promise.all([
    query(`SELECT * FROM (${CUSTOMERS_SQL}) t ${filter} ORDER BY ${table.orderBy} LIMIT ? OFFSET ?`, [...params, table.per, table.offset]),
    query(`SELECT COUNT(*) total FROM (${CUSTOMERS_SQL}) t ${filter}`, params),
  ]);
  return (
    <div>
      <PageHeader title="Customers" />
      <form className="mb-4 flex flex-wrap items-end gap-2">
        <input name="q" defaultValue={q} placeholder="Name, email or phone" className="input max-w-xs" />
        <DateRangeFields basePath={BASE} sp={sp} label="Customer since" />
        <KeepTableState table={table} />
        <button className="btn-outline !py-2">Search</button>
      </form>
      <div className="overflow-x-auto border border-line bg-white">
        <TableToolbar basePath={BASE} sp={sp} table={table} total={Number(total)} />
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted">
            <tr>
              <th className="p-3">Name</th><th>Email</th><th>Phone</th>
              <SortHeader label="Customer since" column="since" {...sortProps} />
              <SortHeader label="Registered" column="registered" {...sortProps} />
              <SortHeader label="First order" column="first_order" {...sortProps} />
              <SortHeader label="Orders" column="orders" {...sortProps} />
              <SortHeader label="Paid total" column="spent" {...sortProps} />
              <SortHeader label="Last order" column="last_order" {...sortProps} />
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
        {!rows.length && <p className="p-6 text-center text-muted">{q || sp.from || sp.to ? "No customers match." : "No customers yet."}</p>}
        <Pagination basePath={BASE} sp={sp} table={table} total={Number(total)} />
      </div>
    </div>
  );
}
