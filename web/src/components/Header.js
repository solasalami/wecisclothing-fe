"use client";
import Link from "next/link";
import Image from "next/image";
import { useState } from "react";
import { usePathname, useRouter } from "next/navigation";
import { useCart } from "./CartProvider";
import { BagIcon, MenuIcon, CloseIcon, UserIcon, SearchIcon, PhoneIcon, WhatsAppIcon } from "./icons";
import { telLink, whatsappLink } from "@/lib/format";

export default function Header({ categories, store, campaign }) {
  const { count, ready, setDrawerOpen } = useCart();
  const [open, setOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const pathname = usePathname();
  const router = useRouter();


  const nav = [
    ...categories.filter((c) => c.show_in_menu).map((c) => ({ href: `/category/${c.slug}`, label: c.name, children: c.children.filter((x) => x.show_in_menu && x.count > 0) })),
    ...(campaign.enabled ? [{ href: `/${campaign.slug}`, label: "Detty December", festive: true, children: [] }] : []),
    { href: "/shop", label: "Shop All", children: [] },
    { href: "/contact", label: "Showrooms", children: [] },
  ];

  function onSearch(e) {
    e.preventDefault();
    const q = new FormData(e.currentTarget).get("q");
    setSearchOpen(false);
    router.push(`/shop?q=${encodeURIComponent(q || "")}`);
  }

  return (
    <header className="sticky top-0 z-40 bg-white shadow-sm">
      {/* Contact bar */}
      <div className="bg-ink text-xs text-white">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-3 px-4 py-2">
          <div className="flex items-center gap-4">
            <a href={telLink(store.phone)} data-track-location="top_bar" className="flex items-center gap-1.5 hover:text-brand">
              <PhoneIcon width={14} height={14} /> <span>{store.phone}</span>
            </a>
            <a
              href={whatsappLink(store.whatsapp, store.whatsapp_message)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="top_bar"
              className="flex items-center gap-1.5 text-whatsapp hover:brightness-110"
            >
              <WhatsAppIcon width={14} height={14} /> <span className="hidden sm:inline">WhatsApp us</span>
            </a>
          </div>
          <Link href="/contact" className="hidden hover:text-brand md:block">
            Showrooms: Ikeja &amp; Victoria Island, Lagos
          </Link>
        </div>
      </div>

      {campaign.enabled && campaign.show_announcement && campaign.announcement && (
        <Link href={`/${campaign.slug}`} className="block bg-festive px-4 py-2 text-center text-xs font-medium text-black sm:text-sm">
          ✨ {campaign.announcement} <span className="underline">Shop now</span>
        </Link>
      )}

      <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-3">
        <button className="p-1 lg:hidden" onClick={() => setOpen(true)} aria-label="Open menu">
          <MenuIcon />
        </button>

        <Link href="/" className="flex items-center gap-2" aria-label="Wecis Clothing home">
          <Image src="/logo.png" alt="Wecis Clothing" width={56} height={54} priority className="h-12 w-auto" />
          <span className="hidden font-display text-xl tracking-wide sm:inline">WECIS CLOTHING</span>
        </Link>

        <nav className="hidden items-center gap-6 lg:flex">
          {nav.map((item) => (
            <div key={item.href} className="group relative">
              <Link
                href={item.href}
                className={`py-4 text-sm font-medium uppercase tracking-wider transition hover:text-brand-dark ${
                  item.festive ? "text-festive-dark" : ""
                } ${pathname === item.href ? "text-brand-dark" : ""}`}
              >
                {item.label}
              </Link>
              {item.children?.length > 0 && (
                <div className="invisible absolute left-0 top-full min-w-56 border border-line bg-white py-2 opacity-0 shadow-lg transition group-hover:visible group-hover:opacity-100">
                  {item.children.map((c) => (
                    <Link key={c.slug} href={`/category/${c.slug}`} className="block px-4 py-2 text-sm hover:bg-soft hover:text-brand-dark">
                      {c.name}
                    </Link>
                  ))}
                </div>
              )}
            </div>
          ))}
        </nav>

        <div className="flex items-center gap-3">
          <button onClick={() => setSearchOpen((v) => !v)} aria-label="Search" className="p-1 hover:text-brand-dark">
            <SearchIcon />
          </button>
          <Link href="/account" aria-label="My account" className="hidden p-1 hover:text-brand-dark sm:block">
            <UserIcon />
          </Link>
          <button onClick={() => setDrawerOpen(true)} aria-label="Open cart" className="relative p-1 hover:text-brand-dark">
            <BagIcon />
            {ready && count > 0 && (
              <span className="absolute -right-1 -top-1 flex h-5 min-w-5 items-center justify-center rounded-full bg-brand px-1 text-[11px] font-bold text-ink">
                {count}
              </span>
            )}
          </button>
        </div>
      </div>

      {searchOpen && (
        <form onSubmit={onSearch} className="border-t border-line bg-white px-4 py-3">
          <div className="mx-auto flex max-w-3xl gap-2">
            <input name="q" autoFocus placeholder="Search agbada, adire, kaftan…" className="input" />
            <button className="btn-primary">Search</button>
          </div>
        </form>
      )}

      {/* Mobile drawer */}
      {open && (
        <div className="fixed inset-0 z-50 lg:hidden">
          <div className="absolute inset-0 bg-black/40" onClick={() => setOpen(false)} />
          <div
            className="absolute left-0 top-0 h-full w-80 max-w-[85%] overflow-y-auto bg-white p-5"
            onClick={(e) => e.target.closest("a") && setOpen(false)}
          >
            <div className="mb-6 flex items-center justify-between">
              <span className="font-display text-xl">Menu</span>
              <button onClick={() => setOpen(false)} aria-label="Close menu">
                <CloseIcon />
              </button>
            </div>
            <nav className="space-y-1">
              {nav.map((item) => (
                <div key={item.href} className="border-b border-line py-2">
                  <Link href={item.href} className={`block py-1 font-medium uppercase tracking-wider ${item.festive ? "text-festive-dark" : ""}`}>
                    {item.label}
                  </Link>
                  {item.children?.length > 0 && (
                    <div className="mt-1 grid grid-cols-2 gap-x-3 pl-2">
                      {item.children.map((c) => (
                        <Link key={c.slug} href={`/category/${c.slug}`} className="py-1 text-sm text-muted">
                          {c.name}
                        </Link>
                      ))}
                    </div>
                  )}
                </div>
              ))}
              <Link href="/account" className="block py-3 font-medium uppercase tracking-wider">
                My Account
              </Link>
            </nav>
            <div className="mt-6 space-y-3">
              <a href={telLink(store.phone)} data-track-location="mobile_menu" className="btn-outline w-full">
                <PhoneIcon width={18} height={18} /> Call {store.phone}
              </a>
              <a
                href={whatsappLink(store.whatsapp, store.whatsapp_message)}
                target="_blank"
                rel="noopener noreferrer"
                data-track-location="mobile_menu"
                className="btn-whatsapp w-full"
              >
                <WhatsAppIcon width={18} height={18} /> WhatsApp
              </a>
            </div>
          </div>
        </div>
      )}
    </header>
  );
}
