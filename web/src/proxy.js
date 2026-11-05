import { NextResponse } from "next/server";
import { jwtVerify } from "jose";

// Optimistic gate for /admin. Every admin page and action re-checks the session
// against the database (requireAdmin) — this only avoids rendering for strangers.
export async function proxy(request) {
  const { pathname } = request.nextUrl;
  if (pathname === "/admin/login") return NextResponse.next();
  const token = request.cookies.get("wecis_admin")?.value;
  try {
    if (!token) throw new Error("no token");
    const { payload } = await jwtVerify(token, new TextEncoder().encode(process.env.AUTH_SECRET));
    if (payload.kind !== "admin") throw new Error("bad kind");
    return NextResponse.next();
  } catch {
    const url = request.nextUrl.clone();
    url.pathname = "/admin/login";
    url.search = "";
    return NextResponse.redirect(url);
  }
}

export const config = { matcher: ["/admin", "/admin/:path*"] };
