"use server";
import { z } from "zod";
import { redirect } from "next/navigation";
import { query, queryOne } from "@/lib/db";
import { revalidatePath } from "next/cache";
import { hashPassword, checkPassword, startCustomerSession, endCustomerSession, getCustomer } from "@/lib/auth";
import { sendVerificationEmail, saveAddress as saveAddr, deleteAddress as deleteAddr, setDefaultAddress } from "@/lib/customers";
import { NG_STATES } from "@/lib/ng-states";

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
  // Earlier guest orders are attached once the customer confirms this email (see lib/customers.js).
  await sendVerificationEmail({ id, first_name: d.first_name, email: d.email });
  await startCustomerSession({ id });
  redirect("/account?welcome=1");
}

export async function logoutCustomer() {
  await endCustomerSession();
  redirect("/");
}

async function requireCustomer() {
  const c = await getCustomer();
  if (!c) redirect("/account");
  return c;
}

export async function resendVerification() {
  const c = await requireCustomer();
  if (c.email_verified_at) return { ok: "Your email is already confirmed." };
  const res = await sendVerificationEmail(c);
  return res.ok
    ? { ok: `We've sent a confirmation link to ${c.email}. Check your inbox and spam folder.` }
    : { error: "We couldn't send the email right now. Please try again later or contact us on WhatsApp." };
}

const addressSchema = z.object({
  label: z.string().trim().max(40).optional().default(""),
  address_line: z.string().trim().min(3, "Enter the street address").max(255),
  city: z.string().trim().min(2, "Enter the city or area").max(100),
  state: z.enum(NG_STATES, { message: "Choose a state" }),
  phone: z.string().trim().max(40).optional().default(""),
});

export async function saveAddress(_prev, formData) {
  const c = await requireCustomer();
  const parsed = addressSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const res = await saveAddr(c.id, { ...parsed.data, is_default: formData.get("is_default") === "on" }, Number(formData.get("id")) || 0);
  if (res.error) return { error: res.error };
  revalidatePath("/account");
  return { ok: "Address saved", savedAt: Date.now() };
}

export async function deleteAddress(formData) {
  const c = await requireCustomer();
  await deleteAddr(c.id, Number(formData.get("id")) || 0);
  revalidatePath("/account");
}

export async function makeDefaultAddress(formData) {
  const c = await requireCustomer();
  await setDefaultAddress(c.id, Number(formData.get("id")) || 0);
  revalidatePath("/account");
}
