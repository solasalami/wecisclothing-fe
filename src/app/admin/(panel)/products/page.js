import Link from "next/link";
import { query } from "@/lib/db";
import { formatNaira, formatDate } from "@/lib/format";
import { tableParams, dateRangeSql } from "@/lib/admin-table";
import { SortHeader, Pagination, KeepTableState, TableToolbar, DateRangeFields } from "@/components/admin/TableControls";

const BASE = "/admin/products";
import { PageHeader, Badge } from "@/components/admin/Fields";
import { toggleProduct } from "@/app/admin/actions";

export const metadata = { title: "Products" };

export default async function ProductsAdmin({ searchParams }) {
  const sp = await searchParams;
  const where = ["1=1"];
  const params = [];
  if (sp.q) { where.push("(p.name LIKE ? OR p.sku LIKE ?)"); params.push(`%${sp.q}%`, `%${sp.q}%`); }
  if (sp.kind === "package" || sp.kind === "product") { where.push("p.kind = ?"); params.push(sp.kind); }
  if (sp.status === "hidden") where.push("p.is_active = 0");
  if (sp.status === "live") where.push("p.is_active = 1");
  const dates = dateRangeSql(sp, "p.created_at");
  where.push(...dates.where);
  params.push(...dates.params);
  const table = tableParams(sp, {
    sorts: { price: "p.price", added: "p.created_at", stock: "IF(p.track_stock, p.stock_qty, NULL)" },
    fallback: "p.is_active DESC, p.sort_order, p.id DESC",
    tiebreak: "p.id DESC",
  });
  const sortProps = { basePath: BASE, sp, table };
  const [{ total }] = await query(`SELECT COUNT(*) total FROM products p WHERE ${where.join(" AND ")}`, params);
  const products = await query(
    `SELECT p.id, p.name, p.kind, p.sku, p.price, p.is_active, p.is_featured, p.track_stock, p.stock_qty, p.created_at,
      (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY sort_order, id LIMIT 1) image,
      (SELECT GROUP_CONCAT(c.name SEPARATOR ', ') FROM product_categories pc JOIN categories c ON c.id = pc.category_id WHERE pc.product_id = p.id) cats
     FROM products p WHERE ${where.join(" AND ")} ORDER BY ${table.orderBy} LIMIT ? OFFSET ?`,
    [...params, table.per, table.offset]
  );
  return (
    <div>
      <PageHeader title="Products">
        <Link href="/admin/products/new" className="btn-primary">Add product</Link>
        <Link href="/admin/products/new?kind=package" className="btn-outline">Add package</Link>
      </PageHeader>
      <form className="mb-4 flex flex-wrap items-end gap-2">
        <input name="q" defaultValue={sp.q || ""} placeholder="Search name or SKU" className="input max-w-xs" />
        <select name="kind" defaultValue={sp.kind || ""} className="input max-w-40"><option value="">All types</option><option value="product">Products</option><option value="package">Packages</option></select>
        <select name="status" defaultValue={sp.status || ""} className="input max-w-40"><option value="">Any status</option><option value="live">Visible</option><option value="hidden">Hidden</option></select>
        <DateRangeFields basePath={BASE} sp={sp} label="Added" />
        <KeepTableState table={table} />
        <button className="btn-outline !py-2">Filter</button>
      </form>
      <div className="overflow-x-auto border border-line bg-white">
        <TableToolbar basePath={BASE} sp={sp} table={table} total={Number(total)} />
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted">
            <tr>
              <th className="p-3">Product</th><th>Categories</th>
              <SortHeader label="Price" column="price" {...sortProps} />
              <SortHeader label="Stock" column="stock" {...sortProps} />
              <SortHeader label="Added" column="added" {...sortProps} />
              <th>Status</th><th></th>
            </tr>
          </thead>
          <tbody>
            {products.map((p) => (
              <tr key={p.id} className="border-b border-line">
                <td className="p-3">
                  <Link href={`/admin/products/${p.id}`} className="flex items-center gap-3">
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    {p.image ? <img src={p.image} alt="" className="h-14 w-11 object-cover" /> : <span className="h-14 w-11 bg-soft" />}
                    <span>
                      <span className="font-medium underline">{p.name}</span>
                      <span className="block text-xs text-muted">{p.sku}</span>
                    </span>
                  </Link>
                </td>
                <td className="max-w-48 text-xs text-muted">{p.cats}</td>
                <td>{formatNaira(p.price)}</td>
                <td>{p.track_stock ? p.stock_qty : <span className="text-muted">-</span>}</td>
                <td className="whitespace-nowrap">{formatDate(p.created_at, { dateOnly: true })}</td>
                <td className="space-x-1">
                  {p.is_active ? <Badge tone="green">Visible</Badge> : <Badge>Hidden</Badge>}
                  {p.kind === "package" && <Badge tone="gold">Package</Badge>}
                  {p.is_featured ? <Badge tone="blue">Featured</Badge> : null}
                </td>
                <td className="pr-3 text-right">
                  <form action={toggleProduct}>
                    <input type="hidden" name="id" value={p.id} />
                    <button className="text-xs underline">{p.is_active ? "Hide" : "Show"}</button>
                  </form>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!products.length && <p className="p-6 text-center text-muted">No products match.</p>}
        <Pagination basePath={BASE} sp={sp} table={table} total={Number(total)} />
      </div>
    </div>
  );
}
