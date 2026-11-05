import { notFound, redirect } from "next/navigation";
import { mockPaymentsEnabled, confirmPayment } from "@/lib/payments";
import { queryOne } from "@/lib/db";
import { formatNaira } from "@/lib/format";
import { orderAccessToken } from "@/lib/orders";

export const metadata = { title: "Test payment", robots: { index: false } };

// DEV ONLY: stands in for the OPay cashier page until real keys are configured.
export default async function MockPayPage({ searchParams }) {
  if (!mockPaymentsEnabled()) notFound();
  const { ref } = await searchParams;
  const payment = await queryOne("SELECT * FROM payments WHERE reference = ? AND provider = 'mock'", [ref || ""]);
  if (!payment) notFound();

  async function complete(formData) {
    "use server";
    if (!mockPaymentsEnabled()) return;
    const status = formData.get("status") === "SUCCESS" ? "SUCCESS" : "FAIL";
    const { order } = await confirmPayment(String(formData.get("ref")), { mockStatus: status });
    redirect(`/checkout/success/${order.order_number}?t=${orderAccessToken(order.order_number)}`);
  }

  return (
    <div className="mx-auto max-w-md px-4 py-20 text-center">
      <p className="text-xs font-bold uppercase tracking-widest text-red-600">Test mode — no real money</p>
      <h1 className="mt-3 text-3xl">Simulated OPay checkout</h1>
      <p className="mt-4 text-lg">{formatNaira(payment.amount)}</p>
      <p className="text-sm text-muted">Reference {payment.reference}</p>
      <form action={complete} className="mt-8 flex flex-col gap-3">
        <input type="hidden" name="ref" value={payment.reference} />
        <button name="status" value="SUCCESS" className="btn-primary">Simulate successful payment</button>
        <button name="status" value="FAIL" className="btn-outline">Simulate failed payment</button>
      </form>
    </div>
  );
}
