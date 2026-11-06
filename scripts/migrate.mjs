// Usage: npm run db:migrate   — applies db/schema.sql (idempotent)
import "./env.mjs";
import fs from "node:fs";
import mysql from "mysql2/promise";
import { getDbConfig } from "../src/lib/db-config.mjs";

const conn = await mysql.createConnection({
  ...getDbConfig(),
  multipleStatements: true,
});
await conn.query(fs.readFileSync(new URL("../db/schema.sql", import.meta.url), "utf8"));

// Additive column migrations for databases created by an earlier schema version.
const columns = [["products", "badge", "VARCHAR(40) NULL AFTER is_featured"]];
for (const [table, column, definition] of columns) {
  const [rows] = await conn.query(
    "SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND COLUMN_NAME = ?",
    [table, column]
  );
  if (!rows.length) {
    await conn.query(`ALTER TABLE ${table} ADD COLUMN ${column} ${definition}`);
    console.log(`Added ${table}.${column}`);
  }
}
console.log("Schema applied.");
await conn.end();
