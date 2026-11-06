// Copies local images (./.uploads) to Netlify Blobs (store "media") using the same keys,
// so the /media/... URLs stored in the database work on the live site.
// Usage:
//   NETLIFY_SITE_ID=<site id> NETLIFY_AUTH_TOKEN=<personal access token> npm run media:upload
//   add `-- --dry-run` to list what would be uploaded.
import fs from "node:fs";
import path from "node:path";
import { getStore } from "@netlify/blobs";

const ROOT = path.join(process.cwd(), ".uploads");
const dryRun = process.argv.includes("--dry-run");
const TYPES = { ".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".png": "image/png", ".webp": "image/webp", ".gif": "image/gif", ".avif": "image/avif" };

function walk(dir) {
  return fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => {
    const p = path.join(dir, e.name);
    return e.isDirectory() ? walk(p) : [p];
  });
}

if (!fs.existsSync(ROOT)) {
  console.error("No ./.uploads folder found.");
  process.exit(1);
}
const files = walk(ROOT).filter((f) => TYPES[path.extname(f).toLowerCase()]);
console.log(`${files.length} image(s) found in .uploads`);
if (dryRun) {
  files.forEach((f) => console.log("  ", path.relative(ROOT, f)));
  process.exit(0);
}
if (!process.env.NETLIFY_SITE_ID || !process.env.NETLIFY_AUTH_TOKEN) {
  console.error("Set NETLIFY_SITE_ID and NETLIFY_AUTH_TOKEN (Netlify → User settings → Applications → Personal access tokens).");
  process.exit(1);
}
const store = getStore({ name: "media", siteID: process.env.NETLIFY_SITE_ID, token: process.env.NETLIFY_AUTH_TOKEN });
let done = 0;
for (const file of files) {
  const key = path.relative(ROOT, file).split(path.sep).join("/");
  const type = TYPES[path.extname(file).toLowerCase()];
  await store.set(key, new Blob([fs.readFileSync(file)], { type }), { metadata: { contentType: type } });
  console.log(`  ✓ ${key}`);
  done++;
}
console.log(`Uploaded ${done} image(s) to Netlify Blobs (store "media").`);
