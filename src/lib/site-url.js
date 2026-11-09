// The public address of the site, for redirects from route handlers.
//
// Don't build redirects from request.url in route handlers: on Netlify it is the internal
// deploy address (https://<deploy-id>--<site>.netlify.app), which is not the shop's domain
// (and doesn't respond to visitors), so shoppers would be sent off-site.

const env = (n) => (process.env[n] || "").trim();

/** e.g. https://wecisclothing.com (no trailing slash). */
export function publicOrigin(request) {
  const configured = env("NEXT_PUBLIC_SITE_URL") || env("URL");
  if (configured) return configured.replace(/\/$/, "");
  return new URL(request.url).origin; // local dev without NEXT_PUBLIC_SITE_URL
}

/** Absolute URL on the public site for a path like "/cart?x=1". */
export function publicUrl(path, request) {
  return new URL(path, `${publicOrigin(request)}/`);
}
