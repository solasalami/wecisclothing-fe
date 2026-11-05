import { requireAdmin } from "@/lib/auth";
import AdminNav from "@/components/admin/AdminNav";

export const dynamic = "force-dynamic";
export const metadata = { title: { default: "Admin", template: "%s · Wecis Admin" }, robots: { index: false } };

export default async function AdminLayout({ children }) {
  const admin = await requireAdmin();
  return (
    <div className="min-h-screen bg-soft lg:flex">
      <AdminNav admin={admin} />
      <div className="flex-1 overflow-x-hidden p-4 md:p-8">{children}</div>
    </div>
  );
}
