// Prints an INSERT statement for an admin user, to paste into phpMyAdmin → SQL.
// Usage: npm run admin:sql -- "Full Name" you@wecisclothing.com 'a-strong-password' [owner|staff]
import bcrypt from "bcryptjs";

const [name, email, password, role = "owner"] = process.argv.slice(2);
if (!name || !email || !password || password.length < 10) {
  console.error('Usage: npm run admin:sql -- "Full Name" you@example.com "password (10+ chars)" [owner|staff]');
  process.exit(1);
}
const q = (s) => `'${String(s).replace(/\\/g, "\\\\").replace(/'/g, "''")}'`;
const hash = await bcrypt.hash(password, 12);
console.log(
  `INSERT INTO admin_users (name, email, password_hash, role, is_active) VALUES (${q(name)}, ${q(email.toLowerCase())}, ${q(hash)}, ${q(
    role === "staff" ? "staff" : "owner"
  )}, 1)\n  ON DUPLICATE KEY UPDATE name = VALUES(name), password_hash = VALUES(password_hash), role = VALUES(role), is_active = 1;`
);
