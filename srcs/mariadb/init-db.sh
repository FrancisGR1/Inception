#!/bin/sh

# Use env vars if provided, fallback to defaults
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-mysql_root_password}"
MYSQL_DATABASE="${MYSQL_DATABASE:-mysql_database}"
MYSQL_USER="${MYSQL_USER:-mysql_user}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-mysql_password}"

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initialize database"
  mariadb-install-db --user=mysql --ldata=/var/lib/mysql

  echo "Starting MariaDB temporarily"
  /usr/bin/mariadbd --user=mysql --skip-networking=0 --socket=/run/mysqld/mysqld.sock &
  pid="$!"

  echo "Waiting for MariaDB to be ready"
  until mariadb-admin ping --socket=/run/mysqld/mysqld.sock --silent; do
    sleep 1
  done

  echo "Configuring root + creating database/user"
  mariadb --socket=/run/mysqld/mysqld.sock <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  echo "Stopping temporary MariaDB"
  mariadb-admin --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

  wait "$pid"

  echo "Database initialized!"
else
  echo "Database already exists!"
fi

echo "Starting MariaDB service: exec /usr/bin/mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0"
exec /usr/bin/mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0
