-- Replace em dashes (U+2014) in store content with ", ". Safe to run more than once.
-- Run in phpMyAdmin: select the database, open SQL, paste, Go.
SET NAMES utf8mb4;
SET @d  = CONVERT(UNHEX('E28094') USING utf8mb4) COLLATE utf8mb4_unicode_ci;  -- the em dash character
SET @sd = CONCAT(' ', @d, ' ') COLLATE utf8mb4_unicode_ci;

-- Seasonal campaign announcement (exact wording)
UPDATE settings
SET value = REPLACE(value, CONCAT('packages are live', @sd, 'order early for delivery before Christmas!'), 'packages are live! Order early for delivery before Christmas.')
WHERE `key` = 'campaign';

UPDATE settings   SET value = REPLACE(REPLACE(value, @sd, ', '), @d, ', ') WHERE value LIKE CONCAT('%', @d, '%');

UPDATE categories SET name = REPLACE(REPLACE(name, @sd, ', '), @d, ', '),
                      description = REPLACE(REPLACE(description, @sd, ', '), @d, ', ')
WHERE CONCAT_WS(' ', name, description) LIKE CONCAT('%', @d, '%');

UPDATE pages SET title = REPLACE(REPLACE(title, @sd, ', '), @d, ', '),
                 body = REPLACE(REPLACE(body, @sd, ', '), @d, ', '),
                 meta_description = REPLACE(REPLACE(meta_description, @sd, ', '), @d, ', ')
WHERE CONCAT_WS(' ', title, body, meta_description) LIKE CONCAT('%', @d, '%');

UPDATE products SET name = REPLACE(REPLACE(name, @sd, ', '), @d, ', '),
                    short_description = REPLACE(REPLACE(short_description, @sd, ', '), @d, ', '),
                    description = REPLACE(REPLACE(description, @sd, ', '), @d, ', '),
                    meta_title = REPLACE(REPLACE(meta_title, @sd, ', '), @d, ', '),
                    meta_description = REPLACE(REPLACE(meta_description, @sd, ', '), @d, ', ')
WHERE CONCAT_WS(' ', name, short_description, description, meta_title, meta_description) LIKE CONCAT('%', @d, '%');

UPDATE banners SET title = REPLACE(REPLACE(title, @sd, ', '), @d, ', '),
                   subtitle = REPLACE(REPLACE(subtitle, @sd, ', '), @d, ', ')
WHERE CONCAT_WS(' ', title, subtitle) LIKE CONCAT('%', @d, '%');

UPDATE showrooms SET name = REPLACE(REPLACE(name, @sd, ', '), @d, ', '),
                     address = REPLACE(REPLACE(address, @sd, ', '), @d, ', '),
                     hours = REPLACE(REPLACE(hours, @sd, ', '), @d, ', ')
WHERE CONCAT_WS(' ', name, address, hours) LIKE CONCAT('%', @d, '%');
