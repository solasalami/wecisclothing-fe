// Shown at once when moving between admin pages, while the server renders the next one.
// Without it every click waited for the whole page (and its database queries) with no
// feedback, which looked like the panel had frozen.
export default function AdminLoading() {
  return (
    <div className="animate-pulse space-y-6" role="status" aria-live="polite">
      <span className="sr-only">Loading…</span>
      <div className="h-9 w-56 bg-line" />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {[0, 1, 2, 3].map((i) => (
          <div key={i} className="h-24 border border-line bg-white" />
        ))}
      </div>
      <div className="space-y-3 border border-line bg-white p-5">
        {[0, 1, 2, 3, 4, 5].map((i) => (
          <div key={i} className="h-4 bg-line" style={{ width: `${90 - i * 8}%` }} />
        ))}
      </div>
    </div>
  );
}
