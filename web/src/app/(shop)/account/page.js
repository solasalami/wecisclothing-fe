import Link from "next/link";
import { getCustomer } from "@/lib/auth";
import { query } from "@/lib/db";
import { formatNaira, formatDate } from "@/lib/format";
import { LoginForm } from "@/components/AuthForms";
import { logoutCustomer } from "@/app/actions/account";

export const metadata = { title: "My account", robots: { index: false } };

export default async function AccountPage() {
  const customer = await getCustomer();
  if (!customer) {
    return (
      <div className="mx-auto max-w-md px-4 py-16">
        <h1 className="mb-8 text-center text-4xl">Sign in</h1>
        <LoginForm />
      </div>
    );
  }
  const orders = await query(
    "SELECT order_number, total, status, payment_status, created_at FROM orders WHERE customer_id = ? ORDER BY id DESC LIMIT 50",
    [customer.id]
  );
  return (
    <div className="mx-auto max-w-4xl px-4 py-12">
      <div className="flex items-center justify-between">
        <h1 className="text-4xl">Hello, {customer.first_name}</h1>
        <form action={logoutCustomer}><button className="text-sm underline">Sign out</button></form>
      </div>
      <h2 className="mb-4 mt-10 text-2xl">Your orders</h2>
      {orders.length === 0 ? (
        <p className="text-muted">No orders yet. <Link href="/shop" className="underline">Start shopping</Link></p>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead className="border-b border-line text-xs uppercase text-muted">
              <tr><th className="py-2">Order</th><th>Date</th><th>Status</th><th>Payment</th><th className="text-right">Total</th></tr>
            </thead>
            <tbody>
              {orders.map((o) => (
                <tr key={o.order_number} className="border-b border-line">
                  <td className="py-3"><Link href={`/account/orders/${o.order_number}`} className="underline">{o.order_number}</Link></td>
                  <td>{formatDate(o.created_at)}</td>
                  <td className="capitalize">{o.status}</td>
                  <td className="capitalize">{o.payment_status}</td>
                  <td className="text-right">{formatNaira(o.total)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
