"use server";
import { z } from "zod";
import { redirect } from "next/navigation";
import { query, queryOne } from "@/lib/db";
import { hashPassword, checkPassword, startCustomerSession, endCustomerSession } from "@/lib/auth";

export async function loginCustomer(_prev, formData) {
  const email = String(formData.get("email") || "").trim().toLowerCase();
  const password = String(formData.get("password") || "");
  const c = await queryOne("SELECT id, password_hash FROM customers WHERE email = ? AND is_active = 1", [email]);
  if (!c || !(await checkPassword(password, c.password_hash))) return { error: "Incorrect email or password" };
  await startCustomerSession(c);
  redirect("/account");
}

const registerSchema = z.object({
  first_name: z.string().trim().min(1).max(80),
  last_name: z.string().trim().min(1).max(80),
  email: z.string().trim().toLowerCase().email(),
  phone: z.string().trim().min(7).max(40),
  password: z.string().min(8, "Password must be at least 8 characters").max(100),
});

export async function registerCustomer(_prev, formData) {
  const parsed = registerSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const d = parsed.data;
  const existing = await queryOne("SELECT id FROM customers WHERE email = ?", [d.email]);
  if (existing) return { error: "An account with this email already exists. Please sign in." };
  const res = await query("INSERT INTO customers (first_name, last_name, email, phone, password_hash) VALUES (?,?,?,?,?)", [
    d.first_name, d.last_name, d.email, d.phone, await hashPassword(d.password),
  ]);
  const id = res.insertId;
  // Note: earlier guest orders are NOT auto-attached by email (email is unverified).
  await startCustomerSession({ id });
  redirect("/account");
}

export async function logoutCustomer() {
  await endCustomerSession();
  redirect("/");
}
