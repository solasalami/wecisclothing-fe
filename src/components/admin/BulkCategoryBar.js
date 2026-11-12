"use client";
import { useEffect, useState } from "react";
import { useFormStatus } from "react-dom";
import { bulkCategory } from "@/app/admin/actions";

const FORM = "bulk-category";
const boxes = () => [...document.querySelectorAll(`input[form="${FORM}"][name="ids"]`)];
const countTicked = () => boxes().filter((b) => b.checked).length;

/**
 * Admin, Products: add or remove the ticked products to/from a category in one go.
 * Row checkboxes live in the table and join this form through form="bulk-category"
 * (each row already has its own Show/Hide form, and forms can't be nested).
 */
export default function BulkCategoryBar({ categories, back }) {
  const [count, setCount] = useState(0);
  const refresh = () => setCount(countTicked());

  // The row checkboxes sit in the table, outside this form in the page, so their change
  // events never reach the form's onChange: listen for them on the document instead.
  useEffect(() => {
    const onChange = (e) => {
      if (e.target instanceof HTMLInputElement && e.target.getAttribute("form") === FORM) setCount(countTicked());
    };
    document.addEventListener("change", onChange);
    return () => document.removeEventListener("change", onChange);
  }, []);

  return (
    <form id={FORM} action={bulkCategory} className="flex flex-wrap items-center gap-2 border-b border-line bg-gold-light/30 px-3 py-2 text-sm">
      <input type="hidden" name="back" value={back} />
      <label className="flex items-center gap-2 font-medium">
        <input
          type="checkbox"
          aria-label="Select all products on this page"
          onChange={(e) => {
            boxes().forEach((b) => (b.checked = e.target.checked));
            refresh();
          }}
        />
        {count ? `${count} selected` : "Select all"}
      </label>
      <select name="category_id" required className="input !w-auto max-w-72 !py-1.5" defaultValue="">
        <option value="" disabled>Choose a category…</option>
        {categories.map((c) => (
          <option key={c.id} value={c.id}>{c.path}</option>
        ))}
      </select>
      <Action mode="add" disabled={!count}>Add to category</Action>
      <Action mode="remove" disabled={!count}>Remove from category</Action>
    </form>
  );
}

function Action({ mode, disabled, children }) {
  const { pending } = useFormStatus();
  return (
    <button name="mode" value={mode} disabled={disabled || pending} className={`${mode === "add" ? "btn-primary" : "btn-outline"} !px-3 !py-1.5 !text-xs disabled:opacity-40`}>
      {pending ? "Saving…" : children}
    </button>
  );
}
