import { NextResponse } from "next/server";
import { verifyCallbackSignature } from "@/lib/opay";
import { confirmPayment } from "@/lib/payments";

export const dynamic = "force-dynamic";

// OPay server-to-server notification (callbackUrl). The signature proves it came
// from OPay; we still re-query the status API before marking anything paid, and
// confirmPayment/markOrderPaid are idempotent so retries are harmless.
export async function POST(request) {
  let body;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ ok: false }, { status: 400 });
  }
  if (!verifyCallbackSignature(body)) {
    console.warn("OPay callback with invalid signature", body?.payload?.reference);
    return NextResponse.json({ ok: false }, { status: 401 });
  }
  const reference = body.payload.reference;
  try {
    const { status } = await confirmPayment(reference);
    return NextResponse.json({ ok: true, status });
  } catch (err) {
    // Includes "database unavailable" (thrown as a redirect): never redirect a webhook —
    // answer 503 so OPay retries later and the payment is confirmed once we're back.
    console.error("OPay callback processing failed", err?.digest || err);
    return NextResponse.json({ ok: false }, { status: 503, headers: { "Retry-After": "120" } });
  }
}
