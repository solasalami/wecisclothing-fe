import "server-only";
import mysql from "mysql2/promise";

function createPool() {
  if (!process.env.DATABASE_URL) throw new Error("DATABASE_URL is not set");
  return mysql.createPool({
    uri: process.env.DATABASE_URL,
    connectionLimit: 5,
    waitForConnections: true,
    decimalNumbers: true,
    dateStrings: false,
    timezone: "Z",
    ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: true } : undefined,
  });
}

// Reuse one pool across hot reloads / warm serverless invocations.
const g = globalThis;
export const pool = g.__wecisPool ?? (g.__wecisPool = createPool());

export async function query(sql, params = []) {
  const [rows] = await pool.query(sql, params);
  return rows;
}

export async function queryOne(sql, params = []) {
  const rows = await query(sql, params);
  return rows[0] ?? null;
}

export async function transaction(fn) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const result = await fn({
      query: async (sql, params = []) => (await conn.query(sql, params))[0],
    });
    await conn.commit();
    return result;
  } catch (err) {
    await conn.rollback();
    throw err;
  } finally {
    conn.release();
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
