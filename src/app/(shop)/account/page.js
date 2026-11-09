import Link from "next/link";
import { getCustomer } from "@/lib/auth";
import { query } from "@/lib/db";
import { formatNaira, formatDate } from "@/lib/format";
import { LoginForm } from "@/components/AuthForms";
import { logoutCustomer } from "@/app/actions/account";
import { getAddresses, linkGuestOrders, MAX_ADDRESSES } from "@/lib/customers";
import AddressBook, { VerifyEmailNotice } from "@/components/AddressBook";
import AccountPassword from "@/components/AccountPassword";

export const metadata = { title: "My account", robots: { index: false } };

export default async function AccountPage({ searchParams }) {
  const sp = await searchParams;
  const customer = await getCustomer();
  if (!customer) {
    return (
      <div className="mx-auto max-w-md px-4 py-16">
        <h1 className="mb-8 text-center text-4xl">Sign in</h1>
        {sp.verify === "invalid" && (
          <p className="mb-6 border border-red-200 bg-red-50 p-3 text-sm text-red-700">That confirmation link has expired or is not valid. Sign in and we can send you a new one.</p>
        )}
        {sp.verified && <p className="mb-6 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Your email is confirmed. Sign in to see your orders.</p>}
        <LoginForm />
      </div>
    );
  }
  // Picks up guest orders placed with this (confirmed) email since the last visit.
  await linkGuestOrders(customer);
  const [orders, addresses] = await Promise.all([
    query(
      "SELECT order_number, total, status, payment_status, created_at FROM orders WHERE customer_id = ? ORDER BY id DESC LIMIT 50",
      [customer.id]
    ),
    getAddresses(customer.id),
  ]);
  return (
    <div className="mx-auto max-w-4xl px-4 py-12">
      <div className="flex items-center justify-between">
        <h1 className="text-4xl">Hello, {customer.first_name}</h1>
        <form action={logoutCustomer}><button className="text-sm underline">Sign out</button></form>
      </div>
      <p className="mt-2 text-sm text-muted">
        {customer.email} · {customer.phone} · Member since {formatDate(customer.created_at, { dateOnly: true })}
      </p>

      <div className="mt-6 space-y-3">
        {sp.welcome && (
          <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Welcome to Wecis Clothing! Your account is ready.</p>
        )}
        {sp.verified && (
          <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">
            Your email is confirmed and you can now place orders.{" "}
            {Number(sp.linked) > 0 ? `We found ${sp.linked} earlier ${Number(sp.linked) === 1 ? "order" : "orders"} and added them below. ` : ""}
            <Link href="/checkout" className="font-semibold underline">Go to checkout</Link>
          </p>
        )}
        {sp.reset && (
          <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Your new password is saved and you&apos;re signed in. Any other devices signed in to your account have been signed out.</p>
        )}
        {sp.verify === "invalid" && (
          <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700">That confirmation link has expired or is not valid. Send yourself a new one below.</p>
        )}
        {!customer.email_verified_at && <VerifyEmailNotice email={customer.email} />}
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

      <div className="mt-12">
        <AddressBook addresses={addresses.map(({ created_at, updated_at, ...a }) => a)} max={MAX_ADDRESSES} />
      </div>

      <AccountPassword email={customer.email} />
    </div>
  );
}
