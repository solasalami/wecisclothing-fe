-- Sign out other devices after a password change or reset: each customer session carries
-- this number, and changing the password raises it, so older sessions stop working.
-- Run once on the live database BEFORE deploying the code that uses it (signed-in pages
-- read this column). Locally, `npm run db:migrate` does the same.
ALTER TABLE customers ADD COLUMN session_version INT UNSIGNED NOT NULL DEFAULT 0 AFTER signup_nonce;
