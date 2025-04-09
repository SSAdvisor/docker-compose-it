CREATE DATABASE IF NOT EXISTS wordpress_db;  -- Creates database only if missing[2]
CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY '{{WORDPRESS_DB_PASSWORD}}';  -- Creates user if missing[4][6]
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress'@'%';  -- Always update privileges[1]
FLUSH PRIVILEGES;  -- Ensure changes take effect immediately
