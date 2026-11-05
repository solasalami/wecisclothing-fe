import { getSettings } from "@/lib/settings";
import { getCustomer } from "@/lib/auth";
import { getShowrooms } from "@/lib/catalog";
import { onlinePaymentAvailable } from "@/lib/payments";
import CheckoutForm from "@/components/CheckoutForm";

export const metadata = { title: "Checkout", robots: { index: false } };

export default async function CheckoutPage() {
  const [settings, customer, showrooms] = await Promise.all([getSettings(), getCustomer(), getShowrooms()]);
  const { shipping, payments } = settings;
  const methods = [];
  if (payments.opay_enabled && onlinePaymentAvailable()) methods.push({ id: "opay", label: "Pay online with OPay", hint: "Card, bank transfer, USSD or OPay wallet — secure checkout by OPay." });
  if (payments.bank_transfer_enabled) methods.push({ id: "bank_transfer", label: "Direct bank transfer", hint: "We'll show our account details after you place the order. Your order is confirmed once payment is received." });

  return (
    <CheckoutForm
      customer={customer}
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
