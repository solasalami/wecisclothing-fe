-- Emails sent to customers from Admin, Customers (shown as a history on the customer page).
-- Run once on the live database before deploying. Safe to run again (IF NOT EXISTS).
-- Locally, `npm run db:migrate` does the same.
CREATE TABLE IF NOT EXISTS customer_emails (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(190) NOT NULL,              -- customer email (registered or guest)
  subject VARCHAR(200) NOT NULL,
  body TEXT NOT NULL,
  sent_by VARCHAR(120) NULL,
  copied_to VARCHAR(190) NULL,              -- store mailbox Bcc'd on the email
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_cust_email (email, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
