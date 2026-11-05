import { getFile } from "@/lib/storage";

export const dynamic = "force-dynamic";

// Serves uploaded images from Netlify Blobs (prod) or ./.uploads (dev).
export async function GET(_req, { params }) {
  const { key } = await params;
  let file;
  try {
    file = await getFile(key.map(decodeURIComponent).join("/"));
  } catch {
    file = null;
  }
  if (!file) return new Response("Not found", { status: 404 });
  return new Response(file.data, {
    headers: {
      "Content-Type": file.contentType,
      // Keys are content-unique (UUIDs) so they can be cached forever.
      "Cache-Control": "public, max-age=31536000, immutable",
      "Netlify-CDN-Cache-Control": "public, max-age=31536000, immutable",
      "X-Content-Type-Options": "nosniff",
    },
  });
}
