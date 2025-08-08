#!/bin/bash
set -e

# Prepare the DB
bundle exec rails db:prepare

# Seed database from xlsx files
echo "Seeding database from xlsx files"
bundle exec rails import_databases:all
echo "Database seeded"

exec "$@"
