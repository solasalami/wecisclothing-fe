"use client";
import Link from "next/link";
import { useActionState } from "react";
import { loginCustomer, registerCustomer } from "@/app/actions/account";

export function LoginForm() {
  const [state, action, pending] = useActionState(loginCustomer, null);
  return (
    <form action={action} className="space-y-4">
      <div><label className="label" htmlFor="email">Email</label><input id="email" name="email" type="email" className="input" required autoComplete="email" /></div>
      <div><label className="label" htmlFor="password">Password</label><input id="password" name="password" type="password" className="input" required autoComplete="current-password" /></div>
      {state?.error && <p className="text-sm text-red-600">{state.error}</p>}
      <button className="btn-primary w-full" disabled={pending}>{pending ? "Signing in…" : "Sign in"}</button>
      <p className="text-center text-sm">New here? <Link href="/account/register" className="underline">Create an account</Link></p>
    </form>
  );
}

export function RegisterForm() {
  const [state, action, pending] = useActionState(registerCustomer, null);
  return (
    <form action={action} className="grid gap-4 sm:grid-cols-2">
      <div><label className="label" htmlFor="first_name">First name</label><input id="first_name" name="first_name" className="input" required /></div>
      <div><label className="label" htmlFor="last_name">Last name</label><input id="last_name" name="last_name" className="input" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="email">Email</label><input id="email" name="email" type="email" className="input" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="phone">Phone</label><input id="phone" name="phone" type="tel" className="input" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="password">Password (min 8 characters)</label><input id="password" name="password" type="password" minLength={8} className="input" required autoComplete="new-password" /></div>
      {state?.error && <p className="text-sm text-red-600 sm:col-span-2">{state.error}</p>}
      <button className="btn-primary sm:col-span-2" disabled={pending}>{pending ? "Creating…" : "Create account"}</button>
      <p className="text-center text-sm sm:col-span-2">Already have an account? <Link href="/account" className="underline">Sign in</Link></p>
    </form>
  );
}
