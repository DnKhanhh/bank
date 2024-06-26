#!/bin/sh
set -e

echo "run db migration"
echo "DB_SOURCE before: $DB_SOURCE"

source /app/app.env

echo "DB_SOURCE after: $DB_SOURCE"
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"