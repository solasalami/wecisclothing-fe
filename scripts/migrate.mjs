// Usage: npm run db:migrate   (applies db/schema.sql, idempotent)
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
const columns = [
  ["products", "badge", "VARCHAR(40) NULL AFTER is_featured"],
  ["products", "vat_inclusive", "TINYINT(1) NOT NULL DEFAULT 0 AFTER compare_at_price"],
  ["orders", "vat_rate", "DECIMAL(5,2) NOT NULL DEFAULT 0 AFTER subtotal"],
  ["orders", "vat_added", "DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_rate"],
  ["orders", "vat_included", "DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_added"],
  ["order_items", "vat_inclusive", "TINYINT(1) NOT NULL DEFAULT 0 AFTER line_total"],
  ["order_items", "vat_amount", "DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER vat_inclusive"],
  ["customers", "email_verified_at", "DATETIME NULL AFTER password_hash"],
  ["customers", "signup_nonce", "CHAR(32) NULL UNIQUE AFTER email_verified_at"],
  ["customers", "session_version", "INT UNSIGNED NOT NULL DEFAULT 0 AFTER signup_nonce"],
];
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
