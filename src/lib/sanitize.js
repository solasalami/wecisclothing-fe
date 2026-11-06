// Allow-list HTML sanitizer for admin-authored rich text (product descriptions, pages).
const ALLOWED = new Set([
  "p", "br", "strong", "b", "em", "i", "u", "ul", "ol", "li", "h2", "h3", "h4", "a", "blockquote",
  "table", "thead", "tbody", "tr", "th", "td",
]);

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
    return `<${t}>`;
  });
  return tidyPastedHtml(html);
}

/**
 * Removes formatting that text pasted from ChatGPT and similar tools carries
 * and that makes copy look machine-made: divider lines between sections (<hr>
 * is not in ALLOWED, so those are already gone), paragraphs wrapped inside list
 * items (extra-wide gaps), bold text inside headings and stray trailing <br>s.
 */
export function tidyPastedHtml(html) {
  return String(html || "")
    .replace(/<li>\s*<p>/g, "<li>")
    .replace(/<\/p>\s*<\/li>/g, "</li>")
    .replace(/<(h[2-4])>([\s\S]*?)<\/\1>/g, (_m, h, inner) => `<${h}>${inner.replace(/<\/?(strong|b)>/g, "")}</${h}>`)
    .replace(/(<br>\s*)+$/g, "")
    .replace(/<\/p>\s*<br>/g, "</p>")
    .replace(/<p>\s*<\/p>/g, "")
    .trim();
}
