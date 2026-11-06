import { getAdmin } from "@/lib/auth";
import { buildOrderEmails } from "@/lib/order-emails";

export const dynamic = "force-dynamic";

// Admin-only preview of the order emails, without sending anything.
// /admin/orders/:id/email           -> customer confirmation
// /admin/orders/:id/email?to=admin  -> store notification
// /admin/orders/:id/email?format=text -> plain-text version
export async function GET(request, { params }) {
  if (!(await getAdmin())) return new Response("Not found", { status: 404 });
  const { id } = await params;
  const built = await buildOrderEmails(Number(id));
  if (!built) return new Response("Order not found", { status: 404 });
  const sp = new URL(request.url).searchParams;
  const mail = sp.get("to") === "admin" ? built.admin : built.customer;
  if (sp.get("format") === "text") {
    return new Response(`Subject: ${mail.subject}\n\n${mail.text}`, { headers: { "Content-Type": "text/plain; charset=utf-8" } });
  }
  return new Response(mail.html, { headers: { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store" } });
}
