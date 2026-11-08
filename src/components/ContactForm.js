"use client";
import { useActionState, useState } from "react";
import { useFormStatus } from "react-dom";
import { sendContactMessage } from "@/app/actions/contact";

export default function ContactForm({ topics, initialChallenge }) {
  const [state, action] = useActionState(sendContactMessage, null);
  const [another, setAnother] = useState(0); // bumps to show a fresh form after a successful send
  const challenge = state?.challenge || initialChallenge;
  const v = state?.values || {};

  if (state?.ok && another === 0) {
    return (
      <div className="border border-green-200 bg-green-50 p-6 text-center" role="status">
        <p className="text-xl">Thank you, your message has been sent.</p>
        <p className="mt-2 text-sm text-muted">We usually reply within one working day. For anything urgent, WhatsApp or call us.</p>
        <button type="button" onClick={() => setAnother(1)} className="mt-4 text-sm underline">Send another message</button>
      </div>
    );
  }

  return (
    // key: remount after each reply so fields show the values returned by the server
    <form key={challenge.token} action={(fd) => { setAnother(0); return action(fd); }} className="relative space-y-4" noValidate>
      {state?.error && <p className="border border-red-200 bg-red-50 p-3 text-sm text-red-700" role="alert">{state.error}</p>}
      <div className="grid gap-4 sm:grid-cols-2">
        <Field label="Your name" name="name" autoComplete="name" defaultValue={v.name} required maxLength={120} />
        <Field label="Email" name="email" type="email" autoComplete="email" defaultValue={v.email} required maxLength={190} />
        <Field label="Phone or WhatsApp (optional)" name="phone" type="tel" autoComplete="tel" defaultValue={v.phone} maxLength={40} />
        <div>
          <label className="label" htmlFor="topic">Topic</label>
          <select id="topic" name="topic" className="input" defaultValue={v.topic || topics[0]} required>
            {topics.map((t) => <option key={t}>{t}</option>)}
          </select>
        </div>
      </div>
      <div>
        <label className="label" htmlFor="message">Message</label>
        <textarea id="message" name="message" rows={6} className="input" defaultValue={v.message} required minLength={10} maxLength={4000} />
      </div>

      {/* Honeypot: hidden from people (and screen readers); bots that fill every field get caught. */}
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

      <Submit />
    </form>
  );
}

function Submit() {
  const { pending } = useFormStatus();
  return <button type="submit" disabled={pending} className="btn-primary">{pending ? "Sending…" : "Send message"}</button>;
}

function Field({ label, name, type = "text", defaultValue, ...rest }) {
  return (
    <div>
      <label className="label" htmlFor={name}>{label}</label>
      <input id={name} name={name} type={type} className="input" defaultValue={defaultValue || ""} {...rest} />
    </div>
  );
}
