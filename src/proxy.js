import { NextResponse } from "next/server";
import { jwtVerify } from "jose";

// 1. Tags every page request with its path (x-wecis-path) so that, if the
//    database goes down, the maintenance page can send visitors back afterwards.
// 2. Optimistic gate for /admin. Every admin page and action still re-checks
//    the session against the database (requireAdmin).
export async function proxy(request) {
  const { pathname, search } = request.nextUrl;

  // Old OpenCart links like "/?route=product/product&product_id=5" go to the
  // legacy redirect handler (app/index.php/route.js).
  if (pathname === "/" && request.nextUrl.searchParams.has("route")) {
    const url = request.nextUrl.clone();
    url.pathname = "/index.php";
    return NextResponse.rewrite(url);
  }

  if (pathname.startsWith("/admin") && pathname !== "/admin/login") {
    const token = request.cookies.get("wecis_admin")?.value;
    let ok = false;
    try {
      if (token) {
        const { payload } = await jwtVerify(token, new TextEncoder().encode(process.env.AUTH_SECRET));
        ok = payload.kind === "admin";
      }
    } catch {
      ok = false;
    }
    if (!ok) {
      const url = request.nextUrl.clone();
      url.pathname = "/admin/login";
      url.search = "";
      return NextResponse.redirect(url);
    }
  }

  const requestHeaders = new Headers(request.headers);
  requestHeaders.set("x-wecis-path", `${pathname}${search}`.slice(0, 500));
  return NextResponse.next({ request: { headers: requestHeaders } });
}

export const config = {
  // Pages only: skip static assets, images, uploads, health checks and webhooks.
  matcher: ["/((?!_next/|media/|api/|maintenance|favicon.ico|icon.png|logo.png|robots.txt|sitemap.xml).*)"],
};
