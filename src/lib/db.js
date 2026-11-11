import "server-only";
import mysql from "mysql2/promise";
import { AsyncLocalStorage } from "node:async_hooks";
import { redirect } from "next/navigation";
import { headers } from "next/headers";
import { getDbConfig } from "./db-config.mjs";

// On serverless (Netlify Functions = AWS Lambda) each warm instance keeps its own pool.
// Shared hosts cap connections per user (often 10–25) and their firewalls (CSF, cPHulk,
// Imunify) can ban an IP that opens many connections in a short time. So on serverless:
//  - a tiny pool (2), but one connection is kept idle for a few seconds and reused, instead of
//    opening a new TCP + TLS + MySQL handshake for every query;
//  - a connection idle longer than IDLE_MS is never reused (the instance may have been frozen
//    while the server dropped it); it is replaced with a fresh one.
const SERVERLESS = Boolean(process.env.AWS_LAMBDA_FUNCTION_NAME || process.env.NETLIFY || process.env.VERCEL);
const envNum = (name, fallback) => (process.env[name] !== undefined && process.env[name] !== "" ? Number(process.env[name]) : fallback);
const CONNECTION_LIMIT = envNum("DB_CONNECTION_LIMIT", SERVERLESS ? 2 : 5);
const MAX_IDLE = envNum("DB_MAX_IDLE", SERVERLESS ? 1 : CONNECTION_LIMIT);
const IDLE_MS = envNum("DB_IDLE_TIMEOUT", 10_000);

// Timing budget. Netlify stops a function after 10s by default, so everything fits under that:
// up to two connect attempts of CONNECT_TIMEOUT_MS each, all inside QUERY_TIMEOUT_MS.
const CONNECT_TIMEOUT_MS = envNum("DB_CONNECT_TIMEOUT", 4000);
const QUERY_TIMEOUT_MS = envNum("DB_QUERY_TIMEOUT", 8500);

function createPool() {
  return mysql.createPool({
    ...getDbConfig(), // host/user/password/database/ssl from DB_* vars or DATABASE_URL
    connectionLimit: CONNECTION_LIMIT,
    maxIdle: MAX_IDLE,
    idleTimeout: IDLE_MS,
    enableKeepAlive: true,
    waitForConnections: true,
    queueLimit: 100,
    connectTimeout: CONNECT_TIMEOUT_MS,
    decimalNumbers: true,
    dateStrings: false,
    timezone: "Z",
  });
}

// Reuse one pool across hot reloads / warm serverless invocations.
const g = globalThis;
function getPool() {
  return g.__wecisPool ?? (g.__wecisPool = createPool());
}

/** "host:port" for log lines (never the password). */
function dbTarget() {
  try {
    const c = getDbConfig();
    return `${c.host}:${c.port}`;
  } catch {
    return "(invalid config)";
  }
}

// mysql2 never rejects queries queued for a connection when the server is unreachable,
// so during an outage we (a) cap every query with a deadline, (b) stop sending queries for a
// few seconds (circuit breaker) and (c) replace the pool, which releases anything stuck in it.
const CIRCUIT_OPEN_MS = 5000;
let circuitOpenUntil = 0;

/**
 * Run fn(state) with an overall deadline. fn updates state.phase as it goes, so a timeout
 * says what it was stuck on: "waiting for a free pool slot", "connecting" or "running query".
 */
