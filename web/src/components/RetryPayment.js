"use client";
import { useState, useTransition } from "react";
import { retryPayment } from "@/app/actions/checkout";

export default function RetryPayment({ orderNumber, token }) {
  const [error, setError] = useState("");
  const [pending, start] = useTransition();
  return (
    <div>
      <button
        className="btn-primary"
        disabled={pending}
        onClick={() =>
          start(async () => {
            const res = await retryPayment(orderNumber, token);
            if (res.ok) window.location.assign(res.redirect);
            else setError(res.error);
          })
        }
      >
        {pending ? "Redirecting…" : "Try payment again"}
      </button>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
    </div>
  );
}
