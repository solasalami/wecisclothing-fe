// Allow-list HTML sanitizer for admin-authored rich text (product descriptions, pages).
const ALLOWED = new Set(["p", "br", "strong", "b", "em", "i", "u", "ul", "ol", "li", "h2", "h3", "h4", "a", "blockquote", "hr"]);

function safeHref(href) {
  const h = String(href || "").trim().replace(/&amp;/g, "&");
  if (/^(https?:|mailto:|tel:|\/|#)/i.test(h)) return h.replace(/"/g, "%22");
  return null;
}

export function sanitizeHtml(input) {
  let html = String(input || "");
  html = html.replace(/<!--[\s\S]*?-->/g, "");
  html = html.replace(/<(script|style|iframe|object|embed|template|svg|math|form|textarea|select)\b[\s\S]*?<\/\1\s*>/gi, "");
  html = html.replace(/<\/?([a-zA-Z0-9]+)\b([^>]*)>/g, (full, tag, attrs) => {
    const t = tag.toLowerCase();
    const closing = full.startsWith("</");
    if (t === "div") return closing ? "</p>" : "<p>";
    if (!ALLOWED.has(t)) return "";
    if (closing) return `</${t}>`;
    if (t === "a") {
      const m = attrs.match(/href\s*=\s*("([^"]*)"|'([^']*)'|([^\s>]+))/i);
      const href = safeHref(m ? m[2] ?? m[3] ?? m[4] : "");
      return href ? `<a href="${href}" rel="noopener noreferrer">` : "<a>";
    }
    return t === "br" || t === "hr" ? `<${t}>` : `<${t}>`;
  });
  return html.replace(/<p>\s*<\/p>/g, "").trim();
}
