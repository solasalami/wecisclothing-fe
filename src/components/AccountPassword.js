"use client";
import { useActionState, useEffect, useRef } from "react";
import { useFormStatus } from "react-dom";
import { changePassword, emailMyResetLink } from "@/app/actions/account";

/** "Password" section on the signed-in account page: change it, or email a reset link. */
export default function AccountPassword({ email }) {
  const [state, action] = useActionState(changePassword, null);
  const [linkState, linkAction] = useActionState(emailMyResetLink, null);
  const formRef = useRef(null);
  useEffect(() => {
    if (state?.savedAt) formRef.current?.reset();
  }, [state?.savedAt]);

  return (
    <section id="password" className="mt-12 scroll-mt-24">
      <h2 className="mb-4 text-2xl">Password</h2>
      <form ref={formRef} action={action} className="grid max-w-2xl gap-4 border border-line p-5 sm:grid-cols-2">
        <input type="email" name="username" value={email} autoComplete="username" readOnly hidden />
        <div className="sm:col-span-2 sm:max-w-sm">
          <label className="label" htmlFor="current">Current password</label>
          <input id="current" name="current" type="password" className="input" required autoComplete="current-password" />
        </div>
        <div>
          <label className="label" htmlFor="new-password">New password (min 8 characters)</label>
          <input id="new-password" name="password" type="password" minLength={8} className="input" required autoComplete="new-password" />
        </div>
        <div>
          <label className="label" htmlFor="confirm-password">Confirm new password</label>
          <input id="confirm-password" name="confirm" type="password" minLength={8} className="input" required autoComplete="new-password" />
        </div>
        <div className="flex flex-wrap items-center gap-4 sm:col-span-2">
          <Submit pendingText="Saving…">Change password</Submit>
          {state?.ok && <p className="text-sm text-green-700" role="status">{state.ok}</p>}
          {state?.error && <p className="text-sm text-red-600" role="alert">{state.error}</p>}
        </div>
      </form>
      <form action={linkAction} className="mt-4 max-w-2xl text-sm">
        <p className="text-muted">
          Forgot your current password? <ResetLinkButton /> to {email} and choose a new one from there.
        </p>
        {linkState?.ok && <p className="mt-2 text-green-700" role="status">{linkState.ok}</p>}
        {linkState?.error && <p className="mt-2 text-red-600" role="alert">{linkState.error}</p>}
      </form>
    </section>
  );
}

function Submit({ children, pendingText }) {
  const { pending } = useFormStatus();
  return <button disabled={pending} className="btn-primary !py-2.5">{pending ? pendingText : children}</button>;
}

function ResetLinkButton() {
  const { pending } = useFormStatus();
  return <button disabled={pending} className="font-semibold text-ink underline">{pending ? "Sending…" : "Email me a reset link"}</button>;
}
