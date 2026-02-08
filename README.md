# PostgreSQL Docker Container

A PostgreSQL database container using Bitnami's PostgreSQL image with enhanced logging and Coolify integration. Based on the official Bitnami PostgreSQL image — [reference the docs](https://github.com/bitnami/containers/blob/main/bitnami/postgresql/README.md) for the full feature and environment variables list.

## Features

- SCRAM-SHA-256 password encryption
- Connection logging (connections/disconnections)
- Audit logging for read/write operations (pgAudit)
- Configurable connection limits and timeouts
- Persistent data storage
- Coolify-compatible service labels
- Configurable port mapping

## Prerequisites

- Docker and Docker Compose installed

## Environment Variables

Create a `.env` file with the following variables:

```ini
POSTGRESQL_USERNAME=your_username
POSTGRESQL_PASSWORD=your_password
POSTGRESQL_POSTGRES_PASSWORD=postgres_superuser_password
POSTGRESQL_STATEMENT_TIMEOUT=30000
POSTGRESQL_MAX_CONNECTIONS=100
POSTGRESQL_USERNAME_CONNECTION_LIMIT=10
POSTGRESQL_PGHBA_REMOVE_FILTERS=trust,peer
POSTGRESQL_ALLOW_REMOTE_CONNECTIONS=yes
PORT=5432
```

## Quick Start

1. Create a `.env` file with your configuration
2. Run the container:

```bash
docker-compose up -d
```

## Configuration Options

### Security

- `POSTGRESQL_PASSWORD_ENCRYPTION`: Password encryption method (default: scram-sha-256)
- `POSTGRESQL_PGHBA_REMOVE_FILTERS`: Remove unsafe auth methods from pg_hba.conf (default: trust,peer)
- `POSTGRESQL_ALLOW_REMOTE_CONNECTIONS`: Allow connections from outside the container (default: yes)

### Logging

- `POSTGRESQL_LOG_CONNECTIONS`: Log connection attempts (default: yes)
- `POSTGRESQL_LOG_DISCONNECTIONS`: Log disconnections (default: yes)
- `POSTGRESQL_PGAUDIT_LOG`: Audit log settings (default: read,write)
- `POSTGRESQL_CLIENT_MIN_MESSAGES`: Minimum message severity sent to the client (default: error)
- `POSTGRESQL_LOG_TIMEZONE`: Timezone for log timestamps (default: UTC)

### Performance

- `POSTGRESQL_STATEMENT_TIMEOUT`: SQL query timeout in milliseconds (default: 30000)
- `POSTGRESQL_MAX_CONNECTIONS`: Maximum database connections (default: 100)
- `POSTGRESQL_USERNAME_CONNECTION_LIMIT`: Connections per user (default: 10)

### Network

- `PORT`: Host port mapped to PostgreSQL (default: 5432)

## Volumes

- `postgresql_data`: Persistent storage for PostgreSQL data (mounted at `/bitnami/postgresql`)

## Ports

- `${PORT}:5432` — The host port is configurable via the `PORT` environment variable

## Coolify Integration

The `docker-compose.yml` includes Coolify-compatible labels that describe each environment variable (name, description, default value, and type). This allows Coolify to auto-populate the service configuration UI when deploying.

## Maintenance

### Backup

Database data is persisted in the `postgresql_data` volume. To back up:

```bash
docker exec -t postgres-database pg_dumpall -U postgres > backup.sql
```

### Restore

To restore from a backup:

```bash
cat backup.sql | docker exec -i postgres-database psql -U postgres
```

## Security Notes

1. Always use strong passwords for database users
2. Regularly rotate passwords
3. Monitor audit logs for suspicious activity

## Troubleshooting

View logs:

```bash
docker-compose logs postgresql
```

Connect to the database:

```bash
psql "host=localhost port=${PORT:-5432} user=your_username dbname=postgres"
```
