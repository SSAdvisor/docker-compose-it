#!/bin/bash
set -euo pipefail

# Create a directory for adjusted secrets
mkdir -p /run/secrets-adjusted

# Copy WordPress DB password and set permissions
cat /run/secrets/wordpress_db_password > /run/secrets-adjusted/wordpress_db_password
chmod 0444 /run/secrets-adjusted/wordpress_db_password
chown www-data:www-data /run/secrets-adjusted/wordpress_db_password

# Execute the default WordPress entrypoint
exec docker-entrypoint.sh "apache2-foreground"
