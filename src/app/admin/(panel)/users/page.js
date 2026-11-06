import Link from "next/link";
import { requireOwner } from "@/lib/auth";
import { query } from "@/lib/db";
import { formatDate } from "@/lib/format";
import { ActionForm, SubmitButton } from "@/components/admin/Form";
import { Field, Check, Card, PageHeader, Badge } from "@/components/admin/Fields";
import { saveAdminUser } from "@/app/admin/actions";

export const metadata = { title: "Admin users" };

export default async function UsersAdmin({ searchParams }) {
  await requireOwner();
  const { edit, saved } = await searchParams;
  const users = await query("SELECT id, name, email, role, is_active, last_login_at FROM admin_users ORDER BY id");
  const current = edit ? users.find((u) => u.id === Number(edit)) : null;
  return (
    <div>
      <PageHeader title="Admin users" />
      {saved && <p className="mb-4 border border-green-200 bg-green-50 p-3 text-sm text-green-700">Saved.</p>}
      <div className="grid gap-6 lg:grid-cols-[1fr_380px]">
        <div className="border border-line bg-white">
          {users.map((u) => (
            <div key={u.id} className="flex items-center justify-between border-b border-line p-3 text-sm">
              <div>
                <Link href={`/admin/users?edit=${u.id}`} className="font-medium underline">{u.name}</Link>
                <p className="text-xs text-muted">{u.email} · last login {u.last_login_at ? formatDate(u.last_login_at) : "never"}</p>
              </div>
              <span className="space-x-1"><Badge tone={u.role === "owner" ? "blue" : "gray"}>{u.role}</Badge>{!u.is_active && <Badge tone="red">Disabled</Badge>}</span>
            </div>
          ))}
        </div>
        <Card title={current ? `Edit ${current.name}` : "New admin user"} actions={current && <Link href="/admin/users" className="text-xs underline">+ New instead</Link>}>
          <ActionForm action={saveAdminUser} className="space-y-4" key={current?.id || "new"}>
            <input type="hidden" name="id" value={current?.id || ""} />
            <Field label="Name" name="name" defaultValue={current?.name} required />
            <Field label="Email" name="email" type="email" defaultValue={current?.email} required />
            <div>
              <label className="label" htmlFor="role">Role</label>
              <select id="role" name="role" defaultValue={current?.role || "staff"} className="input">
                <option value="staff">Staff: products, orders, content</option>
                <option value="owner">Owner: everything incl. settings & users</option>
              </select>
            </div>
            <Field label={current ? "New password (leave blank to keep)" : "Password (10+ characters)"} name="password" type="password" autoComplete="new-password" />
            <Check label="Active" name="is_active" defaultChecked={current ? current.is_active : true} />
            <SubmitButton className="btn-primary w-full" />
          </ActionForm>
        </Card>
      </div>
    </div>
  );
}
