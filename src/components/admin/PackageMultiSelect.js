"use client";
import { useEffect, useOptimistic, useRef, useState, useTransition } from "react";
import { setProductInPackage } from "@/app/admin/actions";

/**
 * Admin, Products: the packages this product is in, as a dropdown of tick boxes. Ticking saves
 * at once: a fixed bundle gets it as an item, a pick-your-own bundle gets it in its collection.
 * packages: [{ id, name, pick, simple }]; selected: ids of the packages it is in now.
 */
export default function PackageMultiSelect({ productId, productName, packages, selected }) {
  const [open, setOpen] = useState(false);
  const [error, setError] = useState("");
  const [pending, startTransition] = useTransition();
  const [ids, setIds] = useOptimistic(selected, (cur, { id, on }) => (on ? [...cur, id] : cur.filter((x) => x !== id)));
  const box = useRef(null);

  // Close when clicking elsewhere or pressing Escape.
  useEffect(() => {
    if (!open) return;
    const away = (e) => !box.current?.contains(e.target) && setOpen(false);
    const esc = (e) => e.key === "Escape" && setOpen(false);
    document.addEventListener("mousedown", away);
    document.addEventListener("keydown", esc);
    return () => {
      document.removeEventListener("mousedown", away);
      document.removeEventListener("keydown", esc);
    };
  }, [open]);

  function toggle(id, on) {
    setError("");
    startTransition(async () => {
      setIds({ id, on });
      const res = await setProductInPackage(productId, id, on);
      if (res?.error) setError(res.error);
    });
  }

  const names = packages.filter((p) => ids.includes(p.id)).map((p) => p.name);
  if (!packages.length) return <span className="text-xs text-muted">No packages yet</span>;

  return (
    <div ref={box} className="relative">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        aria-label={`Packages for ${productName}`}
        className={`flex max-w-48 items-center gap-1 border px-2 py-1 text-left text-xs ${names.length ? "border-gold bg-gold-light/40" : "border-line text-muted hover:border-gold"}`}
      >
        <span className="truncate">{names.length ? names.join(", ") : "Add to package"}</span>
        <span aria-hidden="true">{pending ? "…" : "▾"}</span>
      </button>
      {open && (
        <div className="absolute right-0 z-20 mt-1 w-72 border border-line bg-white p-2 shadow-lg" role="group" aria-label={`Packages for ${productName}`}>
          <p className="px-1 pb-1 text-[11px] uppercase tracking-wider text-muted">Include in packages</p>
          <ul className="max-h-64 overflow-y-auto">
            {packages.map((p) => (
              <li key={p.id}>
                <label className="flex cursor-pointer items-start gap-2 px-1 py-1.5 text-sm hover:bg-soft">
                  <input type="checkbox" className="mt-0.5" checked={ids.includes(p.id)} onChange={(e) => toggle(p.id, e.target.checked)} />
                  <span>
                    {p.name}
                    <span className="block text-xs text-muted">
                      {p.pick ? `Pick-your-own: adds it to ${p.pick}` : p.simple ? "Simple package: adding an item makes it a fixed bundle" : "Fixed bundle: adds it as an item"}
                    </span>
                  </span>
                </label>
              </li>
            ))}
          </ul>
          {error && <p className="px-1 pt-1 text-xs text-red-600" role="alert">{error}</p>}
        </div>
      )}
    </div>
  );
}
