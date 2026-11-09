"use client";
import Link from "next/link";
import { useEffect, useRef, useState, useTransition } from "react";
import { useCart } from "./CartProvider";
import ProductImage from "./ProductImage";
import OrderTotals from "./OrderTotals";
import { formatNaira } from "@/lib/format";
import { quoteCart, placeOrder } from "@/app/actions/checkout";
import { NG_STATES } from "@/lib/ng-states";
import { trackBeginCheckout, trackAddShippingInfo, trackAddPaymentInfo, readAttribution } from "@/lib/analytics";


export default function CheckoutForm({ customer, addresses = [], shipping, showrooms, paymentMethods }) {
  const { lines, ready, syncPrices, clear } = useCart();
  const defaultAddress = addresses.find((a) => a.is_default) || addresses[0];
  const methodFor = (a) => (a && a.state !== "Lagos" ? "delivery_nationwide" : "delivery_lagos");
  const [method, setMethod] = useState(methodFor(defaultAddress));
  const [addrId, setAddrId] = useState(defaultAddress?.id ?? "new"); // saved address id, or "new"
  const savedAddress = addresses.find((a) => a.id === addrId);
  const [payment, setPayment] = useState(paymentMethods[0]?.id || "");
  const [quote, setQuote] = useState(null);
  const [error, setError] = useState("");
  const [pending, startTransition] = useTransition();
  const begun = useRef(false);

  const ikeja = showrooms.find((s) => /ikeja/i.test(s.name));
  const vi = showrooms.find((s) => /victoria|vi\b/i.test(s.name));
  const deliveryOptions = [
    { id: "delivery_lagos", label: "Home delivery in Lagos", fee: shipping.lagos },
    { id: "delivery_nationwide", label: "Home delivery outside Lagos", fee: shipping.nationwide },
    ...(shipping.pickup
      ? [
          { id: "pickup_ikeja", label: "Pick up at Ikeja showroom", fee: 0, hint: ikeja?.address },
          { id: "pickup_vi", label: "Pick up at Victoria Island showroom", fee: 0, hint: vi?.address },
        ]
      : []),
  ];
  const isDelivery = method.startsWith("delivery_");

  // Authoritative server quote whenever cart or delivery method changes.
  useEffect(() => {
    if (!ready || !lines.length) return;
    let cancelled = false;
    quoteCart(lines.map(({ productId, size, quantity }) => ({ productId, size, quantity })), method).then((q) => {
      if (cancelled) return;
      setQuote(q);
      syncPrices(q.items);
      if (!begun.current) {
        begun.current = true;
        trackBeginCheckout(lines, q.subtotal);
      }
    });
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [ready, method, JSON.stringify(lines.map((l) => [l.key, l.quantity]))]);

  function onSubmit(e) {
    e.preventDefault();
    setError("");
    const f = new FormData(e.currentTarget);
    const payload = {
      lines: lines.map(({ productId, size, quantity }) => ({ productId, size, quantity })),
      contact: {
        first_name: f.get("first_name"),
        last_name: f.get("last_name"),
        email: f.get("email"),
        phone: f.get("phone"),
        notes: [
          isDelivery && savedAddress?.phone ? `Delivery phone: ${savedAddress.phone}` : "",
          f.get("notes") || "",
        ].filter(Boolean).join("\n"),
      },
      delivery:
        isDelivery && savedAddress
          ? { method, address_line: savedAddress.address_line, city: savedAddress.city, state: savedAddress.state }
          : { method, address_line: f.get("address_line") || "", city: f.get("city") || "", state: f.get("state") || "" },
      saveAddress: Boolean(customer && isDelivery && !savedAddress && f.get("save_address")),
      paymentMethod: payment,
      utm: readAttribution(),
    };
    startTransition(async () => {
      const res = await placeOrder(payload);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      const value = quote?.total ?? 0;
      trackAddShippingInfo(lines, value, method);
      trackAddPaymentInfo(lines, value, payment);
      if (payment === "bank_transfer") clear();
      window.location.assign(res.redirect);
    });
  }

  if (!ready) return <div className="min-h-[60vh]" />;
  if (!lines.length) {
    return (
      <div className="mx-auto max-w-xl px-4 py-20 text-center">
        <h1 className="text-3xl">Your bag is empty</h1>
        <Link href="/shop" className="btn-primary mt-6">Continue shopping</Link>
      </div>
    );
  }

  return (
    <form onSubmit={onSubmit} className="mx-auto grid max-w-6xl gap-10 px-4 py-10 lg:grid-cols-[1fr_380px]">
      <div className="space-y-10">
        <h1 className="text-4xl">Checkout</h1>

        <section>
          <h2 className="mb-4 text-xl">Contact details</h2>
          <div className="grid gap-4 sm:grid-cols-2">
            <Field label="First name" name="first_name" defaultValue={customer?.first_name} autoComplete="given-name" required />
            <Field label="Last name" name="last_name" defaultValue={customer?.last_name} autoComplete="family-name" required />
            <Field label="Email" name="email" type="email" defaultValue={customer?.email} autoComplete="email" required />
            <Field label="Phone (WhatsApp preferred)" name="phone" type="tel" defaultValue={customer?.phone} autoComplete="tel" required />
          </div>
        </section>

        <section>
          <h2 className="mb-4 text-xl">Delivery</h2>
          <div className="space-y-2">
            {deliveryOptions.map((o) => (
              <label key={o.id} className={`flex cursor-pointer items-start gap-3 border p-4 ${method === o.id ? "border-gold bg-gold-light/40" : "border-line"}`}>
                <input type="radio" name="delivery_method" value={o.id} checked={method === o.id} onChange={() => setMethod(o.id)} className="mt-1" />
                <span className="flex-1">
                  <span className="block font-medium">{o.label}</span>
                  {o.hint && <span className="block text-sm text-muted">{o.hint}</span>}
                </span>
                <span className="text-sm">{o.fee ? formatNaira(o.fee) : "Free"}</span>
              </label>
            ))}
          </div>
          {shipping.freeThreshold > 0 && <p className="mt-2 text-xs text-muted">Free delivery on orders over {formatNaira(shipping.freeThreshold)}.</p>}
          {isDelivery && addresses.length > 0 && (
            <div className="mt-4 space-y-2">
              <p className="label">Deliver to</p>
              {addresses.map((a) => (
                <label key={a.id} className={`flex cursor-pointer items-start gap-3 border p-3 text-sm ${addrId === a.id ? "border-gold bg-gold-light/40" : "border-line"}`}>
                  <input
                    type="radio"
                    name="saved_address"
                    checked={addrId === a.id}
                    onChange={() => {
                      setAddrId(a.id);
                      setMethod(methodFor(a));
                    }}
                    className="mt-1"
                  />
                  <span>
                    <span className="block font-medium">{a.label || "Saved address"}{a.is_default ? <span className="ml-2 text-xs text-muted">(default)</span> : null}</span>
                    <span className="block text-muted">{a.address_line}, {a.city}, {a.state}</span>
                  </span>
                </label>
              ))}
              <label className={`flex cursor-pointer items-center gap-3 border p-3 text-sm ${addrId === "new" ? "border-gold bg-gold-light/40" : "border-line"}`}>
                <input type="radio" name="saved_address" checked={addrId === "new"} onChange={() => setAddrId("new")} />
                <span className="font-medium">Use a different address</span>
              </label>
            </div>
          )}
          {isDelivery && !savedAddress && (
            <div className="mt-4 grid gap-4 sm:grid-cols-2">
              <div className="sm:col-span-2">
                <Field label="Street address" name="address_line" autoComplete="street-address" required />
              </div>
              <Field label="City / Area" name="city" autoComplete="address-level2" required />
              <div>
                <label className="label" htmlFor="state">State</label>
                <select id="state" name="state" className="input" defaultValue={method === "delivery_lagos" ? "Lagos" : ""} required>
                  <option value="" disabled>Select state</option>
                  {NG_STATES.map((s) => <option key={s}>{s}</option>)}
                </select>
              </div>
              {customer && (
                <label className="flex items-center gap-2 text-sm sm:col-span-2">
                  <input type="checkbox" name="save_address" defaultChecked className="h-4 w-4" /> Save this address to my account
                </label>
              )}
            </div>
          )}
          <div className="mt-4">
            <label className="label" htmlFor="notes">Order notes (measurements, preferred delivery date…)</label>
            <textarea id="notes" name="notes" rows={3} className="input" />
          </div>
        </section>

        <section>
          <h2 className="mb-4 text-xl">Payment</h2>
          {paymentMethods.length === 0 ? (
            <p className="border border-line bg-soft p-4 text-sm">Online payment is being set up. Please contact us on WhatsApp to complete your order.</p>
          ) : (
            <div className="space-y-2">
              {paymentMethods.map((m) => (
                <label key={m.id} className={`flex cursor-pointer items-start gap-3 border p-4 ${payment === m.id ? "border-gold bg-gold-light/40" : "border-line"}`}>
                  <input type="radio" name="payment" value={m.id} checked={payment === m.id} onChange={() => setPayment(m.id)} className="mt-1" />
                  <span>
                    <span className="block font-medium">{m.label}</span>
                    <span className="block text-sm text-muted">{m.hint}</span>
                  </span>
                </label>
              ))}
            </div>
          )}
        </section>
      </div>

      <aside className="h-fit bg-soft p-6 lg:sticky lg:top-32">
        <h2 className="mb-4 text-xl">Order summary</h2>
        <ul className="space-y-4">
          {lines.map((l) => (
            <li key={l.key} className="flex gap-3 text-sm">
              <div className="relative">
                <ProductImage src={l.image} alt={l.name} width={56} height={70} className="h-[70px] w-14 object-cover" />
                <span className="absolute -right-2 -top-2 flex h-5 w-5 items-center justify-center rounded-full bg-ink text-[11px] text-white">{l.quantity}</span>
              </div>
              <div className="flex-1">
                <p>{l.name}</p>
                {l.size && <p className="text-muted">Size: {l.size}</p>}
                {vatNote(quote, l)}
              </div>
              <span>{formatNaira(l.price * l.quantity)}</span>
            </li>
          ))}
        </ul>
        <OrderTotals o={quote} className="mt-6 border-t border-line pt-4" />
        {quote?.problems?.length > 0 && <p className="mt-4 text-sm text-red-600">{quote.problems[0]}</p>}
        {error && <p className="mt-4 text-sm text-red-600" role="alert">{error}</p>}
        <button type="submit" disabled={pending || !quote || !payment || quote.problems.length > 0} className="btn-primary mt-6 w-full">
          {pending ? "Processing…" : payment && payment !== "bank_transfer" ? `Pay ${formatNaira(quote?.total ?? 0)}` : "Place order"}
        </button>
        <p className="mt-3 text-center text-xs text-muted">
          All prices in Nigerian Naira (NGN). See our{" "}
          <Link href="/pages/shipping-and-returns" target="_blank" className="underline">shipping &amp; returns policy</Link>.
        </p>
      </aside>
    </form>
  );
}

/** "+ VAT" / "VAT incl." under each line, once the server quote is in. */
function vatNote(quote, line) {
  if (!quote?.vat_rate) return null;
  const item = quote.items.find((i) => i.product_id === line.productId && (i.size || null) === (line.size || null));
  if (!item) return null;
  const label = quote.vat_label || "VAT";
  return <p className="text-xs text-muted">{item.vat_inclusive ? `${label} inclusive` : `+ ${label}`}</p>;
}

function Field({ label, name, type = "text", ...rest }) {
  return (
    <div>
      <label className="label" htmlFor={name}>{label}</label>
      <input id={name} name={name} type={type} className="input" {...rest} />
    </div>
  );
}
