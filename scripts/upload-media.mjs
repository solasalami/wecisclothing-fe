// Copies local images (./.uploads) to Netlify Blobs (store "media") using the same keys,
// so the /media/... URLs stored in the database work on the live site.
// Usage:
//   Put NETLIFY_SITE_ID and NETLIFY_AUTH_TOKEN in .env.local (git-ignored), then: npm run media:upload
//   (or pass them inline: NETLIFY_SITE_ID=... NETLIFY_AUTH_TOKEN=... npm run media:upload)
//   add `-- --dry-run` to list what would be uploaded.
import "./env.mjs"; // loads NETLIFY_SITE_ID / NETLIFY_AUTH_TOKEN from .env.local if present
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
// Retry each file a few times; keep going on failures and report them at the end.
async function withRetry(fn, attempts = 3) {
  for (let i = 1; ; i++) {
    try {
      return await fn();
    } catch (err) {
      if (i >= attempts) throw err;
      await new Promise((r) => setTimeout(r, 1000 * i));
    }
  }
}

let done = 0;
const failed = [];
for (const file of files) {
  const key = path.relative(ROOT, file).split(path.sep).join("/");
  const type = TYPES[path.extname(file).toLowerCase()];
  try {
    await withRetry(() => store.set(key, new Blob([fs.readFileSync(file)], { type }), { metadata: { contentType: type } }));
    console.log(`  ✓ ${key}`);
    done++;
  } catch (err) {
    const reason = err?.cause?.code || err?.code || err?.message || String(err);
    console.log(`  ✗ ${key}  (${reason})`);
    failed.push(key);
    if (done === 0 && failed.length === 3) {
      console.error("\nCan't reach Netlify (first 3 uploads failed). Check your internet connection / VPN / firewall,");
      console.error("and run this from your own terminal, not a sandboxed shell. Your token was not rejected.");
      process.exit(1);
    }
  }
}
console.log(`\nUploaded ${done} of ${files.length} image(s) to Netlify Blobs (store "media").`);
if (failed.length) {
  console.log(`${failed.length} failed. Re-run \`npm run media:upload\` to retry (re-uploading is safe).`);
  process.exit(1);
}
