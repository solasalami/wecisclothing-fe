"use client";
import { useState } from "react";

/** Existing product images (reorder / remove) + new uploads with previews. */
export default function ImageManager({ images = [] }) {
  const [items, setItems] = useState(images.map((i) => ({ ...i, removed: false })));
  const [previews, setPreviews] = useState([]);

  const move = (idx, dir) => {
    const next = [...items];
    const j = idx + dir;
    if (j < 0 || j >= next.length) return;
    [next[idx], next[j]] = [next[j], next[idx]];
    setItems(next);
  };

  return (
    <div>
      {items.length > 0 && (
        <div className="mb-4 grid grid-cols-3 gap-3 sm:grid-cols-4">
          {items.map((img, idx) => (
            <div key={img.id} className={`relative border ${img.removed ? "opacity-30" : ""} ${idx === 0 && !img.removed ? "border-ink" : "border-line"}`}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={img.url} alt="" className="aspect-[4/5] w-full object-cover" />
              {idx === 0 && !img.removed && <span className="absolute left-1 top-1 bg-ink px-1.5 py-0.5 text-[10px] uppercase text-white">Main</span>}
              <input type="hidden" name="image_order" value={img.id} />
              {img.removed && <input type="hidden" name="remove_image" value={img.id} />}
              <div className="flex justify-between bg-white p-1 text-xs">
                <span className="flex gap-1">
                  <button type="button" onClick={() => move(idx, -1)} aria-label="Move left" className="px-1">◀</button>
                  <button type="button" onClick={() => move(idx, 1)} aria-label="Move right" className="px-1">▶</button>
                </span>
                <button
                  type="button"
                  onClick={() => setItems(items.map((x) => (x.id === img.id ? { ...x, removed: !x.removed } : x)))}
                  className="text-red-600"
                >
                  {img.removed ? "Undo" : "Remove"}
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
      <label className="label" htmlFor="images">Add photos</label>
      <input
        id="images"
        name="images"
        type="file"
        multiple
        accept="image/jpeg,image/png,image/webp"
        className="block w-full text-sm"
        onChange={(e) => setPreviews([...e.target.files].map((f) => URL.createObjectURL(f)))}
      />
      <p className="mt-1 text-xs text-muted">JPG, PNG or WebP, up to 8MB each. Portrait 4:5 (e.g. 1200×1500) looks best. The first photo is the main image.</p>
      {previews.length > 0 && (
        <div className="mt-3 grid grid-cols-4 gap-2">
          {previews.map((p) => (
            // eslint-disable-next-line @next/next/no-img-element
            <img key={p} src={p} alt="" className="aspect-[4/5] w-full object-cover" />
          ))}
        </div>
      )}
    </div>
  );
}
