"use client";
import { useActionState, useState } from "react";
import { useFormStatus } from "react-dom";
import { formUploadBytes, MAX_FORM_UPLOAD } from "@/lib/optimize-image";

/** <form> bound to a server action that returns { error } | { ok }. */
export function ActionForm({ action, children, className = "space-y-6", encType }) {
  const [state, formAction] = useActionState(action, null);
  const [clientError, setClientError] = useState("");

  // Stop saves the host would reject (Netlify: ~6 MB per request, a bare 400 with no logs).
  function onSubmit(e) {
    const form = e.currentTarget;
    if (form.querySelector('input[type="file"][data-optimising="true"]')) {
      e.preventDefault();
      setClientError("Please wait a moment: images are still being optimised.");
      return;
    }
    const bytes = formUploadBytes(form);
    if (bytes > MAX_FORM_UPLOAD) {
      e.preventDefault();
      setClientError(
        `These images add up to ${(bytes / 1024 / 1024).toFixed(1)} MB, more than can be saved at once (${(MAX_FORM_UPLOAD / 1024 / 1024).toFixed(1)} MB). Remove some, save, then add the rest.`
      );
      return;
    }
    setClientError("");
  }

  return (
    <form action={formAction} onSubmit={onSubmit} className={className} encType={encType}>
      {clientError && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{clientError}</p>}
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>}
      {state?.ok && <p className="border border-green-200 bg-green-50 p-3 text-sm text-green-700">{state.ok}</p>}
      {children}
    </form>
  );
}

export function SubmitButton({ children = "Save", className = "btn-primary", pendingText = "Saving…" }) {
  const { pending } = useFormStatus();
  return (
    <button type="submit" disabled={pending} className={className}>
      {pending ? pendingText : children}
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
