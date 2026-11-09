import { NextResponse } from "next/server";
import { verifyWebhookSignature } from "@/lib/paystack";
import { confirmPayment } from "@/lib/payments";
import { recordWebhook } from "@/lib/golive";

export const dynamic = "force-dynamic";

// Paystack server-to-server notification (set this URL in the Paystack dashboard).
// The signature proves it came from Paystack; we still verify the transaction with
// the API before marking anything paid, and confirmPayment/markOrderPaid are
// idempotent so Paystack's retries are harmless.
export async function POST(request) {
  const raw = await request.text(); // the signature covers the exact raw body
  if (!verifyWebhookSignature(raw, request.headers.get("x-paystack-signature"))) {
    console.warn("Paystack webhook with invalid signature");
    await recordWebhook("invalid", {}, "paystack");
    return NextResponse.json({ ok: false }, { status: 401 });
  }
  let event;
  try {
    event = JSON.parse(raw);
  } catch {
    return NextResponse.json({ ok: false }, { status: 400 });
  }
  const reference = event?.data?.reference;
  // Only charges matter here; acknowledge everything else so Paystack stops retrying.
  if (event?.event !== "charge.success" || !reference) return NextResponse.json({ ok: true, ignored: event?.event || null });
  try {
    const { status } = await confirmPayment(String(reference));
    await recordWebhook("valid", { reference, status }, "paystack"); // shown on the go-live checklist
    return NextResponse.json({ ok: true, status });
  } catch (err) {
    // Includes "database unavailable" (thrown as a redirect): never redirect a webhook;
    // answer 503 so Paystack retries later and the payment is confirmed once we're back.
    console.error("Paystack webhook processing failed", err?.digest || err);
    return NextResponse.json({ ok: false }, { status: 503, headers: { "Retry-After": "120" } });
  }
}
