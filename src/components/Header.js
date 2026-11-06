"use client";
import Link from "next/link";
import Image from "next/image";
import { useState } from "react";
import { usePathname, useRouter } from "next/navigation";
import { useCart } from "./CartProvider";
import { BagIcon, MenuIcon, CloseIcon, UserIcon, SearchIcon, PhoneIcon, WhatsAppIcon } from "./icons";
import { telLink, whatsappLink } from "@/lib/format";
import { isCampaignLive } from "@/lib/campaign";
import Marquee from "./Marquee";

export default function Header({ categories, store, campaign, account }) {
  const campaignLive = isCampaignLive(campaign);
  const { count, ready, setDrawerOpen } = useCart();
  const [open, setOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const pathname = usePathname();
  const router = useRouter();


  const nav = [
    ...categories.filter((c) => c.show_in_menu).map((c) => ({ href: `/category/${c.slug}`, label: c.name, children: c.children.filter((x) => x.show_in_menu && x.count > 0) })),
    ...(campaignLive ? [{ href: `/${campaign.slug}`, label: campaign.name, festive: true, children: [] }] : []),
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
      {/* Single champagne utility bar: contact · campaign announcement · showrooms */}
      <div className="border-b border-gold/30 bg-gold-light text-[11px] tracking-[0.08em] text-ink sm:text-xs">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-3 px-4 py-2">
          <div className="flex flex-none items-center gap-3 sm:gap-4">
            <a href={telLink(store.phone)} data-track-location="top_bar" aria-label={`Call ${store.phone}`} className="flex items-center gap-1.5 hover:text-gold-dark">
              <PhoneIcon width={14} height={14} /> <span className="hidden sm:inline">{store.phone}</span>
            </a>
            <a
              href={whatsappLink(store.whatsapp, store.whatsapp_message)}
              target="_blank"
              rel="noopener noreferrer"
              data-track-location="top_bar"
              aria-label="WhatsApp us"
              className="flex items-center gap-1.5 hover:text-gold-dark"
            >
              <WhatsAppIcon width={14} height={14} className="text-whatsapp" /> <span className="hidden lg:inline">WhatsApp us</span>
            </a>
          </div>
          {campaignLive && campaign.show_announcement && campaign.announcement ? (
            <Marquee href={`/${campaign.slug}`} className="mx-2 min-w-0 flex-1 font-medium hover:text-gold-dark">
              <span className="mr-2 text-gold-dark">✦</span>
              {campaign.announcement}
              <span className="ml-2 underline underline-offset-2">Shop now</span>
            </Marquee>
          ) : (
            <span className="flex-1" />
          )}
          <Link href="/contact" className="hidden flex-none hover:text-gold-dark xl:block">
            Showrooms: Ikeja &amp; Victoria Island
          </Link>
        </div>
      </div>

      <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-3">
        <button className="p-1 lg:hidden" onClick={() => setOpen(true)} aria-label="Open menu">
          <MenuIcon />
        </button>

        <Link href="/" className="flex items-center gap-2" aria-label="Wecis Clothing home">
          <Image src="/logo.png" alt="Wecis Clothing" width={56} height={54} priority className="h-12 w-auto" />
          <span className="hidden font-display text-2xl tracking-[0.12em] sm:inline">WECIS CLOTHING</span>
        </Link>

        <nav className="hidden items-center gap-6 lg:flex">
          {nav.map((item) => (
            <div key={item.href} className="group relative">
              <Link
                href={item.href}
                className={`py-4 text-xs font-medium uppercase tracking-[0.18em] transition hover:text-gold-dark ${
                  item.festive ? "text-gold-dark" : ""
                } ${pathname === item.href ? "text-gold-dark" : ""}`}
              >
                {item.label}
              </Link>
              {item.children?.length > 0 && (
                <div className="invisible absolute left-0 top-full min-w-56 border border-line bg-white py-2 opacity-0 shadow-lg transition group-hover:visible group-hover:opacity-100">
                  {item.children.map((c) => (
                    <Link key={c.slug} href={`/category/${c.slug}`} className="block px-4 py-2 text-sm hover:bg-soft hover:text-gold-dark">
                      {c.name}
                    </Link>
                  ))}
                </div>
              )}
            </div>
          ))}
        </nav>

        <div className="flex items-center gap-3">
          <button onClick={() => setSearchOpen((v) => !v)} aria-label="Search" className="p-1 hover:text-gold-dark">
            <SearchIcon />
          </button>
          {account ? (
            <Link
              href="/account"
              aria-label={`My account, signed in as ${account.firstName}`}
              title={`Signed in as ${account.firstName}`}
              className="relative hidden p-1 text-gold-dark hover:text-ink sm:block"
            >
              <span className="relative block">
                <UserIcon />
                <span className="absolute -bottom-0.5 -right-0.5 h-2.5 w-2.5 rounded-full border-2 border-white bg-gold" aria-hidden="true" />
              </span>
              {/* Sits under the icon without changing the header's height or the icons' alignment. */}
              <span className="absolute left-1/2 top-full mt-0.5 max-w-24 -translate-x-1/2 truncate whitespace-nowrap text-[10px] font-medium uppercase leading-none tracking-wider">
                Hi, {account.firstName}
              </span>
            </Link>
          ) : (
            <Link href="/account" aria-label="My account, sign in" title="Sign in" className="hidden p-1 hover:text-gold-dark sm:block">
              <UserIcon />
            </Link>
          )}
          <button onClick={() => setDrawerOpen(true)} aria-label="Open cart" className="relative p-1 hover:text-gold-dark">
            <BagIcon />
            {ready && count > 0 && (
              <span className="absolute -right-1 -top-1 flex h-5 min-w-5 items-center justify-center rounded-full bg-gold px-1 text-[11px] font-semibold text-ink">
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
                  <Link href={item.href} className={`block py-1 font-medium uppercase tracking-wider ${item.festive ? "text-gold-dark" : ""}`}>
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
              <Link href="/account" className={`block py-3 font-medium uppercase tracking-wider ${account ? "text-gold-dark" : ""}`}>
                {account ? `My Account · ${account.firstName}` : "Sign in / My Account"}
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
