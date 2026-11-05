import "server-only";
import mysql from "mysql2/promise";
import { redirect } from "next/navigation";
import { headers } from "next/headers";

function createPool() {
  if (!process.env.DATABASE_URL) throw new Error("DATABASE_URL is not set");
  return mysql.createPool({
    uri: process.env.DATABASE_URL,
    connectionLimit: 5,
    waitForConnections: true,
    connectTimeout: 5000, // fail fast (default is 10s) so visitors aren't left hanging
    decimalNumbers: true,
    dateStrings: false,
    timezone: "Z",
    ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: true } : undefined,
  });
}

// Reuse one pool across hot reloads / warm serverless invocations.
const g = globalThis;
function getPool() {
  return g.__wecisPool ?? (g.__wecisPool = createPool());
}

// mysql2 never rejects queries queued for a connection when the server is unreachable,
// so during an outage we (a) cap every query with a timeout, (b) stop sending queries for a
// few seconds (circuit breaker) and (c) replace the pool, which releases anything stuck in it.
const QUERY_TIMEOUT_MS = 6000; // a little above connectTimeout
const CIRCUIT_OPEN_MS = 5000;
let circuitOpenUntil = 0;

function withTimeout(promise) {
  let timer;
  const timeout = new Promise((_, reject) => {
    timer = setTimeout(() => reject(Object.assign(new Error("Database query timed out"), { code: "ETIMEDOUT" })), QUERY_TIMEOUT_MS);
  });
  return Promise.race([promise, timeout]).finally(() => clearTimeout(timer));
}

function tripCircuit() {
  if (Date.now() < circuitOpenUntil) return;
  circuitOpenUntil = Date.now() + CIRCUIT_OPEN_MS;
  const old = g.__wecisPool;
  g.__wecisPool = null; // next query after the breaker closes gets a fresh pool
  old?.end().catch(() => {});
}

function assertCircuitClosed() {
  if (Date.now() < circuitOpenUntil) throw Object.assign(new Error("Database circuit open"), { code: "CIRCUIT_OPEN" });
}

// ---------- "database unavailable" handling ----------

const CONNECTION_ERROR_CODES = new Set([
  "ECONNREFUSED", "ENETUNREACH", "EHOSTUNREACH", "ETIMEDOUT", "ECONNRESET", "ENOTFOUND", "EAI_AGAIN", "EPIPE",
  "PROTOCOL_CONNECTION_LOST", "PROTOCOL_SEQUENCE_TIMEOUT", "POOL_CLOSED", "POOL_ENQUEUELIMIT",
  "ER_ACCESS_DENIED_ERROR", "ER_BAD_DB_ERROR", "ER_CON_COUNT_ERROR", "ER_TOO_MANY_USER_CONNECTIONS",
  "ER_SERVER_SHUTDOWN", "ER_HOST_NOT_PRIVILEGED", "ER_HOST_IS_BLOCKED", "CIRCUIT_OPEN",
]);

/** True when the error means "can't reach / use the database" rather than a bad query. */
export function isDatabaseUnavailable(err) {
  return Boolean(
    err &&
      (CONNECTION_ERROR_CODES.has(err.code) ||
        err.fatal === true ||
        /DATABASE_URL is not set|Pool is closed|Queue limit reached/i.test(err.message || ""))
  );
}

let lastLogged = 0;
function logOutage(err) {
  // One log line per 30s instead of one per query.
  if (err.code === "CIRCUIT_OPEN" || Date.now() - lastLogged < 30_000) return;
  lastLogged = Date.now();
  console.error(`[db] Database unavailable (${err.code || err.message}). Serving maintenance page.`);
}

/** Path of the page being rendered (set by src/proxy.js), so we can send visitors back after recovery. */
async function currentPath() {
  try {
    const p = (await headers()).get("x-wecis-path");
    return p && p.startsWith("/") && !p.startsWith("//") && !p.startsWith("/maintenance") ? p : "/";
  } catch {
    return "/";
  }
}

async function handle(err) {
  if (!isDatabaseUnavailable(err)) throw err;
  logOutage(err);
  tripCircuit();
  // redirect() throws; inside pages, layouts and server actions Next turns it into a redirect.
  // Route handlers that must not redirect (e.g. payment callbacks) catch it and answer 503.
  redirect(`/maintenance?from=${encodeURIComponent(await currentPath())}`);
}

export async function query(sql, params = []) {
  try {
    assertCircuitClosed();
    const [rows] = await withTimeout(getPool().query(sql, params));
    return rows;
  } catch (err) {
    return handle(err);
  }
}

export async function queryOne(sql, params = []) {
  const rows = await query(sql, params);
  return rows[0] ?? null;
}

export async function transaction(fn) {
  let conn;
  try {
    assertCircuitClosed();
    conn = await withTimeout(getPool().getConnection());
  } catch (err) {
    return handle(err);
  }
  try {
    await conn.beginTransaction();
    const result = await fn({
      query: async (sql, params = []) => (await conn.query(sql, params))[0],
    });
    await conn.commit();
    return result;
  } catch (err) {
    await conn.rollback().catch(() => {});
    if (isDatabaseUnavailable(err)) return handle(err);
    throw err;
  } finally {
    conn.release();
  }
}

/** Health check that never redirects. */
export async function ping() {
  try {
    await withTimeout(getPool().query("SELECT 1"));
    circuitOpenUntil = 0; // database is back: let normal queries through immediately
    return { ok: true };
  } catch (err) {
    return { ok: false, code: err.code || "UNKNOWN" };
  }
}

export function parseJson(value, fallback = null) {
  if (value == null) return fallback;
  if (typeof value === "object") return value; // mysql2 already parses JSON columns
  try {
    return JSON.parse(value);
  } catch {
    return fallback;
  }
}
