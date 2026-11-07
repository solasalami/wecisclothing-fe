// Browser-only: shrink an image before it is uploaded.
//
// Netlify rejects function requests over about 6 MB before our code runs (a 400
// with nothing in the logs), and designers' banners are often 5 MB+ PNGs at
// 7500px. Nothing on the site is shown wider than ~2400px, so we resize to that
// and re-encode as WebP (JPEG where the browser can't make WebP).

export const MAX_EDGE = 2400; // px, longest side
const QUALITY = 0.86;
const SKIP_BELOW = 600 * 1024; // already small and web-sized: leave it alone

function loadImage(file) {
  return new Promise((resolve, reject) => {
    const url = URL.createObjectURL(file);
    const img = new Image();
    img.onload = () => resolve({ img, url });
    img.onerror = () => {
      URL.revokeObjectURL(url);
      reject(new Error("Could not read image"));
    };
    img.src = url;
  });
}

const toBlob = (canvas, type, quality) => new Promise((resolve) => canvas.toBlob(resolve, type, quality));

/** Returns a smaller File, or the original if it is already small or can't be processed. */
export async function optimizeImage(file) {
  if (typeof document === "undefined" || !file?.type?.startsWith("image/") || file.type === "image/gif") return file;
  let loaded;
  try {
    loaded = await loadImage(file);
  } catch {
    return file;
  }
  const { img, url } = loaded;
  try {
    const { naturalWidth: w, naturalHeight: h } = img;
    const scale = Math.min(1, MAX_EDGE / Math.max(w, h));
    if (scale === 1 && file.size <= SKIP_BELOW) return file;

    const canvas = document.createElement("canvas");
    canvas.width = Math.round(w * scale);
    canvas.height = Math.round(h * scale);
    const ctx = canvas.getContext("2d");
    ctx.imageSmoothingQuality = "high";
    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

    let blob = await toBlob(canvas, "image/webp", QUALITY);
    if (!blob || blob.type !== "image/webp") blob = await toBlob(canvas, "image/jpeg", QUALITY); // e.g. older Safari
    if (!blob || blob.size >= file.size) return file; // no gain: keep the original

    const ext = blob.type === "image/webp" ? "webp" : "jpg";
    const name = file.name.replace(/\.[^.]+$/, "") + `.${ext}`;
    return new File([blob], name, { type: blob.type, lastModified: Date.now() });
  } finally {
    URL.revokeObjectURL(url);
  }
}

/** Total bytes of all files currently chosen in a form's file inputs. */
export function formUploadBytes(form) {
  let total = 0;
  for (const input of form.querySelectorAll('input[type="file"]')) {
    for (const f of input.files || []) total += f.size;
  }
  return total;
}

// Netlify's ~6 MB request limit includes encoding overhead and the other fields.
export const MAX_FORM_UPLOAD = 4.5 * 1024 * 1024;
