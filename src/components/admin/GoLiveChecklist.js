import { automaticChecks, manualSteps, getManualProgress, formatChecklistDate } from "@/lib/golive";
import { toggleGoLiveStep } from "@/app/admin/actions";

const Tick = ({ ok }) => (
  <span className={`mt-0.5 flex h-5 w-5 flex-none items-center justify-center rounded-full text-[11px] font-bold ${ok ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"}`} aria-hidden="true">
    {ok ? "✓" : "!"}
  </span>
);

/** Go-live checklist: automatic checks (live) + manual steps (ticked off by the team). */
export default async function GoLiveChecklist({ settings }) {
  const [auto, progress] = await Promise.all([automaticChecks(settings), getManualProgress()]);
  const manual = manualSteps();
  const autoItems = auto.flatMap((g) => g.items);
  const autoDone = autoItems.filter((i) => i.ok).length;
  const manualDone = manual.filter((m) => progress[m.id]).length;
  const total = autoItems.length + manual.length;
  const done = autoDone + manualDone;
  const pct = Math.round((done / total) * 100);
  const groups = [...new Set(manual.map((m) => m.group))];

  return (
    <details className="group border border-line bg-white" open={done < total}>
      <summary className="flex cursor-pointer list-none items-center justify-between gap-4 p-5">
        <div>
          <h2 className="font-sans text-sm font-bold uppercase tracking-wider">Go-live checklist</h2>
          <p className="mt-1 text-xs text-muted">{done} of {total} complete{done === total ? ". Ready to launch!" : ""}</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="h-2 w-40 overflow-hidden rounded-full bg-soft" role="progressbar" aria-valuenow={pct} aria-valuemin={0} aria-valuemax={100}>
            <div className="h-full bg-gold" style={{ width: `${pct}%` }} />
          </div>
          <span className="text-sm font-semibold">{pct}%</span>
        </div>
      </summary>

      <div className="grid gap-8 border-t border-line p-5 lg:grid-cols-2">
        <div>
          <h3 className="mb-1 font-sans text-xs font-bold uppercase tracking-wider text-gold-dark">Checked automatically ({autoDone}/{autoItems.length})</h3>
          <p className="mb-4 text-xs text-muted">Re-checked every time you open the dashboard.</p>
          {auto.map((g) => (
            <div key={g.group} className="mb-5">
              <p className="mb-2 text-[11px] font-semibold uppercase tracking-[0.15em] text-muted">{g.group}</p>
              <ul className="space-y-2.5 text-sm">
                {g.items.map((i) => (
                  <li key={i.label} className="flex gap-2.5">
                    <Tick ok={i.ok} />
                    <span>
                      {i.label}
                      {!i.ok && <span className="mt-0.5 block text-xs text-muted">{i.help}</span>}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        <div>
          <h3 className="mb-1 font-sans text-xs font-bold uppercase tracking-wider text-gold-dark">Manual steps ({manualDone}/{manual.length})</h3>
          <p className="mb-4 text-xs text-muted">Things the site can&apos;t check for you. Mark each one done when finished.</p>
          {groups.map((group) => (
            <div key={group} className="mb-5">
              <p className="mb-2 text-[11px] font-semibold uppercase tracking-[0.15em] text-muted">{group}</p>
              <ul className="space-y-2.5 text-sm">
                {manual
                  .filter((m) => m.group === group)
                  .map((m) => {
                    const state = progress[m.id];
                    return (
                      <li key={m.id} className="flex gap-2.5">
                        <Tick ok={Boolean(state)} />
                        <span className="flex-1">
                          <span className={state ? "text-muted line-through" : ""}>{m.label}</span>
                          {state ? (
                            <span className="mt-0.5 block text-xs text-muted">Done {formatChecklistDate(state.done_at)}{state.by ? ` by ${state.by}` : ""}</span>
                          ) : (
                            <span className="mt-0.5 block break-words text-xs text-muted">{m.help}</span>
                          )}
                        </span>
                        <form action={toggleGoLiveStep} className="flex-none">
                          <input type="hidden" name="id" value={m.id} />
                          <input type="hidden" name="done" value={state ? "0" : "1"} />
                          <button className={`text-xs underline ${state ? "text-muted" : "text-gold-dark"}`}>{state ? "Undo" : "Mark done"}</button>
                        </form>
                      </li>
                    );
                  })}
              </ul>
            </div>
          ))}
        </div>
      </div>
    </details>
  );
}
