"use client";
import { useRef, useState } from "react";

const TOOLS = [
  ["B", "bold", null, "font-bold"],
  ["I", "italic", null, "italic"],
  ["H2", "formatBlock", "h2", ""],
  ["H3", "formatBlock", "h3", ""],
  ["¶", "formatBlock", "p", ""],
  ["• List", "insertUnorderedList", null, ""],
  ["1. List", "insertOrderedList", null, ""],
  ["Link", "createLink", null, "underline"],
  ["Clear", "removeFormat", null, "text-muted"],
];

/** Minimal rich-text editor (bold, italic, headings, lists, links). Output is sanitised server-side. */
export default function RichText({ name, defaultValue = "", label, hint }) {
  const ref = useRef(null);
  const [html, setHtml] = useState(defaultValue || "");
  function run(command, value) {
    const el = ref.current;
    if (!el) return;
    el.focus();
    if (command === "createLink") {
      value = window.prompt("Link URL (https://…)");
      if (!value) return;
    }
    document.execCommand(command, false, value);
    setHtml(el.innerHTML);
  }
  return (
    <div>
      {label && <span className="label">{label}</span>}
      <div className="border border-line">
        <div className="flex flex-wrap gap-1 border-b border-line bg-soft p-1">
          {TOOLS.map(([l, command, value, cls]) => (
            <button key={l} type="button" onMouseDown={(e) => e.preventDefault()} onClick={() => run(command, value)} className={`px-2 py-1 text-xs hover:bg-white ${cls}`}>
              {l}
            </button>
          ))}
        </div>
        <div
          ref={ref}
          contentEditable
          suppressContentEditableWarning
          className="prose-wecis min-h-40 p-3 text-sm outline-none"
          onInput={(e) => setHtml(e.currentTarget.innerHTML)}
          dangerouslySetInnerHTML={{ __html: defaultValue || "" }}
        />
      </div>
      <input type="hidden" name={name} value={html} />
      {hint && <p className="mt-1 text-xs text-muted">{hint}</p>}
    </div>
  );
}
