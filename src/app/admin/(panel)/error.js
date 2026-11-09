"use client";
import Link from "next/link";

// Keeps the admin menu usable when a page fails to load (for example a slow or
// unreachable database), instead of leaving the click hanging or the screen blank.
export default function AdminError({ error, retry }) {
  return (
    <div className="max-w-lg border border-line bg-white p-6">
      <h1 className="text-2xl">This page didn&apos;t load</h1>
      <p className="mt-3 text-sm text-muted">
        The server took too long or hit an error. Please try again. If it keeps happening, check the database connection on the Go-live checklist.
      </p>
      {error?.digest && <p className="mt-2 text-xs text-muted">Reference: {error.digest}</p>}
      <div className="mt-5 flex gap-3">
        <button onClick={() => retry()} className="btn-primary">Try again</button>
        <Link href="/admin" className="btn-outline">Dashboard</Link>
      </div>
    </div>
  );
}
