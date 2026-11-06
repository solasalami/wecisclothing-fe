// Usage: npm run admin:create -- "Full Name" email@example.com 'StrongPassword' [owner|staff]
import "./env.mjs";
import mysql from "mysql2/promise";
import { getDbConfig } from "../src/lib/db-config.mjs";
import bcrypt from "bcryptjs";

const [name, email, password, role = "owner"] = process.argv.slice(2);
if (!name || !email || !password || password.length < 10) {
  console.error('Usage: npm run admin:create -- "Full Name" email@example.com "password (10+ chars)" [owner|staff]');
  process.exit(1);
}
const db = await mysql.createConnection(getDbConfig());
await db.query(
  "INSERT INTO admin_users (name, email, password_hash, role) VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE name=VALUES(name), password_hash=VALUES(password_hash), role=VALUES(role), is_active=1",
  [name, email.toLowerCase(), await bcrypt.hash(password, 12), role === "staff" ? "staff" : "owner"]
);
console.log(`Admin ${email} ready (${role}).`);
await db.end();
