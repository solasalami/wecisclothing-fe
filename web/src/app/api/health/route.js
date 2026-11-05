import { ping } from "@/lib/db";

export const dynamic = "force-dynamic";

// Uptime/health check: 200 when the database answers, 503 when it doesn't.
// Used by the maintenance page to detect recovery; point an uptime monitor at it too.
export async function GET() {
  const db = await ping();
  return Response.json(
    { status: db.ok ? "ok" : "degraded", database: db.ok ? "up" : "down", time: new Date().toISOString() },
    { status: db.ok ? 200 : 503, headers: { "Cache-Control": "no-store" } }
  );
}
