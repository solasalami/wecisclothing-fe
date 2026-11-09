"use server";
import { z } from "zod";
import { redirect } from "next/navigation";
import { query, queryOne } from "@/lib/db";
import { revalidatePath } from "next/cache";
import { hashPassword, checkPassword, startCustomerSession, endCustomerSession, getCustomer } from "@/lib/auth";
import { sendVerificationEmail, saveAddress as saveAddr, deleteAddress as deleteAddr, setDefaultAddress } from "@/lib/customers";
import { NG_STATES } from "@/lib/ng-states";
import { createChallenge, checkHuman } from "@/lib/captcha";

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

/** Create-account action. Every reply carries a new spam-check question, since each works once. */
export async function registerCustomer(_prev, formData) {
  const challenge = await createChallenge("register");
  // Typed values come back so the form can keep them (never the password).
  const values = Object.fromEntries(["first_name", "last_name", "email", "phone"].map((k) => [k, String(formData.get(k) ?? "")]));
  const fail = (error) => ({ error, challenge, values });

  const parsed = registerSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return fail(parsed.error.issues[0].message);
  const d = parsed.data;

  const human = await checkHuman("register", { token: formData.get("token"), answer: formData.get("answer"), website: formData.get("website") });
  // Bots get a vague reply and no account, so they don't learn what tripped them.
  if (human.error === "spam") return fail("We couldn't create your account. Please try again.");
  if (human.error) return fail(human.error);

  const existing = await queryOne("SELECT id FROM customers WHERE email = ?", [d.email]);
  if (existing) return fail("An account with this email already exists. Please sign in.");
  let res;
  try {
    res = await query("INSERT INTO customers (first_name, last_name, email, phone, password_hash, signup_nonce) VALUES (?,?,?,?,?,?)", [
      d.first_name, d.last_name, d.email, d.phone, await hashPassword(d.password), human.nonce,
    ]);
  } catch (err) {
    if (err?.code !== "ER_DUP_ENTRY") throw err;
    return /signup_nonce/.test(err.sqlMessage || "")
      ? fail("This form was already used. Please answer the new question and try again.")
      : fail("An account with this email already exists. Please sign in.");
  }
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
