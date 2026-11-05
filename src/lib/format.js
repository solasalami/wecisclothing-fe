const naira = new Intl.NumberFormat("en-NG", {
  style: "currency",
  currency: "NGN",
  maximumFractionDigits: 0,
});

export function formatNaira(value) {
  return naira.format(Number(value || 0));
}

export function slugify(text) {
  return String(text || "")
    .toLowerCase()
    .normalize("NFKD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 200);
}

export function formatDate(value) {
  if (!value) return "";
  return new Date(value).toLocaleString("en-NG", {
    dateStyle: "medium",
    timeStyle: "short",
    timeZone: "Africa/Lagos",
  });
}

/** "+234 803 364 0090" -> "2348033640090" for wa.me links */
export function digitsOnly(phone) {
  return String(phone || "").replace(/\D/g, "");
}

export function whatsappLink(phone, text) {
  const base = `https://wa.me/${digitsOnly(phone)}`;
  return text ? `${base}?text=${encodeURIComponent(text)}` : base;
}

export function telLink(phone) {
  return `tel:+${digitsOnly(phone)}`;
}

/** Strip tags for plain text excerpts / meta descriptions. */
export function stripHtml(html) {
  return String(html || "").replace(/<[^>]*>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();
}

/** Tidy pasted copy: collapse whitespace and remove stray spaces before punctuation ("Clothings , our" → "Clothings, our"). */
export function tidyText(text) {
  return String(text || "")
    .replace(/[ \t ]+/g, " ")
    .replace(/ +([,.;:!?)])/g, "$1")
    .replace(/\( +/g, "(")
    .trim();
}

/** Split plain text into paragraphs (blank lines), or into ~3-sentence chunks if it's one long block. */
export function toParagraphs(text) {
  const clean = tidyText(stripHtml(String(text || "").replace(/<\/p>|<br\s*\/?>/gi, "\n\n")).replace(/ ?\n ?/g, "\n"));
  const blocks = String(text || "").includes("\n\n") || /<\/p>/i.test(text || "")
    ? tidyText(String(text).replace(/<\/p>|<br\s*\/?>/gi, "\n\n").replace(/<[^>]*>/g, " ")).split(/\n\s*\n/)
    : [clean];
  const out = [];
  for (const b of blocks.map((x) => tidyText(x)).filter(Boolean)) {
    const sentences = b.match(/[^.!?]+[.!?]+["')\]]*|[^.!?]+$/g) || [b];
    if (sentences.length <= 4) out.push(b);
    else for (let i = 0; i < sentences.length; i += 3) out.push(sentences.slice(i, i + 3).join(" ").trim());
  }
  return out;
}

/** First sentence(s) of a text, up to roughly `max` characters. */
export function excerpt(text, max = 170) {
  const t = tidyText(stripHtml(text));
  if (t.length <= max) return t;
  const sentences = t.match(/[^.!?]+[.!?]+/g) || [];
  let out = "";
  for (const s of sentences) {
    if ((out + s).length > max) break;
    out += s;
  }
  return (out || `${t.slice(0, max).replace(/\s+\S*$/, "")}…`).trim();
}
