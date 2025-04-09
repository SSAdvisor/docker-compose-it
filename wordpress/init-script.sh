#!/bin/bash

# Check if mysql-client is installed
if ! command -v mysql >/dev/null 2>&1; then
    echo "MySQL client not found. Installing..."
    
    # Update package list and install mysql-client
    apt-get update && \
    apt-get install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*
    
    echo "MySQL client installed successfully."
else
    echo "MySQL client is already installed."
fi

# Read the secret value from Docker secrets
DB_PASSWORD=$(cat /run/secrets/wordpress_db_password)

# Replace placeholder in SQL file with the actual password
SQL_FILE="/docker-entrypoint-initdb.d/01-create-database.sql"
TEMP_SQL_FILE="/tmp/processed-create-database.sql"

sed "s/{{WORDPRESS_DB_PASSWORD}}/$DB_PASSWORD/g" $SQL_FILE > $TEMP_SQL_FILE

MYSQL_HOST="mysql"
MYSQL_USER="root"
MYSQL_PASSWORD=$(cat /run/secrets/mysql_root_password)
SQL_FILE="/docker-entrypoint-initdb.d/01-create-database.sql"

echo "Executing SQL script..."
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD < $TEMP_SQL_FILE
echo "SQL script executed successfully."

# Clean up temporary file
rm -f $TEMP_SQL_FILE
