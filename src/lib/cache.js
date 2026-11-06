import "server-only";
import { unstable_cache } from "next/cache";

// Public storefront data changes rarely, so cache it for a few minutes across
// requests and function instances (on Netlify this is shared via the Next.js runtime).
// Every admin save calls updateTag(STORE_TAG), so edits still appear immediately.
// Never cache anything per-user or used for pricing at checkout.
export const STORE_TAG = "store";
const FIVE_MINUTES = 300;

export function cached(fn, key) {
  return unstable_cache(fn, ["wecis", key], { tags: [STORE_TAG], revalidate: FIVE_MINUTES });
}
