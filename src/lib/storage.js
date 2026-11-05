import "server-only";
import fs from "node:fs/promises";
import path from "node:path";
import crypto from "node:crypto";

// Images are stored in Netlify Blobs in production (store "media") and on the
// local filesystem in development. Either way they are served by /media/[...key].
const STORE = "media";
const LOCAL_DIR = path.join(process.cwd(), ".uploads");

function driver() {
  return process.env.STORAGE_DRIVER || (process.env.NETLIFY ? "blobs" : "local");
}

async function blobStore() {
  const { getStore } = await import("@netlify/blobs");
  // On Netlify the site ID/token are injected automatically. For scripts run
  // outside Netlify, set NETLIFY_SITE_ID and NETLIFY_AUTH_TOKEN.
  const opts = { name: STORE, consistency: "strong" };
  if (process.env.NETLIFY_SITE_ID && process.env.NETLIFY_AUTH_TOKEN) {
    opts.siteID = process.env.NETLIFY_SITE_ID;
    opts.token = process.env.NETLIFY_AUTH_TOKEN;
  }
  return getStore(opts);
}

const TYPES = {
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".png": "image/png",
  ".webp": "image/webp",
  ".gif": "image/gif",
  ".avif": "image/avif",
  ".svg": "image/svg+xml",
};

export function contentTypeFor(key) {
  return TYPES[path.extname(key).toLowerCase()] || "application/octet-stream";
}

export function safeKey(key) {
  const clean = String(key)
    .split("/")
    .filter((p) => p && p !== "." && p !== "..")
    .join("/");
  if (!clean) throw new Error("Invalid key");
  return clean;
}

export async function putFile(key, data, contentType) {
  key = safeKey(key);
  const buf = Buffer.isBuffer(data) ? data : Buffer.from(data);
  if (driver() === "blobs") {
    const store = await blobStore();
    await store.set(key, new Blob([buf], { type: contentType || contentTypeFor(key) }), {
      metadata: { contentType: contentType || contentTypeFor(key) },
    });
  } else {
    const file = path.join(LOCAL_DIR, key);
    await fs.mkdir(path.dirname(file), { recursive: true });
    await fs.writeFile(file, buf);
  }
  return `/media/${key}`;
}

export async function getFile(key) {
  key = safeKey(key);
  if (driver() === "blobs") {
    const store = await blobStore();
    const res = await store.getWithMetadata(key, { type: "arrayBuffer" });
    if (!res) return null;
    return { data: Buffer.from(res.data), contentType: res.metadata?.contentType || contentTypeFor(key) };
  }
  try {
    const data = await fs.readFile(path.join(LOCAL_DIR, key));
    return { data, contentType: contentTypeFor(key) };
  } catch {
    return null;
  }
}

export async function deleteFile(urlOrKey) {
  const key = safeKey(String(urlOrKey).replace(/^\/media\//, ""));
  if (driver() === "blobs") {
    const store = await blobStore();
    await store.delete(key);
  } else {
    await fs.rm(path.join(LOCAL_DIR, key), { force: true });
  }
}

const ALLOWED = new Set(["image/jpeg", "image/png", "image/webp", "image/gif", "image/avif"]);
const MAX_BYTES = 8 * 1024 * 1024;

/** Store an uploaded File (from FormData). Returns its public URL. */
export async function saveUpload(file, folder = "uploads") {
  if (!file || typeof file === "string" || file.size === 0) return null;
  if (!ALLOWED.has(file.type)) throw new Error(`Unsupported image type: ${file.type}`);
  if (file.size > MAX_BYTES) throw new Error("Image is larger than 8MB");
  const ext = { "image/jpeg": ".jpg", "image/png": ".png", "image/webp": ".webp", "image/gif": ".gif", "image/avif": ".avif" }[file.type];
  const key = `${folder}/${new Date().toISOString().slice(0, 7)}/${crypto.randomUUID()}${ext}`;
  return putFile(key, Buffer.from(await file.arrayBuffer()), file.type);
}
