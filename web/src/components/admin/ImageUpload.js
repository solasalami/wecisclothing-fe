"use client";
import { useEffect, useId, useRef, useState } from "react";

const ACCEPT = "image/jpeg,image/png,image/webp";
const MAX_BYTES = 8 * 1024 * 1024;

function formatSize(bytes) {
  return bytes > 1024 * 1024 ? `${(bytes / 1024 / 1024).toFixed(1)} MB` : `${Math.round(bytes / 1024)} KB`;
}

/**
 * Upload box with a clearly visible "Choose image" button, drag & drop,
 * thumbnail previews and per-file remove. The real <input type="file"> stays
 * in the form (visually hidden), so server actions receive the files as usual.
 */
export default function ImageUpload({ name, multiple = false, required = false, hint, buttonLabel, compact = false }) {
  const id = useId();
  const input = useRef(null);
  const [items, setItems] = useState([]); // [{ file, url }]
  const [error, setError] = useState("");
  const [dragging, setDragging] = useState(false);
  const files = items.map((i) => i.file);

  // Every preview URL we create, so they can all be released on unmount.
  const urls = useRef(new Set());
  useEffect(() => {
    const set = urls.current;
    return () => set.forEach((u) => URL.revokeObjectURL(u));
  }, []);

  function apply(list) {
    const accepted = [];
    const problems = [];
    for (const f of list) {
      if (!ACCEPT.split(",").includes(f.type)) problems.push(`${f.name}: use JPG, PNG or WebP`);
      else if (f.size > MAX_BYTES) problems.push(`${f.name}: larger than 8 MB`);
      else accepted.push(f);
    }
    const chosen = multiple ? accepted : accepted.slice(0, 1);
    const dt = new DataTransfer();
    chosen.forEach((f) => dt.items.add(f));
    input.current.files = dt.files; // keep the form's input in sync
    const keep = new Map(items.map((i) => [i.file, i.url]));
    const next = chosen.map((file) => {
      let url = keep.get(file);
      if (!url) {
        url = URL.createObjectURL(file);
        urls.current.add(url);
      }
      return { file, url };
    });
    items.forEach((i) => {
      if (!chosen.includes(i.file)) {
        URL.revokeObjectURL(i.url);
        urls.current.delete(i.url);
      }
    });
    setItems(next);
    setError(problems.join(" · "));
  }

  function removeAt(i) {
    apply(files.filter((_, idx) => idx !== i));
  }

  const label = buttonLabel || (multiple ? "Choose images" : files.length ? "Replace image" : "Choose image");

  return (
    <div>
      <div
        onDragOver={(e) => {
          e.preventDefault();
          setDragging(true);
        }}
        onDragLeave={() => setDragging(false)}
        onDrop={(e) => {
          e.preventDefault();
          setDragging(false);
          apply([...(multiple ? [...files] : []), ...e.dataTransfer.files]);
        }}
        className={`flex flex-col items-center justify-center gap-2 border-2 border-dashed text-center transition ${
          compact ? "px-4 py-4" : "px-4 py-7"
        } ${dragging ? "border-gold bg-gold-light" : "border-gold/40 bg-gold-light/30 hover:border-gold"}`}
      >
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gold-dark" aria-hidden="true">
          <rect x="3" y="3" width="18" height="18" rx="2" />
          <circle cx="8.5" cy="8.5" r="1.5" />
          <path d="M21 15l-5-5L5 21" />
        </svg>
        <label htmlFor={id} className="btn-primary cursor-pointer !px-5 !py-2.5">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
            <path d="M12 16V4M6 10l6-6 6 6M4 20h16" />
          </svg>
          {label}
        </label>
        <p className="text-xs text-muted">or drag and drop {multiple ? "images" : "an image"} here</p>
        {hint && <p className="text-xs text-muted">{hint}</p>}
        <input
          ref={input}
          id={id}
          name={name}
          type="file"
          accept={ACCEPT}
          multiple={multiple}
          required={required && files.length === 0}
          onChange={(e) => apply([...(multiple ? files : []), ...e.target.files])}
          className="sr-only"
        />
      </div>

      {error && <p className="mt-2 text-xs text-red-600">{error}</p>}

      {files.length > 0 && (
        <ul className={`mt-3 grid gap-3 ${multiple ? "grid-cols-2 sm:grid-cols-4" : "grid-cols-1"}`}>
          {items.map(({ file: f, url }, i) => (
            <li key={`${f.name}-${i}`} className={`border border-line bg-white ${multiple ? "" : "flex items-center gap-3 p-2"}`}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={url} alt="" className={multiple ? "aspect-[4/5] w-full object-cover" : "h-16 w-24 flex-none object-cover"} />
              <div className={`flex min-w-0 flex-1 items-center justify-between gap-2 text-xs ${multiple ? "p-2" : ""}`}>
                <span className="min-w-0">
                  <span className="block truncate">{f.name}</span>
                  <span className="text-muted">{formatSize(f.size)} · new</span>
                </span>
                <button type="button" onClick={() => removeAt(i)} className="flex-none text-red-600 underline">
                  Remove
                </button>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
