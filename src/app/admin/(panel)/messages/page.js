import { query } from "@/lib/db";
import { requireAdmin } from "@/lib/auth";
import { formatDate, whatsappLink } from "@/lib/format";
import { PageHeader, Badge } from "@/components/admin/Fields";
import { ActionForm, SubmitButton, ConfirmButton } from "@/components/admin/Form";
import { tableParams, dateRangeSql } from "@/lib/admin-table";
import { SortHeader, Pagination, KeepTableState, TableToolbar, DateRangeFields } from "@/components/admin/TableControls";
import { TOPICS, storeMailbox } from "@/lib/contact";
import { getSetting } from "@/lib/settings";
import { emailEnabled } from "@/lib/email";
import { setMessageRead, deleteMessage, replyToMessage } from "@/app/admin/actions";

export const metadata = { title: "Messages" };

const BASE = "/admin/messages";

export default async function MessagesAdmin({ searchParams }) {
  await requireAdmin();
  const sp = await searchParams;
  const where = ["1=1"];
  const params = [];
  if (sp.q) {
    where.push("(name LIKE ? OR email LIKE ? OR phone LIKE ? OR message LIKE ?)");
    params.push(...Array(4).fill(`%${sp.q}%`));
  }
  if (TOPICS.includes(sp.topic)) { where.push("topic = ?"); params.push(sp.topic); }
  if (sp.status === "unread") where.push("read_at IS NULL");
  if (sp.status === "read") where.push("read_at IS NOT NULL");
  const dates = dateRangeSql(sp, "created_at");
  where.push(...dates.where);
  params.push(...dates.params);
  const table = tableParams(sp, { sorts: { date: "created_at" }, fallback: "read_at IS NOT NULL, id DESC" });
  const [rows, [{ total }]] = await Promise.all([
    query(`SELECT id, name, email, phone, topic, message, read_at, created_at FROM contact_messages WHERE ${where.join(" AND ")} ORDER BY ${table.orderBy} LIMIT ? OFFSET ?`, [...params, table.per, table.offset]),
    query(`SELECT COUNT(*) total FROM contact_messages WHERE ${where.join(" AND ")}`, params),
  ]);
  const ids = rows.map((m) => m.id);
  const [replies, store] = await Promise.all([
    ids.length ? query(`SELECT id, message_id, body, sent_by, copied_to, created_at FROM contact_replies WHERE message_id IN (${ids.map(() => "?").join(",")}) ORDER BY created_at`, ids) : [],
    getSetting("store"),
  ]);
  const repliesFor = (id) => replies.filter((r) => r.message_id === id);
  const mailbox = storeMailbox(store);
  const canEmail = emailEnabled();
  const back = `${BASE}?${new URLSearchParams(Object.entries(sp).filter(([, v]) => typeof v === "string")).toString()}`;

  return (
    <div>
      <PageHeader title="Messages" />
      <p className="mb-4 max-w-3xl text-sm text-muted">
        Messages from the Contact us page. Each one is also emailed to the store (ADMIN_EMAIL). Reply here and the customer gets your answer by email{mailbox ? <>, with a copy sent to <strong>{mailbox}</strong> so the conversation is in the mailbox too</> : ""}. Their reply comes back to that mailbox.
      </p>
      {!canEmail && (
        <p className="mb-4 max-w-3xl border border-yellow-200 bg-yellow-50 p-3 text-sm text-yellow-800">
          Email sending is off (SEND_EMAIL and SMTP settings), so replies can&apos;t be sent from here yet.
        </p>
      )}
      <form className="mb-4 flex flex-wrap items-end gap-2">
        <input name="q" defaultValue={sp.q || ""} placeholder="Name, email, phone or text" className="input max-w-xs" />
        <select name="topic" defaultValue={sp.topic || ""} className="input max-w-52">
          <option value="">Any topic</option>
          {TOPICS.map((t) => <option key={t}>{t}</option>)}
        </select>
        <select name="status" defaultValue={sp.status || ""} className="input max-w-36">
          <option value="">Read and unread</option><option value="unread">Unread</option><option value="read">Read</option>
        </select>
        <DateRangeFields basePath={BASE} sp={sp} label="Received" />
        <KeepTableState table={table} />
        <button className="btn-outline !py-2">Filter</button>
      </form>
      <div className="overflow-x-auto border border-line bg-white">
        <TableToolbar basePath={BASE} sp={sp} table={table} total={Number(total)} />
        <table className="w-full text-left text-sm">
          <thead className="border-b border-line bg-soft text-xs uppercase text-muted">
            <tr><th className="p-3">From</th><th>Topic</th><th>Message</th><SortHeader label="Received" column="date" basePath={BASE} sp={sp} table={table} /><th></th></tr>
          </thead>
          <tbody>
            {rows.map((m) => (
              <tr key={m.id} className={`border-b border-line align-top ${m.read_at ? "" : "bg-gold-light/30"}`}>
                <td className="p-3">
                  <span className="font-medium">{m.name}</span>
                  {!m.read_at && <Badge tone="gold">New</Badge>}
                  <a href={`mailto:${m.email}?subject=${encodeURIComponent(`Re: ${m.topic}`)}`} className="block underline">{m.email}</a>
                  {m.phone && <a href={whatsappLink(m.phone, `Hello ${m.name}, this is Wecis Clothing replying to your message.`)} target="_blank" rel="noopener noreferrer" className="block text-xs underline">{m.phone} (WhatsApp)</a>}
                </td>
                <td className="whitespace-nowrap pr-3">{m.topic}</td>
                <td className="max-w-xl py-3 pr-3">
                  <p className="whitespace-pre-wrap">{m.message}</p>
                  {repliesFor(m.id).map((r) => (
                    <div key={r.id} className="mt-3 border-l-2 border-gold bg-soft p-3">
                      <p className="mb-1 text-xs text-muted">
                        Replied {formatDate(r.created_at)}{r.sent_by ? ` by ${r.sent_by}` : ""}{r.copied_to ? ` (copy in ${r.copied_to})` : ""}
                      </p>
                      <p className="whitespace-pre-wrap">{r.body}</p>
                    </div>
                  ))}
                  {canEmail && (
                    <details className="mt-3">
                      <summary className="cursor-pointer text-xs font-medium underline">{repliesFor(m.id).length ? "Reply again" : "Reply"}</summary>
                      <ActionForm action={replyToMessage} className="mt-2 space-y-2">
                        <input type="hidden" name="id" value={m.id} />
                        <p className="text-xs text-muted">To {m.email}. Starts with &ldquo;Hello {m.name},&rdquo; and quotes their message below your reply.</p>
                        <textarea name="body" rows={5} required minLength={2} maxLength={10000} className="input" placeholder="Write your reply…" />
                        <SubmitButton className="btn-primary !py-2" pendingText="Sending…">Send reply</SubmitButton>
                      </ActionForm>
                    </details>
                  )}
                </td>
                <td className="whitespace-nowrap pr-3">{formatDate(m.created_at)}</td>
                <td className="space-y-2 pr-3 text-right text-xs">
                  <form action={setMessageRead}>
                    <input type="hidden" name="id" value={m.id} />
                    <input type="hidden" name="read" value={m.read_at ? "0" : "1"} />
                    <input type="hidden" name="back" value={back} />
                    <button className="underline">{m.read_at ? "Mark unread" : "Mark read"}</button>
                  </form>
                  <form action={deleteMessage}>
                    <input type="hidden" name="id" value={m.id} />
                    <input type="hidden" name="back" value={back} />
                    <ConfirmButton message="Delete this message permanently?" className="text-red-600 underline">Delete</ConfirmButton>
                  </form>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!rows.length && <p className="p-6 text-center text-muted">No messages{sp.q || sp.topic || sp.status || sp.from || sp.to ? " match" : " yet"}.</p>}
        <Pagination basePath={BASE} sp={sp} table={table} total={Number(total)} />
      </div>
    </div>
  );
}
