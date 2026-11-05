// Usage: npm run db:migrate   — applies db/schema.sql (idempotent)
import "./env.mjs";
import fs from "node:fs";
import mysql from "mysql2/promise";

const conn = await mysql.createConnection({
  uri: process.env.DATABASE_URL,
  multipleStatements: true,
  ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: true } : undefined,
});
await conn.query(fs.readFileSync(new URL("../db/schema.sql", import.meta.url), "utf8"));
console.log("Schema applied.");
await conn.end();
