#!/usr/bin/env bash
# Build and run vuln-django with Nginx and PostgreSQL
set -ex
EXEC_CMD='docker-compose --file docker-micro.yml exec vuln-django'

# Build any docker images, in particular the vuln-django container
docker-compose -f docker-micro.yml build

# Launch the app container with PostgreSQL and Nginx
docker-compose -f docker-micro.yml up --detach

# Wait for the database, using netcat to ping it
echo Wait for database to become available...
while ! ${EXEC_CMD} bash -c 'nc -z "${SQL_HOST}" "${SQL_PORT}"'; do
  sleep 0.5
done
echo Database ready!

# Run database migrations to build tables
${EXEC_CMD} python manage.py migrate

# Create Django admin user using environment variables
${EXEC_CMD} python manage.py createsuperuser --no-input

# Seed database with test data
${EXEC_CMD} python manage.py seed polls --number=5

# Run unit tests
${EXEC_CMD} python manage.py test
