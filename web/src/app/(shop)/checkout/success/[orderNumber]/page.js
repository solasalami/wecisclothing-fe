import { notFound } from "next/navigation";
import Link from "next/link";
import { getOrderByNumber, checkOrderAccessToken, claimPurchaseTracking, DELIVERY_METHODS } from "@/lib/orders";
import { confirmPayment } from "@/lib/payments";
import { getCustomer } from "@/lib/auth";
import { getSettings } from "@/lib/settings";
import { formatNaira, whatsappLink, telLink } from "@/lib/format";
import PurchaseTracker from "@/components/PurchaseTracker";
import RetryPayment from "@/components/RetryPayment";

export const metadata = { title: "Order confirmation", robots: { index: false } };

export default async function OrderSuccessPage({ params, searchParams }) {
  const { orderNumber } = await params;
  const { t, payment: paymentFlag } = await searchParams;
  let order = await getOrderByNumber(orderNumber);
  if (!order) notFound();
  const customer = await getCustomer();
  const allowed = checkOrderAccessToken(orderNumber, t) || (customer && customer.id === order.customer_id);
  if (!allowed) notFound();

  // If the shopper returns before the callback lands, ask OPay directly.
  if (order.payment_method === "opay" && order.payment_status === "pending" && order.payment_reference) {
    await confirmPayment(order.payment_reference);
    order = await getOrderByNumber(orderNumber);
  }

  const { store, payments } = await getSettings();
  const paid = order.payment_status === "paid";

  // Atomic claim: only the very first render after payment gets the purchase payload.
  let purchase = null;
  if (paid && (await claimPurchaseTracking(order.id))) {
    purchase = {
      transaction_id: order.order_number,
      value: Number(order.total),
      shipping: Number(order.shipping_fee),
      currency: "NGN",
      email: order.email,
      phone: order.phone,
      items: order.items.map((i, index) => ({
        item_id: String(i.sku || i.product_id),
        item_name: i.name,
        item_variant: i.size || undefined,
        price: Number(i.unit_price),
        quantity: i.quantity,
        index,
      })),
    };
  }

  const heading = paid
    ? "Thank you — your order is confirmed!"
    : order.payment_method === "bank_transfer"
      ? "Order received — awaiting bank transfer"
      : order.payment_status === "failed"
        ? "Payment was not completed"
        : "Payment processing…";

  return (
    <div className="mx-auto max-w-3xl px-4 py-14">
      <PurchaseTracker purchase={purchase} orderNumber={order.order_number} clearCart={paid || order.payment_method === "bank_transfer"} />
      <p className="text-xs uppercase tracking-widest text-muted">Order {order.order_number}</p>
      <h1 className="mt-2 text-3xl md:text-4xl">{heading}</h1>

      {paid && <p className="mt-4 text-muted">We&apos;ve received your payment of {formatNaira(order.total)}. Our team will contact you on {order.phone} shortly.</p>}

      {!paid && order.payment_method === "bank_transfer" && (
        <div className="mt-6 border border-ink p-5">
          <p className="font-medium">Please transfer {formatNaira(order.total)} to:</p>
          <pre className="mt-3 whitespace-pre-wrap font-sans text-sm">{payments.bank_transfer_details}</pre>
          <p className="mt-3 text-sm">Use <strong>{order.order_number}</strong> as your reference, then send your receipt on WhatsApp.</p>
        </div>
      )}

      {!paid && order.payment_method === "opay" && (
        <div className="mt-6 space-y-4">
          {paymentFlag === "error" && <p className="text-red-600">We couldn&apos;t reach the payment gateway.</p>}
          {order.payment_status === "pending" && <p className="text-muted">We&apos;re waiting for confirmation from OPay. Refresh this page in a moment.</p>}
          <RetryPayment orderNumber={order.order_number} token={t} />
        </div>
      )}

      <div className="mt-8 flex flex-wrap gap-3">
        <a
          href={whatsappLink(store.whatsapp, `Hello Wecis Clothing, I'm following up on order ${order.order_number}.`)}
          target="_blank"
          rel="noopener noreferrer"
          data-track-location="order_confirmation"
          className="btn-whatsapp"
        >
          WhatsApp us about this order
        </a>
        <a href={telLink(store.phone)} data-track-location="order_confirmation" className="btn-outline">Call {store.phone}</a>
      </div>

      <div className="mt-10 border-t border-line pt-6">
        <h2 className="mb-4 text-xl">Order details</h2>
        <ul className="divide-y divide-line text-sm">
          {order.items.map((i) => (
            <li key={i.id} className="flex justify-between py-3">
              <span>{i.quantity} × {i.name}{i.size ? ` (${i.size})` : ""}</span>
              <span>{formatNaira(i.line_total)}</span>
            </li>
          ))}
        </ul>
        <dl className="mt-4 space-y-1 text-sm">
          <div className="flex justify-between"><dt>Subtotal</dt><dd>{formatNaira(order.subtotal)}</dd></div>
          <div className="flex justify-between"><dt>Delivery ({DELIVERY_METHODS[order.delivery_method]})</dt><dd>{Number(order.shipping_fee) ? formatNaira(order.shipping_fee) : "Free"}</dd></div>
          <div className="flex justify-between text-lg font-medium"><dt>Total</dt><dd>{formatNaira(order.total)}</dd></div>
        </dl>
        {order.address_line && <p className="mt-4 text-sm text-muted">Delivering to: {order.address_line}, {order.city}, {order.state}</p>}
      </div>
      <Link href="/shop" className="btn-primary mt-10">Continue shopping</Link>
    </div>
  );
}
