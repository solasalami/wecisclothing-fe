"use client";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";
import { adminLogout } from "@/app/admin/actions";

const LINKS = [
  ["/admin", "Dashboard"],
  ["/admin/orders", "Orders"],
  ["/admin/products", "Products"],
  ["/admin/detty-december", "Detty December", true],
  ["/admin/categories", "Categories"],
  ["/admin/customers", "Customers"],
  ["/admin/banners", "Home banners"],
  ["/admin/showrooms", "Showrooms"],
  ["/admin/pages", "Info pages"],
  ["/admin/settings", "Settings", false, "owner"],
  ["/admin/users", "Admin users", false, "owner"],
  ["/admin/account", "My password"],
];

export default function AdminNav({ admin }) {
  const pathname = usePathname();
  const [open, setOpen] = useState(false);
  const active = (href) => (href === "/admin" ? pathname === "/admin" : pathname.startsWith(href));
  return (
    <aside className="bg-ink text-white lg:min-h-screen lg:w-60 lg:flex-none">
      <div className="flex items-center justify-between p-4 lg:block">
        <Link href="/admin" className="font-display text-xl">Wecis Admin</Link>
        <button className="lg:hidden" onClick={() => setOpen((v) => !v)} aria-label="Toggle menu">☰</button>
      </div>
      <nav className={`${open ? "block" : "hidden"} pb-4 lg:block`}>
        {LINKS.filter(([, , , role]) => !role || admin.role === role).map(([href, label, festive]) => (
          <Link
            key={href}
            href={href}
            onClick={() => setOpen(false)}
            className={`block px-4 py-2 text-sm ${active(href) ? "bg-white/10 text-brand" : "text-white/80 hover:bg-white/5"} ${festive ? "text-festive" : ""}`}
          >
            {label}
          </Link>
        ))}
        <div className="mt-6 border-t border-white/10 px-4 pt-4 text-xs text-white/60">
          <p>{admin.name}</p>
          <p className="capitalize">{admin.role}</p>
          <div className="mt-3 flex gap-3">
            <Link href="/" target="_blank" className="underline">View shop</Link>
            <form action={adminLogout}><button className="underline">Sign out</button></form>
          </div>
        </div>
      </nav>
    </aside>
  );
}
