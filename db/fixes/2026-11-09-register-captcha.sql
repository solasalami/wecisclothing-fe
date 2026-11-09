-- Spam check on Create account (/account/register): each solved question can create
-- only one account. Run once on the live database in phpMyAdmin before deploying.
-- (Locally, `npm run db:migrate` does the same.)
ALTER TABLE customers ADD COLUMN signup_nonce CHAR(32) NULL UNIQUE AFTER email_verified_at;
