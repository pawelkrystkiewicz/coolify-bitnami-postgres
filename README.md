# PostgreSQL Docker Container

A secure PostgreSQL database container using Bitnami's PostgreSQL image with TLS encryption and enhanced logging.

## Features

- TLS encryption for secure connections
- SCRAM-SHA-256 password encryption
- Connection logging (connections/disconnections)
- Audit logging for read/write operations
- Configurable connection limits and timeouts
- Persistent data storage
- Customizable security settings

## Prerequisites

- Docker and Docker Compose installed
- SSL/TLS certificates in a `certs` directory:
  - `server.crt` - Server certificate
  - `server.key` - Server private key
  - `ca.crt` - CA certificate

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
```

## Quick Start

1. Create a `certs` directory and place your TLS certificates in it
2. Create a `.env` file with your configuration
3. Run the container:

```bash
docker-compose up -d
```

## Configuration Options

### Security

- `POSTGRESQL_ENABLE_TLS`: Enable TLS encryption (default: yes)
- `POSTGRESQL_PASSWORD_ENCRYPTION`: Password encryption method (default: scram-sha-256)
- `POSTGRESQL_PGHBA_REMOVE_FILTERS`: Remove unsafe auth methods from pg_hba.conf

### Logging

- `POSTGRESQL_LOG_CONNECTIONS`: Log connection attempts (default: yes)
- `POSTGRESQL_LOG_DISCONNECTIONS`: Log disconnections (default: yes)
- `POSTGRESQL_PGAUDIT_LOG`: Audit log settings (default: read,write)

### Performance

- `POSTGRESQL_STATEMENT_TIMEOUT`: SQL query timeout in milliseconds (default: 30000)
- `POSTGRESQL_MAX_CONNECTIONS`: Maximum database connections (default: 100)
- `POSTGRESQL_USERNAME_CONNECTION_LIMIT`: Connections per user (default: 10)

## Volumes

- `postgresql_data`: Persistent storage for PostgreSQL data
- `./certs`: Read-only mount for TLS certificates

## Ports

- `5432`: PostgreSQL default port

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
2. Keep your TLS certificates secure
3. Regularly rotate passwords and certificates
4. Monitor audit logs for suspicious activity

## Troubleshooting

View logs:

```bash
docker-compose logs postgresql
```

Connect to the database:

```bash
psql "host=localhost port=5432 user=your_username dbname=postgres sslmode=verify-full sslrootcert=./certs/ca.crt"
```
