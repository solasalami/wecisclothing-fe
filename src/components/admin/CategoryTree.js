"use client";
import Link from "next/link";
import { useState } from "react";
import { ConfirmButton } from "./Form";

/** Finder-style tree: disclosure arrows, folder icons, indentation guides. */

function Chevron({ open }) {
  return (
    <svg width="10" height="10" viewBox="0 0 10 10" aria-hidden="true" className={`transition-transform duration-150 ${open ? "rotate-90" : ""}`}>
      <path d="M3 1.5 7 5 3 8.5" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

function FolderIcon({ open, muted }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" className={muted ? "text-gray-300" : "text-gold"}>
      {open ? (
        <path fill="currentColor" d="M3 6.5A1.5 1.5 0 0 1 4.5 5h4.6l2 2h7.4A1.5 1.5 0 0 1 20 8.5V10H7.2a1.5 1.5 0 0 0-1.42 1.02L3 19z M5.9 11.6A1 1 0 0 1 6.85 11H21a.7.7 0 0 1 .66.92l-2.4 7.1a1.5 1.5 0 0 1-1.42 1H3.6z" />
      ) : (
        <path fill="currentColor" d="M3 6.5A1.5 1.5 0 0 1 4.5 5h4.6l2 2h8.4A1.5 1.5 0 0 1 21 8.5v9A1.5 1.5 0 0 1 19.5 19h-15A1.5 1.5 0 0 1 3 17.5z" />
      )}
    </svg>
  );
}

const INDENT = 22;

function useExpanded(initial) {
  const [open, setOpen] = useState(() => new Set(initial));
  const toggle = (id) =>
    setOpen((prev) => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });
  return [open, toggle, setOpen];
}

function collectIds(nodes, out = []) {
  for (const n of nodes) {
    if (n.children.length) out.push(n.id);
    collectIds(n.children, out);
  }
  return out;
}

/** Row prefix: indentation guides + disclosure arrow (or spacer) + folder icon. */
function RowLead({ node, depth, isOpen, onToggle }) {
  const hasChildren = node.children.length > 0;
  return (
    <span className="relative flex flex-none items-center gap-1.5" style={{ paddingLeft: depth * INDENT }}>
      {Array.from({ length: depth }, (_, i) => (
        <span key={i} className="absolute top-[-10px] bottom-[-10px] w-px bg-line" style={{ left: i * INDENT + 8 }} aria-hidden="true" />
      ))}
      {hasChildren ? (
        <button
          type="button"
          onClick={() => onToggle(node.id)}
          aria-expanded={isOpen}
          aria-label={`${isOpen ? "Collapse" : "Expand"} ${node.name}`}
          className="flex h-5 w-5 items-center justify-center text-muted hover:text-ink"
        >
          <Chevron open={isOpen} />
        </button>
      ) : (
        <span className="w-5" />
      )}
      <FolderIcon open={hasChildren && isOpen} muted={!node.is_active} />
    </span>
  );
}

/* ---------------- Manage view (Admin → Categories) ---------------- */

export function CategoryManager({ tree, selectedId, deleteAction }) {
  const [open, toggle, setOpen] = useExpanded(tree.map((n) => n.id));
  const all = collectIds(tree);

  const renderRows = (nodes, depth) =>
    nodes.flatMap((node) => {
      const isOpen = open.has(node.id);
      const row = (
        <div
          key={node.id}
          role="treeitem"
          aria-selected={selectedId === node.id}
          aria-level={depth + 1}
          aria-expanded={node.children.length ? isOpen : undefined}
          className={`group flex items-center gap-2 border-b border-line px-3 py-2.5 text-sm ${selectedId === node.id ? "bg-gold-light" : "hover:bg-soft"}`}
        >
          <RowLead node={node} depth={depth} isOpen={isOpen} onToggle={toggle} />
          <Link href={`/admin/categories?edit=${node.id}`} className={`min-w-0 flex-1 truncate ${node.is_active ? "" : "text-muted"}`}>
            <span className="font-medium">{node.name}</span>
            <span className="ml-2 text-xs text-muted">/{node.slug}</span>
          </Link>
          <span className="flex flex-none items-center gap-1.5 text-xs">
            {!node.is_active && <span className="bg-gray-100 px-1.5 py-0.5 text-gray-600">Hidden</span>}
            {!node.show_in_menu && <span className="bg-gray-100 px-1.5 py-0.5 text-gray-600">Not in menu</span>}
            <span className="w-16 text-right text-muted">{node.product_count} {node.product_count === 1 ? "item" : "items"}</span>
          </span>
          <form action={deleteAction} className="w-14 flex-none text-right opacity-0 transition group-hover:opacity-100 focus-within:opacity-100">
            <input type="hidden" name="id" value={node.id} />
            <ConfirmButton message={`Delete "${node.name}"? Its sub-categories move to the top level; products are not deleted.`} className="text-xs text-red-600 underline">
              Delete
            </ConfirmButton>
          </form>
        </div>
      );
      return [row, ...(isOpen ? renderRows(node.children, depth + 1) : [])];
    });

  return (
    <div className="border border-line bg-white">
      <div className="flex items-center justify-between border-b border-line bg-soft px-3 py-2 text-xs uppercase tracking-[0.12em] text-muted">
        <span>Name</span>
        <span className="flex gap-3 normal-case tracking-normal">
          <button type="button" onClick={() => setOpen(new Set(all))} className="underline">Expand all</button>
          <button type="button" onClick={() => setOpen(new Set())} className="underline">Collapse all</button>
        </span>
      </div>
      <div role="tree" aria-label="Categories">{renderRows(tree, 0)}</div>
    </div>
  );
}

/* ---------------- Select view (product editor checkboxes) ---------------- */

function containsChecked(node, checked) {
  return node.children.some((c) => checked.includes(c.id) || containsChecked(c, checked));
}

export function CategoryPicker({ tree, name = "categories", defaultChecked = [] }) {
  // Open top level plus any branch that holds a ticked category, so selections are visible.
  const initial = [];
  const walk = (nodes) =>
    nodes.forEach((n) => {
      if (containsChecked(n, defaultChecked)) initial.push(n.id);
      walk(n.children);
    });
  walk(tree);
  const [open, toggle] = useExpanded([...tree.map((n) => n.id), ...initial]);

  // Checkboxes stay mounted when collapsed so ticked values are still submitted.
  const renderRows = (nodes, depth, visible) =>
    nodes.map((node) => {
      const isOpen = open.has(node.id);
      return (
        <div key={node.id} role="treeitem" aria-selected={defaultChecked.includes(node.id)} aria-level={depth + 1} aria-expanded={node.children.length ? isOpen : undefined}>
          <div className={`${visible ? "flex" : "hidden"} items-center gap-2 py-1 text-sm`}>
            <RowLead node={node} depth={depth} isOpen={isOpen} onToggle={toggle} />
            <label className="flex min-w-0 flex-1 cursor-pointer items-center gap-2">
              <input type="checkbox" name={name} value={node.id} defaultChecked={defaultChecked.includes(node.id)} className="h-4 w-4 accent-[#c9a227]" />
              <span className={`truncate ${node.is_active ? "" : "text-muted"}`}>{node.name}</span>
            </label>
          </div>
          {node.children.length > 0 && renderRows(node.children, depth + 1, visible && isOpen)}
        </div>
      );
    });

  return (
    <div role="tree" aria-label="Categories" aria-multiselectable="true" className="max-h-80 overflow-y-auto">
      {renderRows(tree, 0, true)}
    </div>
  );
}
