import { getSettings } from "@/lib/settings";
import { getCustomer } from "@/lib/auth";
import { getShowrooms } from "@/lib/catalog";
import { onlinePaymentAvailable } from "@/lib/payments";
import CheckoutForm from "@/components/CheckoutForm";
import { getAddresses } from "@/lib/customers";
import Link from "next/link";
import { VerifyEmailNotice } from "@/components/AddressBook";

export const metadata = { title: "Checkout", robots: { index: false } };

export default async function CheckoutPage() {
  const [settings, customer, showrooms] = await Promise.all([getSettings(), getCustomer(), getShowrooms()]);
  if (customer && !customer.email_verified_at) {
    return (
      <div className="mx-auto max-w-xl px-4 py-16">
        <h1 className="text-3xl">Confirm your email to check out</h1>
        <p className="mt-3 text-muted">Your bag is saved. As soon as your email is confirmed you can come back here and place your order.</p>
        <div className="mt-6">
          <VerifyEmailNotice email={customer.email} />
        </div>
        <div className="mt-8 flex flex-wrap gap-3">
          <Link href="/account" className="btn-outline">My account</Link>
          <Link href="/shop" className="btn-outline">Keep shopping</Link>
        </div>
      </div>
    );
  }
  const { shipping, payments } = settings;
  const addresses = customer
    ? (await getAddresses(customer.id)).map(({ id, label, address_line, city, state, phone, is_default }) => ({ id, label, address_line, city, state, phone, is_default }))
    : [];
  const methods = [];
  if (payments.paystack_enabled && onlinePaymentAvailable("paystack")) methods.push({ id: "paystack", label: "Pay online with Paystack", hint: "Card, bank transfer, USSD or bank app, with secure checkout by Paystack." });
  if (payments.opay_enabled && onlinePaymentAvailable("opay")) methods.push({ id: "opay", label: "Pay online with OPay", hint: "Card, bank transfer, USSD or OPay wallet, with secure checkout by OPay." });
  if (payments.bank_transfer_enabled) methods.push({ id: "bank_transfer", label: "Direct bank transfer", hint: "We'll show our account details after you place the order. Your order is confirmed once payment is received." });

  return (
    <CheckoutForm
      customer={customer ? { first_name: customer.first_name, last_name: customer.last_name, email: customer.email, phone: customer.phone } : null}
      addresses={addresses}
      shipping={{
        lagos: Number(shipping.delivery_lagos_fee),
        nationwide: Number(shipping.delivery_nationwide_fee),
        pickup: shipping.pickup_enabled,
        freeThreshold: Number(shipping.free_delivery_threshold || 0),
      }}
      showrooms={showrooms.map((s) => ({ id: s.id, name: s.name, address: s.address }))}
      paymentMethods={methods}
    />
  );
}
