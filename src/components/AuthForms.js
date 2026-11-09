"use client";
import Link from "next/link";
import { useActionState } from "react";
import { loginCustomer, registerCustomer, requestPasswordReset, resetPassword } from "@/app/actions/account";

export function LoginForm() {
  const [state, action, pending] = useActionState(loginCustomer, null);
  return (
    <form action={action} className="space-y-4">
      <div><label className="label" htmlFor="email">Email</label><input id="email" name="email" type="email" className="input" required autoComplete="email" /></div>
      <div>
        <div className="flex items-baseline justify-between">
          <label className="label" htmlFor="password">Password</label>
          <Link href="/account/forgot-password" className="text-xs underline">Forgot your password?</Link>
        </div>
        <input id="password" name="password" type="password" className="input" required autoComplete="current-password" />
      </div>
      {state?.error && <p className="text-sm text-red-600">{state.error}</p>}
      <button className="btn-primary w-full" disabled={pending}>{pending ? "Signing in…" : "Sign in"}</button>
      <p className="text-center text-sm">New here? <Link href="/account/register" className="underline">Create an account</Link></p>
    </form>
  );
}

export function RegisterForm({ initialChallenge }) {
  const [state, action, pending] = useActionState(registerCustomer, null);
  const challenge = state?.challenge || initialChallenge;
  const v = state?.values || {};
  return (
    // key: remount after each reply so fields show the values returned by the server
    <form key={challenge.token} action={action} className="relative grid gap-4 sm:grid-cols-2">
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700 sm:col-span-2" role="alert">{state.error}</p>}
      <div><label className="label" htmlFor="first_name">First name</label><input id="first_name" name="first_name" className="input" defaultValue={v.first_name} autoComplete="given-name" required /></div>
      <div><label className="label" htmlFor="last_name">Last name</label><input id="last_name" name="last_name" className="input" defaultValue={v.last_name} autoComplete="family-name" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="email">Email</label><input id="email" name="email" type="email" className="input" defaultValue={v.email} autoComplete="email" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="phone">Phone</label><input id="phone" name="phone" type="tel" className="input" defaultValue={v.phone} autoComplete="tel" required /></div>
      <div className="sm:col-span-2"><label className="label" htmlFor="password">Password (min 8 characters)</label><input id="password" name="password" type="password" minLength={8} className="input" required autoComplete="new-password" /></div>

      {/* Honeypot: hidden from people (and screen readers); bots that fill every field get caught. */}
      <div aria-hidden="true" className="absolute -left-[9999px] h-px w-px overflow-hidden">
        <label htmlFor="website">Leave this field empty</label>
        <input id="website" name="website" type="text" tabIndex={-1} autoComplete="off" defaultValue="" />
      </div>
      <input type="hidden" name="token" value={challenge.token} />
      <div className="sm:col-span-2 max-w-xs">
        <label className="label" htmlFor="answer">Quick check: {challenge.question}</label>
        <input id="answer" name="answer" inputMode="numeric" autoComplete="off" className="input" required aria-describedby="answer-hint" />
        <p id="answer-hint" className="mt-1 text-xs text-muted">This helps us block spam robots.</p>
      </div>
      <button className="btn-primary sm:col-span-2" disabled={pending}>{pending ? "Creating…" : "Create account"}</button>
      <p className="text-center text-sm sm:col-span-2">Already have an account? <Link href="/account" className="underline">Sign in</Link></p>
    </form>
  );
}

/** Signed out: ask for a reset link by email. */
export function ForgotPasswordForm({ initialChallenge, initialEmail = "" }) {
  const [state, action, pending] = useActionState(requestPasswordReset, null);
  const challenge = state?.challenge || initialChallenge;
  if (state?.ok) {
    return (
      <div className="space-y-4">
        <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700" role="status">{state.ok}</p>
        <p className="text-center text-sm">
          <Link href="/account" className="underline">Back to sign in</Link>
        </p>
      </div>
    );
  }
  return (
    <form key={challenge.token} action={action} className="relative space-y-4">
      <p className="text-sm text-muted">Enter the email you signed up with and we&apos;ll send you a link to choose a new password.</p>
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>}
      <div>
        <label className="label" htmlFor="email">Email</label>
        <input id="email" name="email" type="email" className="input" required autoComplete="email" defaultValue={state?.email ?? initialEmail} />
      </div>
      <div aria-hidden="true" className="absolute -left-[9999px] h-px w-px overflow-hidden">
        <label htmlFor="website">Leave this field empty</label>
        <input id="website" name="website" type="text" tabIndex={-1} autoComplete="off" defaultValue="" />
      </div>
      <input type="hidden" name="token" value={challenge.token} />
      <div className="max-w-xs">
        <label className="label" htmlFor="answer">Quick check: {challenge.question}</label>
        <input id="answer" name="answer" inputMode="numeric" autoComplete="off" className="input" required aria-describedby="answer-hint" />
        <p id="answer-hint" className="mt-1 text-xs text-muted">This helps us block spam robots.</p>
      </div>
      <button className="btn-primary w-full" disabled={pending}>{pending ? "Sending…" : "Email me a reset link"}</button>
      <p className="text-center text-sm">Remembered it? <Link href="/account" className="underline">Sign in</Link></p>
    </form>
  );
}

/** From the emailed link: choose a new password. */
export function ResetPasswordForm({ token, email }) {
  const [state, action, pending] = useActionState(resetPassword, null);
  if (state?.expired) {
    return (
      <div className="space-y-4">
        <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>
        <Link href="/account/forgot-password" className="btn-primary w-full">Send a new link</Link>
      </div>
    );
  }
  return (
    <form action={action} className="space-y-4">
      <p className="text-sm text-muted">Choose a new password for <strong className="text-ink">{email}</strong>.</p>
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>}
      <input type="hidden" name="token" value={token} />
      {/* Lets password managers save the new password against the right account. */}
      <input type="email" name="username" value={email} autoComplete="username" readOnly hidden />
      <div>
        <label className="label" htmlFor="password">New password (min 8 characters)</label>
        <input id="password" name="password" type="password" minLength={8} className="input" required autoComplete="new-password" />
      </div>
      <div>
        <label className="label" htmlFor="confirm">Confirm new password</label>
        <input id="confirm" name="confirm" type="password" minLength={8} className="input" required autoComplete="new-password" />
      </div>
      <button className="btn-primary w-full" disabled={pending}>{pending ? "Saving…" : "Save new password"}</button>
    </form>
  );
}
