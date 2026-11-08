-- Contact form messages (/contact-us). Run once on the live database in phpMyAdmin
-- before deploying the contact form. (Locally, `npm run db:migrate` does the same.)
CREATE TABLE IF NOT EXISTS contact_messages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(190) NOT NULL,
  phone VARCHAR(40) NULL,
  topic VARCHAR(60) NOT NULL,
  message TEXT NOT NULL,
  ip VARCHAR(64) NULL,
  user_agent VARCHAR(255) NULL,
  nonce CHAR(32) NOT NULL UNIQUE,
  read_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_msg_created (created_at),
  KEY idx_msg_ip (ip, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Replies sent from Admin, Messages (each also Bcc'd to the store mailbox).
CREATE TABLE IF NOT EXISTS contact_replies (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  message_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  sent_by VARCHAR(120) NULL,
  sent_to VARCHAR(190) NOT NULL,
  copied_to VARCHAR(190) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_reply_msg (message_id, created_at),
  CONSTRAINT fk_reply_msg FOREIGN KEY (message_id) REFERENCES contact_messages(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
