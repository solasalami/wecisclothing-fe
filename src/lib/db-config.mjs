// MySQL connection settings, shared by the app (src/lib/db.js) and the CLI scripts.
//
// Option A (recommended, no escaping needed):
//   DB_HOST, DB_PORT (default 3306), DB_USER, DB_PASSWORD, DB_NAME
// Option B: DATABASE_URL=mysql://USER:PASSWORD@HOST:3306/DBNAME
//   Special characters in the password (? # @ / % : etc.) should be URL-encoded,
//   but raw ones are tolerated: the password is everything between the first ":"
//   after the user and the LAST "@" before the host.
// DATABASE_SSL=true enables TLS (most hosted databases).

function safeDecode(s) {
  try {
    return decodeURIComponent(s);
  } catch {
    return s; // contains a raw "%" that isn't an escape: use as-is
  }
}

export function maskUrl(url) {
  return String(url || "").replace(/(\/\/[^:/@]+:)(.*)@(?=[^@]*$)/, "$1****@");
}

function configError(message) {
  return Object.assign(new Error(message), { code: "DB_CONFIG" });
}

/** Parse a mysql:// URL without choking on unencoded characters in the password. */
export function parseDatabaseUrl(url) {
  const m = /^mysql2?:\/\/(.*)$/i.exec(String(url).trim());
  if (!m) throw configError(`DATABASE_URL must start with mysql:// (got "${maskUrl(url).slice(0, 12)}…")`);
  const rest = m[1];
  const at = rest.lastIndexOf("@");
  if (at === -1) throw configError(`DATABASE_URL has no "@": expected mysql://USER:PASSWORD@HOST:3306/DBNAME (got ${maskUrl(url)})`);
  const creds = rest.slice(0, at);
  const target = rest.slice(at + 1);
  const colon = creds.indexOf(":");
  const user = safeDecode(colon === -1 ? creds : creds.slice(0, colon));
  const password = colon === -1 ? "" : safeDecode(creds.slice(colon + 1));
  const tm = /^([^/:?#]+)(?::(\d+))?\/([^?#]+)/.exec(target);
  if (!tm) throw configError(`DATABASE_URL host/database part is invalid: expected HOST:3306/DBNAME (got ${maskUrl(url)})`);
  return { host: tm[1], port: tm[2] ? Number(tm[2]) : 3306, user, password, database: safeDecode(tm[3]) };
}

export function getDbConfig(env = process.env) {
  let conn;
  if (env.DB_HOST) {
    if (!env.DB_USER || !env.DB_NAME) throw configError("DB_HOST is set, so DB_USER and DB_NAME are required too");
    conn = { host: env.DB_HOST, port: Number(env.DB_PORT || 3306), user: env.DB_USER, password: env.DB_PASSWORD || "", database: env.DB_NAME };
  } else if (env.DATABASE_URL) {
    conn = parseDatabaseUrl(env.DATABASE_URL);
  } else {
    throw configError("No database configured: set DB_HOST/DB_USER/DB_PASSWORD/DB_NAME or DATABASE_URL");
  }
  return {
    ...conn,
    ssl: env.DATABASE_SSL === "true" ? { rejectUnauthorized: env.DATABASE_SSL_ALLOW_SELF_SIGNED !== "true" } : undefined,
  };
}

/** Human-readable target for logs (never includes the password). */
export function describeDb(env = process.env) {
  try {
    const c = getDbConfig(env);
    return `${c.user}@${c.host}:${c.port}/${c.database}`;
  } catch (e) {
    return `(invalid: ${e.message})`;
  }
}