async function withDeadline(fn) {
  const state = { phase: "connecting", attempt: 1, started: Date.now() };
  let timer;
  const timeout = new Promise((_, reject) => {
    timer = setTimeout(
      () => reject(Object.assign(new Error(`Database ${state.phase} took over ${QUERY_TIMEOUT_MS}ms`), { code: "QUERY_TIMEOUT", phase: state.phase, attempt: state.attempt, ms: Date.now() - state.started })),
      QUERY_TIMEOUT_MS
    );
  });
  try {
    return await Promise.race([fn(state), timeout]);
  } finally {
    clearTimeout(timer);
  }
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

// ---------- connections ----------

// Errors where the connection was never established, so nothing reached the server and a
// second attempt is always safe (e.g. a dropped SYN, or a firewall hiccup).
const CONNECT_RETRY_CODES = new Set(["ETIMEDOUT", "ECONNRESET", "ECONNREFUSED", "EHOSTUNREACH", "ENETUNREACH", "EPIPE", "PROTOCOL_CONNECTION_LOST"]);
// Errors meaning an established connection died. Only reads are retried after these, since a
// write may already have been applied before the connection dropped.
const LOST_CODES = new Set(["ECONNRESET", "EPIPE", "PROTOCOL_CONNECTION_LOST", "ETIMEDOUT"]);
const isRead = (sql) => /^\s*(SELECT|SHOW|DESCRIBE|EXPLAIN)\b/i.test(sql);

const LAST_USED = Symbol("wecisLastUsed");

/** Is the pool full (every connection checked out), so a request has to queue? */
function poolIsFull(pool) {
  const core = pool.pool;
  const all = core?._allConnections?.length ?? 0;
  const free = core?._freeConnections?.length ?? 0;
  return all >= CONNECTION_LIMIT && free === 0;
}

/** Get a usable connection: skips stale idle ones and retries one failed connect. */
async function acquire(state) {
  for (let stale = 0; ; ) {
    const pool = getPool();
    state.phase = poolIsFull(pool) ? "waiting for a free pool slot" : "connecting";
    const t0 = Date.now();
    let conn;
    try {
      conn = await pool.getConnection();
    } catch (err) {
      err.phase = "connecting";
      err.attempt = state.attempt;
      err.ms = Date.now() - t0;
      if (state.attempt === 1 && CONNECT_RETRY_CODES.has(err.code) && Date.now() - state.started + CONNECT_TIMEOUT_MS < QUERY_TIMEOUT_MS) {
        logRetry(err);
        state.attempt = 2;
        continue;
      }
      throw err;
    }
    const lastUsed = conn.connection[LAST_USED];
    if (lastUsed && Date.now() - lastUsed > IDLE_MS && stale < 2) {
      // Idle too long (e.g. the Lambda was frozen): the server may have closed it. Replace it.
      conn.destroy();
      stale++;
      continue;
    }
    state.phase = "running query";
    return conn;
  }
}

function done(conn, { broken = false } = {}) {
  if (!conn) return;
  if (broken) {
    conn.destroy();
    return;
  }
  conn.connection[LAST_USED] = Date.now();
  conn.release();
}

/** Run one statement. A read that loses its connection mid-way is retried once on a fresh one. */
async function run(sql, params, state) {
  const conn = await acquire(state);
  try {
    const [rows] = await conn.query(sql, params);
    done(conn);
    return rows;
  } catch (err) {
    const lost = LOST_CODES.has(err.code) || err.fatal === true;
    done(conn, { broken: lost });
    if (!lost || !isRead(sql) || state.retriedLost) throw err;
    state.retriedLost = true;
    logRetry(Object.assign(err, { phase: "running query", ms: Date.now() - state.started }));
    return run(sql, params, state);
  }
}

// ---------- "database unavailable" handling ----------

const CONNECTION_ERROR_CODES = new Set([
  "ECONNREFUSED", "ENETUNREACH", "EHOSTUNREACH", "ETIMEDOUT", "ECONNRESET", "ENOTFOUND", "EAI_AGAIN", "EPIPE",
  "PROTOCOL_CONNECTION_LOST", "PROTOCOL_SEQUENCE_TIMEOUT", "POOL_CLOSED", "POOL_ENQUEUELIMIT",
  "ER_ACCESS_DENIED_ERROR", "ER_BAD_DB_ERROR", "ER_CON_COUNT_ERROR", "ER_TOO_MANY_USER_CONNECTIONS",
  "ER_SERVER_SHUTDOWN", "ER_HOST_NOT_PRIVILEGED", "ER_HOST_IS_BLOCKED", "CIRCUIT_OPEN", "DB_CONFIG", "QUERY_TIMEOUT",
]);

/** True when the error means "can't reach / use the database" rather than a bad query. */
export function isDatabaseUnavailable(err) {
  // A query that connected fine but ran too long is a slow page, not an outage: the database
  // answers health checks, so the maintenance page would bounce the visitor straight back to
  // the same slow page ("too many redirects"). Let it fail as a normal error instead.
  if (err?.code === "QUERY_TIMEOUT" && err.phase === "running query") return false;
  return Boolean(
    err &&
      (CONNECTION_ERROR_CODES.has(err.code) ||
        err.fatal === true ||
        /DATABASE_URL is not set|Pool is closed|Queue limit reached/i.test(err.message || ""))
  );
}

/** e.g. "ETIMEDOUT while connecting, attempt 2, after 4003ms, to db.example.com:3306" */
function describe(err) {
  if (err.code === "DB_CONFIG") return `configuration error: ${err.message}`;
  const parts = [err.code || err.message];
  if (err.phase) parts.push(`while ${err.phase}`);
  if (err.attempt) parts.push(`attempt ${err.attempt}`);
  if (err.ms != null) parts.push(`after ${err.ms}ms`);
  parts.push(`to ${dbTarget()}`);
  return parts.join(", ");
}

let lastLogged = 0;
function logOutage(err) {
  // One log line per 30s instead of one per query.
  if (err.code === "CIRCUIT_OPEN" || Date.now() - lastLogged < 30_000) return;
  lastLogged = Date.now();
  console.error(`[db] Database unavailable (${describe(err)}). Serving maintenance page.`);
}

let lastRetryLogged = 0;
function logRetry(err) {
  // Recovered hiccups are worth seeing too (a pattern of them points at a firewall), but rate-limited.
  if (Date.now() - lastRetryLogged < 30_000) return;
  lastRetryLogged = Date.now();
  console.warn(`[db] ${describe(err)}; retrying once.`);
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

// An attempt can't legitimately last much longer than the deadline. When it has, the
// function was frozen mid-attempt: on Netlify (AWS Lambda) the process is paused as soon as
// the response is sent, which catches background work such as the 5-minute cache refresh
// (unstable_cache revalidates after responding). When the next request thaws it, its
// timers fire at once with a huge elapsed time ("ETIMEDOUT ... after 48395ms").
// That says nothing about the database now, so it must not open the circuit breaker
// (which would push the current, healthy request to the maintenance page) or redirect.
const FROZEN_MS = QUERY_TIMEOUT_MS + 3000;

let lastFrozenLogged = 0;
function staleAttempt(err, startedAt) {
  if (Date.now() - startedAt < FROZEN_MS) return false;
  if (Date.now() - lastFrozenLogged > 30_000) {
    lastFrozenLogged = Date.now();
    console.warn(`[db] Ignored a stale attempt from a paused function (${describe(err)}). Not an outage.`);
  }
  return true;
}

// Set while running inside a cached function (src/lib/cache.js). There a failure must not
// redirect: during the background refresh of the cache there is no visitor to redirect
// (Next only logs "Error: NEXT_REDIRECT ... /maintenance?from=/"), and it must not open the
// circuit breaker for the visitors who are being served fine from the cache.
const cacheScope = new AsyncLocalStorage();
export const runInCacheScope = (fn) => cacheScope.run(true, fn);

let lastCachedLogged = 0;

async function handle(err, startedAt = Date.now()) {
  if (!isDatabaseUnavailable(err)) throw err;
  // Thrown as a plain error: a background cache refresh just keeps the cached data.
  if (staleAttempt(err, startedAt)) throw err;
  if (cacheScope.getStore()) {
    if (Date.now() - lastCachedLogged > 30_000) {
      lastCachedLogged = Date.now();
      console.warn(`[db] Cached data refresh failed (${describe(err)}); keeping the cached copy.`);
    }
    // cached() in src/lib/cache.js turns this back into the maintenance redirect when a
    // visitor's request was waiting on it (nothing cached yet).
    throw Object.assign(new Error(`Database unavailable during cache refresh: ${describe(err)}`), { code: "DB_UNAVAILABLE_CACHED", dbError: err });
  }
  return outage(err);
}

/** Database outage on a visitor's request: log, pause queries briefly, show the maintenance page. */
export async function outage(err) {
  logOutage(err);
  tripCircuit();
  // redirect() throws; inside pages, layouts and server actions Next turns it into a redirect.
  // Route handlers that must not redirect (e.g. payment callbacks) catch it and answer 503.
  redirect(`/maintenance?from=${encodeURIComponent(await currentPath())}`);
}

// "Too many connections" is usually momentary contention, not an outage: retry briefly first.
const BUSY_CODES = new Set(["ER_TOO_MANY_USER_CONNECTIONS", "ER_CON_COUNT_ERROR"]);
const BUSY_RETRY_DELAYS_MS = [150, 400, 900];
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function withBusyRetry(fn) {
  for (let attempt = 0; ; attempt++) {
    try {
      return await fn();
    } catch (err) {
      if (!BUSY_CODES.has(err?.code) || attempt >= BUSY_RETRY_DELAYS_MS.length) throw err;
      await sleep(BUSY_RETRY_DELAYS_MS[attempt]);
    }
  }
}

export async function query(sql, params = []) {
  const startedAt = Date.now();
  try {
    assertCircuitClosed();
    return await withDeadline((state) => withBusyRetry(() => run(sql, params, state)));
  } catch (err) {
    return handle(err, startedAt);
  }
}

export async function queryOne(sql, params = []) {
  const rows = await query(sql, params);
  return rows[0] ?? null;
}

export async function transaction(fn) {
  const startedAt = Date.now();
  let conn;
  try {
    assertCircuitClosed();
    conn = await withDeadline((state) => withBusyRetry(() => acquire(state)));
  } catch (err) {
    return handle(err, startedAt);
  }
  let broken = false;
  try {
    await conn.beginTransaction();
    const result = await fn({
      query: async (sql, params = []) => (await conn.query(sql, params))[0],
    });
    await conn.commit();
    return result;
  } catch (err) {
    broken = LOST_CODES.has(err?.code) || err?.fatal === true;
    await conn.rollback().catch(() => {});
    if (isDatabaseUnavailable(err)) return handle(err, startedAt);
    throw err;
  } finally {
    done(conn, { broken });
  }
}

/** Health check that never redirects. */
export async function ping() {
  try {
    await withDeadline((state) => run("SELECT 1", [], state));
    circuitOpenUntil = 0; // database is back: let normal queries through immediately
    return { ok: true };
  } catch (err) {
    logOutage(err); // rate-limited; gives uptime-monitor failures a cause in the function logs
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
