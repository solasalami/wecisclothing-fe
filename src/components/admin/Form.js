"use client";
import { useActionState } from "react";
import { useFormStatus } from "react-dom";

/** <form> bound to a server action that returns { error } | { ok }. */
export function ActionForm({ action, children, className = "space-y-6", encType }) {
  const [state, formAction] = useActionState(action, null);
  return (
    <form action={formAction} className={className} encType={encType}>
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>}
      {state?.ok && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">{state.ok}</p>}
      {children}
    </form>
  );
}

export function SubmitButton({ children = "Save", className = "btn-primary" }) {
  const { pending } = useFormStatus();
  return (
    <button type="submit" disabled={pending} className={className}>
      {pending ? "Saving…" : children}
    </button>
  );
}

export function ConfirmButton({ children, message = "Are you sure?", className = "text-sm text-red-600 underline" }) {
  return (
    <button
      type="submit"
      className={className}
      onClick={(e) => {
        // Native confirm is fine in the admin panel.
        if (!window.confirm(message)) e.preventDefault();
      }}
    >
      {children}
    </button>
  );
}
