import "server-only";
import { SignJWT, jwtVerify } from "jose";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import bcrypt from "bcryptjs";
import { queryOne } from "./db";

export const ADMIN_COOKIE = "wecis_admin";
export const CUSTOMER_COOKIE = "wecis_customer";

function secret() {
  const s = process.env.AUTH_SECRET;
  if (!s || s.length < 32) throw new Error("AUTH_SECRET must be set (32+ chars)");
  return new TextEncoder().encode(s);
}

export async function signToken(payload, maxAgeSeconds) {
  return new SignJWT(payload)
    .setProtectedHeader({ alg: "HS256" })
    .setIssuedAt()
    .setExpirationTime(`${maxAgeSeconds}s`)
    .sign(secret());
}

export async function verifyToken(token) {
  if (!token) return null;
  try {
    const { payload } = await jwtVerify(token, secret());
    return payload;
  } catch {
    return null;
  }
}

export const hashPassword = (pw) => bcrypt.hash(pw, 12);
export const checkPassword = (pw, hash) => (hash ? bcrypt.compare(pw, hash) : false);

async function setSession(name, payload, maxAge) {
  const token = await signToken(payload, maxAge);
  (await cookies()).set(name, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge,
  });
}

// ---------- Admin ----------
export async function startAdminSession(user) {
  await setSession(ADMIN_COOKIE, { sub: String(user.id), role: user.role, kind: "admin" }, 60 * 60 * 12);
}

export async function endAdminSession() {
  (await cookies()).delete(ADMIN_COOKIE);
}

/** Returns the logged-in admin (re-checked against the DB) or null. */
export async function getAdmin() {
  const payload = await verifyToken((await cookies()).get(ADMIN_COOKIE)?.value);
  if (payload?.kind !== "admin") return null;
  return queryOne("SELECT id, name, email, role FROM admin_users WHERE id = ? AND is_active = 1", [payload.sub]);
}

export async function requireAdmin() {
  const admin = await getAdmin();
  if (!admin) redirect("/admin/login");
  return admin;
}

export async function requireOwner() {
  const admin = await requireAdmin();
  if (admin.role !== "owner") redirect("/admin?error=forbidden");
  return admin;
}

// ---------- Customer ----------
export async function startCustomerSession(customer) {
  await setSession(CUSTOMER_COOKIE, { sub: String(customer.id), kind: "customer" }, 60 * 60 * 24 * 30);
}

export async function endCustomerSession() {
  (await cookies()).delete(CUSTOMER_COOKIE);
}

export async function getCustomer() {
  const payload = await verifyToken((await cookies()).get(CUSTOMER_COOKIE)?.value);
  if (payload?.kind !== "customer") return null;
  return queryOne(
    "SELECT id, first_name, last_name, email, phone, email_verified_at, created_at FROM customers WHERE id = ? AND is_active = 1",
    [payload.sub]
  );
}
