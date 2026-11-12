import Link from "next/link";
import { notFound } from "next/navigation";
import { formatDate, formatNaira, whatsappLink, telLink } from "@/lib/format";
import { PageHeader, Card, Badge } from "@/components/admin/Fields";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import OrdersTable from "@/components/admin/OrdersTable";
import { getCustomerProfile } from "@/lib/customer-admin";
import { storeMailbox } from "@/lib/contact";
import { getSetting } from "@/lib/settings";
import { emailEnabled } from "@/lib/email";
import { emailCustomer, setCustomerStatus } from "@/app/admin/actions";

export const metadata = { title: "Customer" };

const day = (v) => formatDate(v, { dateOnly: true });

export default async function CustomerAdmin({ params, searchParams }) {
  const { email } = await params;
  const { saved } = await searchParams;
  const [c, store] = await Promise.all([getCustomerProfile(decodeURIComponent(email)), getSetting("store")]);
  if (!c) notFound();
  const a = c.account;
  const disabled = a && !a.is_active;
  const mailbox = storeMailbox(store);
  const canEmail = emailEnabled();

  return (
    <div className="space-y-6">
      <div>
        <Link href="/admin/customers" className="mb-3 inline-flex items-center gap-1.5 text-sm font-semibold text-muted hover:text-ink">
          <span aria-hidden="true">←</span> Back to Customers
        </Link>
        <PageHeader title={c.name}>
          {disabled ? <Badge tone="red">Disabled</Badge> : a ? <Badge tone="green">Registered</Badge> : <Badge>Guest</Badge>}
        </PageHeader>
      </div>

      {saved === "disabled" && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Account disabled. They have been signed out and can&apos;t sign in or order with this email.</p>}
      {saved === "enabled" && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">Account enabled. They can sign in and order again.</p>}

      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <div className="space-y-6">
          <Card title="Contact details">
            <dl className="grid gap-x-6 gap-y-3 text-sm sm:grid-cols-[140px_1fr]">
              <dt className="text-muted">Name</dt><dd>{c.name}</dd>
              <dt className="text-muted">Email</dt>
              <dd>
                <a href={`mailto:${c.email}`} className="underline">{c.email}</a>
                {a && <span className="ml-2 text-xs text-muted">{a.email_verified_at ? "Confirmed" : "Not confirmed yet"}</span>}
              </dd>
              <dt className="text-muted">Phone</dt>
              <dd>
                {c.phone ? (
                  <>
                    <a href={telLink(c.phone)} className="underline">{c.phone}</a>
                    <a href={whatsappLink(c.phone, `Hello ${c.firstName}, this is ${store.name}.`)} target="_blank" rel="noopener noreferrer" className="ml-3 text-xs underline">WhatsApp</a>
                  </>
                ) : <span className="text-muted">Not given</span>}
                {c.otherPhones.length > 0 && <span className="block text-xs text-muted">Also used at checkout: {c.otherPhones.join(", ")}</span>}
              </dd>
              <dt className="text-muted">Account</dt>
              <dd>{a ? `Registered ${day(a.created_at)}` : "No account (guest checkout only)"}</dd>
              <dt className="text-muted">Orders</dt>
              <dd>{c.orderCount} {c.orderCount === 1 ? "order" : "orders"}{c.firstOrder ? `, first on ${day(c.firstOrder)}` : ""} · {formatNaira(c.paidTotal)} paid</dd>
            </dl>
          </Card>

          {a && (
            <Card title={`Saved addresses (${c.addresses.length})`}>
              {c.addresses.length ? (
                <ul className="grid gap-3 text-sm sm:grid-cols-2">
                  {c.addresses.map((ad) => (
                    <li key={ad.id} className="border border-line p-3">
                      <p className="font-medium">{ad.label || "Address"}{ad.is_default ? <span className="ml-2 text-xs text-muted">Default</span> : null}</p>
                      <p>{ad.address_line}</p>
                      <p>{ad.city}, {ad.state}</p>
                      {ad.phone && <p className="text-muted">{ad.phone}</p>}
                    </li>
                  ))}
                </ul>
              ) : <p className="text-sm text-muted">No saved addresses.</p>}
            </Card>
          )}

          <Card title={`Orders (${c.orderCount})`}>
            <OrdersTable orders={c.orders} empty="No orders yet." />
            {c.orderCount >= 100 && <p className="mt-2 text-xs text-muted">Showing the latest 100. <Link href={`/admin/orders?q=${encodeURIComponent(c.email)}`} className="underline">See all on Orders</Link></p>}
          </Card>
        </div>

        <div className="space-y-6">
          <Card title="Send an email">
            {canEmail ? (
              <ActionForm action={emailCustomer} className="space-y-3">
                <input type="hidden" name="email" value={c.email} />
                <p className="text-xs text-muted">
                  To {c.email}. Starts with &ldquo;Hello {c.firstName || c.name},&rdquo;{mailbox ? <>, and a copy goes to <strong>{mailbox}</strong>. Their reply comes back to that mailbox</> : ""}.
                </p>
                <div>
                  <label className="label" htmlFor="subject">Subject</label>
                  <input id="subject" name="subject" required minLength={2} maxLength={200} className="input" placeholder="e.g. Your order is ready for pickup" />
                </div>
                <div>
                  <label className="label" htmlFor="message">Message</label>
                  <textarea id="message" name="message" rows={7} required minLength={2} maxLength={10000} className="input" placeholder="Write your message…" />
                </div>
                <SubmitButton className="btn-primary w-full !py-2.5" pendingText="Sending…">Send email</SubmitButton>
              </ActionForm>
            ) : (
              <p className="text-sm text-yellow-800">Email sending is off (SEND_EMAIL and SMTP settings), so emails can&apos;t be sent from here yet.</p>
            )}
          </Card>

          <Card title="Account access">
            {a ? (
              <form action={setCustomerStatus} className="space-y-3 text-sm">
                <input type="hidden" name="email" value={c.email} />
                <input type="hidden" name="active" value={disabled ? "1" : "0"} />
                {disabled ? (
                  <>
                    <p>This account is <strong>disabled</strong>: they can&apos;t sign in, reset their password or place orders with this email.</p>
                    <ConfirmButton message={`Enable ${c.email}? They will be able to sign in and order again.`} className="btn-outline w-full !py-2">Enable account</ConfirmButton>
                  </>
                ) : (
                  <>
                    <p className="text-muted">Disabling signs them out everywhere and stops them signing in, resetting their password or placing orders with this email, even as a guest. Their orders and details are kept, and you can enable the account again at any time.</p>
                    <ConfirmButton message={`Disable ${c.email}? They will be signed out and won't be able to sign in or order.`} className="w-full border border-red-300 px-4 py-2 text-xs font-semibold uppercase tracking-wider text-red-700 hover:bg-red-50">Disable account</ConfirmButton>
                  </>
                )}
              </form>
            ) : (
              <p className="text-sm text-muted">This customer has only checked out as a guest, so there is no account to disable.</p>
            )}
          </Card>

          <Card title={`Emails sent (${c.emails.length})`}>
            {c.emails.length ? (
              <ul className="space-y-3 text-sm">
                {c.emails.map((m) => (
                  <li key={m.id} className="border-l-2 border-gold bg-soft p-3">
                    <p className="text-xs text-muted">{formatDate(m.created_at)}{m.sent_by ? ` by ${m.sent_by}` : ""}{m.copied_to ? ` (copy in ${m.copied_to})` : ""}</p>
                    <p className="mt-1 font-medium">{m.subject}</p>
                    <p className="mt-1 whitespace-pre-wrap">{m.body}</p>
                  </li>
                ))}
              </ul>
            ) : <p className="text-sm text-muted">None yet.</p>}
          </Card>
        </div>
      </div>
    </div>
  );
}
