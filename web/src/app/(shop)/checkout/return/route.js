import { NextResponse } from "next/server";
import { confirmPayment } from "@/lib/payments";
import { orderAccessToken } from "@/lib/orders";

export const dynamic = "force-dynamic";

// OPay sends the shopper back here (returnUrl / cancelUrl). We never trust the
// redirect itself: confirmPayment() asks OPay for the real status server-side.
export async function GET(request) {
  const url = new URL(request.url);
  const ref = url.searchParams.get("ref") || "";
  const { order } = await confirmPayment(ref);
  if (!order) return NextResponse.redirect(new URL("/cart", url));
  const t = orderAccessToken(order.order_number);
  return NextResponse.redirect(new URL(`/checkout/success/${order.order_number}?t=${t}`, url));
}
