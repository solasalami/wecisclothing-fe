"use client";
import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { useState } from "react";
import { adminLogout } from "@/app/admin/actions";

const LINKS = [
  ["/admin", "Dashboard"],
  ["/admin/orders", "Orders"],
  ["/admin/products", "Products"],
  ["/admin/campaign", "Seasonal campaign", true],
  ["/admin/categories", "Categories"],
  ["/admin/customers", "Customers"],
  ["/admin/banners", "Home banners"],
  ["/admin/showrooms", "Showrooms"],
  ["/admin/pages", "Info pages"],
  ["/admin/go-live", "Go-live checklist"],
  ["/admin/settings", "Settings", false, "owner"],
  ["/admin/users", "Admin users", false, "owner"],
  ["/admin/account", "My password"],
];

export default function AdminNav({ admin }) {
  const pathname = usePathname();
  const [open, setOpen] = useState(false);
  const active = (href) => (href === "/admin" ? pathname === "/admin" : pathname.startsWith(href));
  return (
    <aside className="bg-logo-blue text-white lg:min-h-screen lg:w-60 lg:flex-none">
      <div className="flex items-center justify-between p-4 lg:block">
        <Link href="/admin" className="flex items-center gap-3 lg:flex-col lg:items-start lg:gap-2" aria-label="Wecis Admin dashboard">
          <Image src="/logo.png" alt="Wecis Clothing" width={64} height={62} priority className="h-10 w-auto rounded-full bg-white lg:h-16" />
          <span className="font-display text-xl font-semibold">Wecis Admin</span>
        </Link>
        <button className="lg:hidden" onClick={() => setOpen((v) => !v)} aria-label="Toggle menu">☰</button>
      </div>
      <nav className={`${open ? "block" : "hidden"} pb-4 lg:block`}>
        {LINKS.filter(([, , , role]) => !role || admin.role === role).map(([href, label, festive]) => (
          <Link
            key={href}
            href={href}
            onClick={() => setOpen(false)}
            aria-current={active(href) ? "page" : undefined}
            className={`group flex items-center gap-2 border-l-[3px] px-4 py-2 text-sm font-semibold text-white transition ${
              active(href) ? "border-white bg-gold font-bold" : "border-transparent hover:border-white/40 hover:bg-white/15"
            }`}
          >
            {label}
            {festive && (
              <span className={`h-1.5 w-1.5 rounded-full ${active(href) ? "bg-white" : "bg-gold"}`} aria-hidden="true" />
            )}
          </Link>
        ))}
        <div className="mt-6 border-t border-white/25 px-4 pt-4 text-xs font-semibold text-white">
          <p>{admin.name}</p>
          <p className="capitalize">{admin.role}</p>
          <div className="mt-3 flex gap-3">
            <Link href="/" target="_blank" className="underline decoration-white/50 hover:decoration-white">View shop</Link>
            <form action={adminLogout}><button className="underline decoration-white/50 hover:decoration-white">Sign out</button></form>
          </div>
        </div>
      </nav>
    </aside>
  );
}
