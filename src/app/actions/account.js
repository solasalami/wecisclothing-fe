"use server";
import { z } from "zod";
import { redirect } from "next/navigation";
import { query, queryOne } from "@/lib/db";
import { revalidatePath } from "next/cache";
import { hashPassword, checkPassword, startCustomerSession, endCustomerSession, getCustomer } from "@/lib/auth";
import { sendVerificationEmail, sendPasswordResetEmail, resetPasswordWithToken, saveAddress as saveAddr, deleteAddress as deleteAddr, setDefaultAddress } from "@/lib/customers";
import { NG_STATES } from "@/lib/ng-states";
import { createChallenge, checkHuman } from "@/lib/captcha";

export async function loginCustomer(_prev, formData) {
  const email = String(formData.get("email") || "").trim().toLowerCase();
  const password = String(formData.get("password") || "");
  const c = await queryOne("SELECT id, password_hash, session_version, is_active FROM customers WHERE email = ?", [email]);
  if (!c || !(await checkPassword(password, c.password_hash))) return { error: "Incorrect email or password" };
  // Only told after the right password, so this doesn't reveal which emails have accounts.
  if (!c.is_active) return { error: "This account has been disabled. Please contact us if you think this is a mistake." };
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

// ---------- Passwords ----------

const newPasswordSchema = z
  .object({
    password: z.string().min(8, "Your new password must be at least 8 characters").max(100, "That password is too long"),
    confirm: z.string(),
  })
  .refine((d) => d.password === d.confirm, { message: "The two passwords don't match" });

/** Forgot password form (signed out). The reply is the same whether or not the email has an account. */
export async function requestPasswordReset(_prev, formData) {
  const challenge = await createChallenge("reset");
  const email = String(formData.get("email") || "").trim().toLowerCase();
  const fail = (error) => ({ error, challenge, email });
  if (!z.string().email().safeParse(email).success) return fail("Enter the email address you signed up with.");
  const human = await checkHuman("reset", { token: formData.get("token"), answer: formData.get("answer"), website: formData.get("website") });
  if (human.error && human.error !== "spam") return fail(human.error);
  if (!human.error) {
    const res = await sendPasswordResetEmail(email);
    if (res.sent && !res.ok) return fail("We couldn't send the email right now. Please try again later or contact us on WhatsApp.");
  }
  return {
    ok: `If there's an account for ${email}, we've sent it a link to reset your password. It works for 1 hour. Check your inbox and spam folder.`,
    challenge,
  };
}

/** Reset password page: sets the new password from the emailed link and signs the customer in. */
export async function resetPassword(_prev, formData) {
  const parsed = newPasswordSchema.safeParse({ password: formData.get("password"), confirm: formData.get("confirm") });
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  const customer = await resetPasswordWithToken(String(formData.get("token") || ""), parsed.data.password);
  if (!customer) return { error: "This reset link has expired or was already used. Please ask for a new one.", expired: true };
  await startCustomerSession(customer);
  redirect("/account?reset=1");
}

/** Account page: change the password while signed in. */
export async function changePassword(_prev, formData) {
  const c = await requireCustomer();
  const row = await queryOne("SELECT password_hash FROM customers WHERE id = ?", [c.id]);
  if (!(await checkPassword(String(formData.get("current") || ""), row.password_hash))) {
    return { error: "Your current password is incorrect. If you've forgotten it, email yourself a reset link below." };
  }
  const parsed = newPasswordSchema.safeParse({ password: formData.get("password"), confirm: formData.get("confirm") });
  if (!parsed.success) return { error: parsed.error.issues[0].message };
  // New password and a new session version: other devices are signed out, this one stays in.
  await query("UPDATE customers SET password_hash = ?, session_version = session_version + 1 WHERE id = ?", [await hashPassword(parsed.data.password), c.id]);
  await startCustomerSession({ id: c.id, session_version: Number(c.session_version) + 1 });
  return { ok: "Your password has been changed. Any other devices signed in to your account have been signed out.", savedAt: Date.now() };
}

/** Account page: email the signed-in customer a reset link (when they don't remember the current password). */
export async function emailMyResetLink() {
  const c = await requireCustomer();
  const res = await sendPasswordResetEmail(c.email);
  return res.ok
    ? { ok: `We've sent a reset link to ${c.email}. It works for 1 hour.` }
    : { error: "We couldn't send the email right now. Please try again later or contact us on WhatsApp." };
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
