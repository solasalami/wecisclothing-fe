"use client";
import { useActionState, useEffect, useState } from "react";
import { useFormStatus } from "react-dom";
import { saveAddress, deleteAddress, makeDefaultAddress, resendVerification } from "@/app/actions/account";
import { NG_STATES } from "@/lib/ng-states";

/** Saved delivery addresses on the account page. */
export default function AddressBook({ addresses, max }) {
  const [editing, setEditing] = useState(null); // null | "new" | address id

  return (
    <section>
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-2xl">Saved addresses</h2>
        {editing !== "new" && addresses.length < max && (
          <button type="button" onClick={() => setEditing("new")} className="text-sm underline">Add an address</button>
        )}
      </div>

      {addresses.length === 0 && editing !== "new" && (
        <p className="text-sm text-muted">
          Save your home, office or family addresses to check out faster.{" "}
          <button type="button" onClick={() => setEditing("new")} className="underline">Add your first address</button>
        </p>
      )}

      {editing === "new" && <AddressForm onDone={() => setEditing(null)} />}

      <ul className="mt-4 grid gap-4 sm:grid-cols-2">
        {addresses.map((a) =>
          editing === a.id ? (
            <li key={a.id} className="sm:col-span-2"><AddressForm address={a} onDone={() => setEditing(null)} /></li>
          ) : (
            <li key={a.id} className={`border p-4 text-sm ${a.is_default ? "border-gold bg-gold-light/30" : "border-line"}`}>
              <div className="flex items-start justify-between gap-2">
                <p className="font-medium">{a.label || "Address"}</p>
                {a.is_default ? <span className="bg-gold px-2 py-0.5 text-[11px] uppercase tracking-wider text-ink">Default</span> : null}
              </div>
              <p className="mt-1">{a.address_line}</p>
              <p>{a.city}, {a.state}</p>
              {a.phone && <p className="text-muted">Phone: {a.phone}</p>}
              <div className="mt-3 flex flex-wrap gap-4 text-xs">
                <button type="button" onClick={() => setEditing(a.id)} className="underline">Edit</button>
                {!a.is_default && (
                  <form action={makeDefaultAddress}><input type="hidden" name="id" value={a.id} /><button className="underline">Make default</button></form>
                )}
                <form action={deleteAddress}><input type="hidden" name="id" value={a.id} /><button className="text-red-700 underline">Delete</button></form>
              </div>
            </li>
          )
        )}
      </ul>
    </section>
  );
}

function AddressForm({ address, onDone }) {
  const [state, action] = useActionState(saveAddress, null);
  useEffect(() => {
    if (state?.savedAt) onDone();
  }, [state, onDone]);
  const a = address || {};
  return (
    <form action={action} className="space-y-4 border border-line bg-soft p-5">
      <input type="hidden" name="id" value={a.id || ""} />
      {state?.error && <p className="text-sm text-red-600" role="alert">{state.error}</p>}
      <div className="grid gap-4 sm:grid-cols-2">
        <Input label="Label (optional)" name="label" defaultValue={a.label} placeholder="Home, Office, Mum's house" />
        <Input label="Phone for delivery (optional)" name="phone" type="tel" defaultValue={a.phone} placeholder="If different from your account phone" />
        <div className="sm:col-span-2">
          <Input label="Street address" name="address_line" defaultValue={a.address_line} autoComplete="street-address" required />
        </div>
        <Input label="City / Area" name="city" defaultValue={a.city} autoComplete="address-level2" required />
        <div>
          <label className="label" htmlFor={`state-${a.id || "new"}`}>State</label>
          <select id={`state-${a.id || "new"}`} name="state" className="input" defaultValue={a.state || "Lagos"} required>
            {NG_STATES.map((s) => <option key={s}>{s}</option>)}
          </select>
        </div>
      </div>
      {!a.is_default && (
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" name="is_default" className="h-4 w-4" /> Use as my default address
        </label>
      )}
      <div className="flex items-center gap-4">
        <Submit>{a.id ? "Save changes" : "Save address"}</Submit>
        <button type="button" onClick={onDone} className="text-sm underline">Cancel</button>
      </div>
    </form>
  );
}

/** "Confirm your email" notice with a resend button. */
/** Shown until the account's email is confirmed; ordering is blocked until then. */
export function VerifyEmailNotice({ email }) {
  const [state, action] = useActionState(resendVerification, null);
  return (
    <div className="border-l-4 border-gold bg-gold-light/40 p-4 text-sm" role="status">
      <p>
        <strong>Confirm your email before you place an order.</strong> We sent a confirmation link to <strong>{email}</strong>.
        Open it to activate ordering on your account. Until then you can browse and fill your bag, but you can&apos;t check out.
        Once confirmed, any orders you placed with this email before signing up will also appear in your account.
      </p>
      <p className="mt-2 text-muted">Can&apos;t find it? Check your spam or promotions folder, or send a new link.</p>
      <form action={action} className="mt-2">
        <ResendButton />
      </form>
      {state?.ok && <p className="mt-2 text-green-700">{state.ok}</p>}
      {state?.error && <p className="mt-2 text-red-600">{state.error}</p>}
    </div>
  );
}

function ResendButton() {
  const { pending } = useFormStatus();
  return <button disabled={pending} className="underline">{pending ? "Sending…" : "Send the link again"}</button>;
}

function Submit({ children }) {
  const { pending } = useFormStatus();
  return <button disabled={pending} className="btn-primary !py-2.5">{pending ? "Saving…" : children}</button>;
}

function Input({ label, name, type = "text", ...rest }) {
  const id = `${name}-${rest.defaultValue ? "edit" : "new"}`;
  return (
    <div>
      <label className="label" htmlFor={id}>{label}</label>
      <input id={id} name={name} type={type} className="input" {...rest} defaultValue={rest.defaultValue || ""} />
    </div>
  );
}
