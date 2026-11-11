import "server-only";
import { unstable_cache } from "next/cache";
import { runInCacheScope, outage } from "./db";

// Public storefront data changes rarely, so cache it for a few minutes across
// requests and function instances (on Netlify this is shared via the Next.js runtime).
// Every admin save calls updateTag(STORE_TAG), so edits still appear immediately.
// Never cache anything per-user or used for pricing at checkout.
export const STORE_TAG = "store";
const FIVE_MINUTES = 300;

export function cached(fn, key) {
  // Inside the cache, a database outage is a plain error (see runInCacheScope in db.js):
  // a background refresh then just keeps the cached copy. When a visitor's request had to
  // wait for it (nothing cached yet), it becomes the usual maintenance redirect here.
  const inner = unstable_cache((...args) => runInCacheScope(() => fn(...args)), ["wecis", key], { tags: [STORE_TAG], revalidate: FIVE_MINUTES });
  return async (...args) => {
    try {
      return await inner(...args);
    } catch (err) {
      if (err?.code === "DB_UNAVAILABLE_CACHED") return outage(err.dbError);
      throw err;
    }
  };
}
