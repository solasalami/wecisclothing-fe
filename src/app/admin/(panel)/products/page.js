import Link from "next/link";
import { query } from "@/lib/db";
import { formatNaira, formatDate } from "@/lib/format";
import { tableParams, dateRangeSql } from "@/lib/admin-table";
import { SortHeader, Pagination, KeepTableState, TableToolbar, DateRangeFields } from "@/components/admin/TableControls";

const BASE = "/admin/products";
import { PageHeader, Badge } from "@/components/admin/Fields";
import { toggleProduct } from "@/app/admin/actions";
import { editProductHref } from "@/lib/admin-back";
import { getAllCategoriesTree, flattenCategories } from "@/lib/admin-data";
import BulkCategoryBar from "@/components/admin/BulkCategoryBar";
import PackageMultiSelect from "@/components/admin/PackageMultiSelect";

export const metadata = { title: "Products" };

export default async function ProductsAdmin({ searchParams }) {
  const sp = await searchParams;
  const where = ["1=1"];
  const params = [];
  if (sp.q) { where.push("(p.name LIKE ? OR p.sku LIKE ?)"); params.push(`%${sp.q}%`, `%${sp.q}%`); }
  if (sp.kind === "package" || sp.kind === "product") { where.push("p.kind = ?"); params.push(sp.kind); }
  if (sp.status === "hidden") where.push("p.is_active = 0");
  if (sp.status === "live") where.push("p.is_active = 1");
  // Category filter: a category's own products, or products in no category at all.
  if (sp.cat === "none") where.push("NOT EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id)");
  else if (Number(sp.cat) > 0) { where.push("EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id AND pc.category_id = ?)"); params.push(Number(sp.cat)); }
  const categories = flattenCategories(await getAllCategoriesTree());
  const dates = dateRangeSql(sp, "p.created_at");
  where.push(...dates.where);
  params.push(...dates.params);
  const table = tableParams(sp, {
    sorts: { price: "p.price", added: "p.created_at", stock: "IF(p.track_stock, p.stock_qty, NULL)" },
    fallback: "p.is_active DESC, p.sort_order, p.id DESC",
    tiebreak: "p.id DESC",
  });
  const sortProps = { basePath: BASE, sp, table };
  // The list as it is now (search, filters, sort, page), for the editor's back link.
  const listQs = new URLSearchParams(Object.entries(sp).filter(([k, v]) => typeof v === "string" && v && k !== "bulk")).toString();
  const listUrl = listQs ? `${BASE}?${listQs}` : BASE;
  const [{ total }] = await query(`SELECT COUNT(*) total FROM products p WHERE ${where.join(" AND ")}`, params);
  const products = await query(
    `SELECT p.id, p.name, p.kind, p.sku, p.price, p.is_active, p.is_featured, p.track_stock, p.stock_qty, p.created_at,
      (SELECT url FROM product_images i WHERE i.product_id = p.id ORDER BY sort_order, id LIMIT 1) image,
      (SELECT GROUP_CONCAT(c.name SEPARATOR ', ') FROM product_categories pc JOIN categories c ON c.id = pc.category_id WHERE pc.product_id = p.id) cats,
      (SELECT GROUP_CONCAT(pc.category_id) FROM product_categories pc WHERE pc.product_id = p.id) cat_ids
     FROM products p WHERE ${where.join(" AND ")} ORDER BY ${table.orderBy} LIMIT ? OFFSET ?`,
    [...params, table.per, table.offset]
  );
  // Packages each product on this page is in: on the package's product list, or (pick-your-own
  // with a category) in that category or a sub-category.
  const packages = (
    await query(
      `SELECT p.id, p.name, p.pick_category_id, p.pick_min, (SELECT COUNT(*) FROM package_components pc WHERE pc.package_id = p.id) AS items
       FROM products p WHERE p.kind = 'package' ORDER BY p.is_active DESC, p.name`
    )
  ).map((pk) => {
    const isPick = pk.pick_min != null;
    const cat = isPick && pk.pick_category_id ? categories.find((c) => c.id === pk.pick_category_id) : null;
    return { id: pk.id, name: pk.name, pick: isPick, simple: !isPick && !Number(pk.items), pool: cat ? new Set([cat.id, ...cat.descendantIds]) : null };
  });
  const pageIds = products.filter((p) => p.kind === "product").map((p) => p.id);
  const items = pageIds.length ? await query("SELECT package_id, product_id FROM package_components WHERE product_id IN (?)", [pageIds]) : [];
  const inPackages = (p) => {
    const catIds = String(p.cat_ids || "").split(",").map(Number).filter(Boolean);
    return packages
      .filter((pk) => items.some((it) => it.package_id === pk.id && it.product_id === p.id) || (pk.pool && catIds.some((id) => pk.pool.has(id))))
      .map((pk) => pk.id);
  };
  const packageOptions = packages.map(({ id, name, pick, simple }) => ({ id, name, pick, simple }));
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
        <select name="cat" defaultValue={sp.cat || ""} className="input max-w-60" aria-label="Category">
          <option value="">Any category</option>
          <option value="none">No category yet</option>
          {categories.map((c) => <option key={c.id} value={c.id}>{c.path}</option>)}
        </select>
        <DateRangeFields basePath={BASE} sp={sp} label="Added" />
        <KeepTableState table={table} />
        <button className="btn-outline !py-2">Filter</button>
      </form>
      {sp.bulk && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">{sp.bulk}</p>}
      <div className="overflow-x-auto border border-line bg-white">
        <TableToolbar basePath={BASE} sp={sp} table={table} total={Number(total)} />
        <BulkCategoryBar categories={categories.map(({ id, path }) => ({ id, path }))} back={listUrl} />
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted">
            <tr>
              <th className="w-8 pl-3"><span className="sr-only">Select</span></th><th className="p-3">Product</th><th>Categories</th><th>Packages</th>
              <SortHeader label="Price" column="price" {...sortProps} />
              <SortHeader label="Stock" column="stock" {...sortProps} />
              <SortHeader label="Added" column="added" {...sortProps} />
              <th>Status</th><th></th>
            </tr>
          </thead>
          <tbody>
            {products.map((p) => (
              <tr key={p.id} className="border-b border-line">
                <td className="pl-3">
                  <input type="checkbox" name="ids" value={p.id} form="bulk-category" aria-label={`Select ${p.name}`} />
                </td>
                <td className="p-3">
                  <Link href={editProductHref(p.id, listUrl)} className="flex items-center gap-3">
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    {p.image ? <img src={p.image} alt="" className="h-14 w-11 object-cover" /> : <span className="h-14 w-11 bg-soft" />}
                    <span>
                      <span className="font-medium underline">{p.name}</span>
                      <span className="block text-xs text-muted">{p.sku}</span>
                    </span>
                  </Link>
                </td>
                <td className="max-w-48 text-xs text-muted">{p.cats}</td>
                <td className="pr-3">
                  {p.kind === "product" ? (
                    <PackageMultiSelect productId={p.id} productName={p.name} packages={packageOptions} selected={inPackages(p)} />
                  ) : (
                    <span className="text-xs text-muted">-</span>
                  )}
                </td>
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
