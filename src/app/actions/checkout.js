"use server";
import { z } from "zod";
import { unstable_rethrow } from "next/navigation";
import { getSettings } from "@/lib/settings";
import { getCustomer } from "@/lib/auth";
import { priceCart, shippingFee, orderTotal, createOrder, getOrderByNumber, orderAccessToken, checkOrderAccessToken, DELIVERY_METHODS } from "@/lib/orders";
import { startOnlinePayment, onlinePaymentAvailable, ONLINE_METHODS } from "@/lib/payments";
import { verifiedCustomerByEmail, hasUnverifiedAccount, rememberAddress } from "@/lib/customers";
import { isDisabledEmail } from "@/lib/customer-admin";

const lineSchema = z.object({
  productId: z.coerce.number().int().positive(),
  size: z.string().nullable().optional(),
  quantity: z.coerce.number().int().min(1).max(20),
  // Bundle packages: the size chosen for each included product, { [productId]: size|null }.
  parts: z.record(z.string(), z.string().max(40).nullable()).nullable().optional(),
});

export async function quoteCart(lines, deliveryMethod) {
  const { shipping } = await getSettings();
  const priced = await priceCart(lines);
  const fee = deliveryMethod && DELIVERY_METHODS[deliveryMethod] ? shippingFee(deliveryMethod, priced.subtotal, shipping) : 0;
  return {
    items: priced.items.map(({ key, product_id, size, components, unit_price, quantity, line_total, name, vat_inclusive, vat_amount }) => ({
      key, product_id, size, components, unit_price, quantity, line_total, name, vat_inclusive, vat_amount,
    })),
    subtotal: priced.subtotal,
    vat_rate: priced.vat_rate,
    vat_label: priced.vat_label,
    vat_added: priced.vat_added,
    vat_included: priced.vat_included,
    fee,
    total: orderTotal({ subtotal: priced.subtotal, vat_added: priced.vat_added, fee }),
    problems: priced.problems,
  };
}

const checkoutSchema = z
  .object({
    lines: z.array(lineSchema).min(1, "Your bag is empty"),
    contact: z.object({
      first_name: z.string().trim().min(1, "First name is required").max(80),
      last_name: z.string().trim().min(1, "Last name is required").max(80),
      email: z.string().trim().email("Enter a valid email").max(190),
      phone: z.string().trim().min(7, "Enter a valid phone number").max(40),
      notes: z.string().trim().max(1000).optional().default(""),
    }),
    delivery: z.object({
      method: z.enum(Object.keys(DELIVERY_METHODS)),
      address_line: z.string().trim().max(255).optional().default(""),
      city: z.string().trim().max(100).optional().default(""),
      state: z.string().trim().max(100).optional().default(""),
    }),
    paymentMethod: z.enum([...ONLINE_METHODS, "bank_transfer"]),
    saveAddress: z.boolean().optional().default(false),
    utm: z.record(z.string(), z.any()).nullable().optional(),
  })
  .superRefine((v, ctx) => {
    if (v.delivery.method.startsWith("delivery_") && (!v.delivery.address_line || !v.delivery.city || !v.delivery.state)) {
      ctx.addIssue({ code: "custom", message: "Delivery address, city and state are required", path: ["delivery"] });
    }
  });

export async function placeOrder(input) {
  const parsed = checkoutSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: parsed.error.issues[0]?.message || "Please check your details" };
  const data = parsed.data;

  // Accounts must confirm their email before ordering. This also covers checking out
  // signed out with the email of an account that is still unconfirmed.
  const signedInCustomer = await getCustomer();
  if (signedInCustomer && !signedInCustomer.email_verified_at) {
    return { ok: false, error: "Please confirm your email before placing an order. Go to My account to send yourself a new confirmation link." };
  }
  if (!signedInCustomer && (await isDisabledEmail(data.contact.email))) {
    return { ok: false, error: "We can't take orders for this email address. Please contact us on WhatsApp or by phone." };
  }
  if (!signedInCustomer && (await hasUnverifiedAccount(data.contact.email))) {
    return { ok: false, error: "This email belongs to a Wecis account that hasn't been confirmed yet. Sign in and confirm your email first, or use a different email." };
  }

  const settings = await getSettings();
  if (data.delivery.method.startsWith("pickup_") && !settings.shipping.pickup_enabled) return { ok: false, error: "Pickup is not available" };
  if (data.paymentMethod === "paystack" && (!settings.payments.paystack_enabled || !onlinePaymentAvailable("paystack"))) {
    return { ok: false, error: "Paystack payment is not available right now. Please choose another method." };
  }
  if (data.paymentMethod === "opay" && (!settings.payments.opay_enabled || !onlinePaymentAvailable("opay"))) {
    return { ok: false, error: "Card / OPay payment is not available right now. Please choose another method." };
  }
  if (data.paymentMethod === "bank_transfer" && !settings.payments.bank_transfer_enabled) {
    return { ok: false, error: "Bank transfer is not available right now." };
  }

  const priced = await priceCart(data.lines);
  if (priced.problems.length) return { ok: false, error: priced.problems[0] };
  if (!priced.items.length) return { ok: false, error: "Your bag is empty" };

  const fee = shippingFee(data.delivery.method, priced.subtotal, settings.shipping);
  // Signed in: the order belongs to the account. Signed out but the email has a
  // confirmed account: attach it too, so it shows up when they sign in.
  const customer = signedInCustomer || (await verifiedCustomerByEmail(data.contact.email));
  const signedIn = customer && "first_name" in customer;
  if (signedIn && data.saveAddress && data.delivery.method.startsWith("delivery_")) {
    await rememberAddress(customer.id, data.delivery).catch((e) => console.error("Save address failed", e));
  }
  const order = await createOrder({
    customer,
    contact: data.contact,
    delivery: data.delivery,
    items: priced.items,
    subtotal: priced.subtotal,
    vat: priced,
    fee,
    paymentMethod: data.paymentMethod,
    utm: data.utm || null,
  });

  const token = orderAccessToken(order.order_number);
  if (data.paymentMethod === "bank_transfer") {
    return { ok: true, redirect: `/checkout/success/${order.order_number}?t=${token}` };
  }

  try {
    const full = await getOrderByNumber(order.order_number);
    const url = await startOnlinePayment(full);
    return { ok: true, redirect: url, orderNumber: order.order_number };
  } catch (err) {
    unstable_rethrow(err);
    console.error("Payment init failed", err);
    // Order exists; let the shopper retry payment from the order page.
    return { ok: true, redirect: `/checkout/success/${order.order_number}?t=${token}&payment=error` };
  }
}

export async function retryPayment(orderNumber, token) {
  if (!checkOrderAccessToken(orderNumber, token)) return { ok: false, error: "Not allowed" };
  const order = await getOrderByNumber(orderNumber);
  if (!order || order.payment_status === "paid" || !ONLINE_METHODS.includes(order.payment_method)) return { ok: false, error: "This order cannot be paid online" };
  try {
    return { ok: true, redirect: await startOnlinePayment(order) };
  } catch (err) {
    unstable_rethrow(err);
    console.error(err);
    return { ok: false, error: "Could not reach the payment gateway. Please try again or contact us on WhatsApp." };
  }
}

