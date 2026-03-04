# Flyway Database Migration Setup

## Overview
Flyway has been successfully configured for both `account-service` and `user-service` to manage database schema migrations instead of using Hibernate's auto-ddl feature.

## Changes Made

### 1. Added Flyway Dependencies

Both `account-service/pom.xml` and `user-service/pom.xml` now include:

```xml
<properties>
    <java.version>21</java.version>
    <flyway.version>10.21.0</flyway.version>
</properties>

<dependencies>
    <!-- Flyway Core -->
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-core</artifactId>
        <version>${flyway.version}</version>
    </dependency>
    
    <!-- Flyway PostgreSQL Support -->
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-database-postgresql</artifactId>
        <version>${flyway.version}</version>
    </dependency>
</dependencies>
```

### 2. Updated Application Properties

#### account-service/src/main/resources/application.properties
```properties
spring.application.name=account-service
server.port=8081

# PostgreSQL Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5434/accountdb
spring.datasource.username=accountuser
spring.datasource.password=accountpass
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA Configuration - Changed from 'update' to 'validate'
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true

# Flyway Configuration
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true
```

#### user-service/src/main/resources/application.properties
```properties
spring.application.name=user-service
server.port=8082

# PostgreSQL Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5433/userdb
spring.datasource.username=useruser
spring.datasource.password=userpass
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA Configuration - Changed from 'update' to 'validate'
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true

# Flyway Configuration
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true
```

### 3. Updated Docker Compose Configuration

#### Port Changes
- **account-db**: Exposed on port **5434** (changed from 5432 to avoid conflict)
- **user-db**: Exposed on port **5433**

#### docker-compose.yml Updates
```yaml
account-service:
  environment:
    SPRING_DATASOURCE_URL: jdbc:postgresql://account-db:5432/accountdb
    SPRING_JPA_HIBERNATE_DDL_AUTO: validate
    SPRING_FLYWAY_ENABLED: "true"
    SPRING_FLYWAY_LOCATIONS: classpath:db/migration
    SPRING_FLYWAY_BASELINE_ON_MIGRATE: "true"

user-service:
  environment:
    SPRING_DATASOURCE_URL: jdbc:postgresql://user-db:5432/userdb
    SPRING_JPA_HIBERNATE_DDL_AUTO: validate
    SPRING_FLYWAY_ENABLED: "true"
    SPRING_FLYWAY_LOCATIONS: classpath:db/migration
    SPRING_FLYWAY_BASELINE_ON_MIGRATE: "true"
```

### 4. Created Migration Scripts

#### account-service Migration
**Location**: `account-service/src/main/resources/db/migration/V1__Initial_setup.sql`

```sql
-- Initial setup for account service database
-- This is a placeholder migration script
-- Add your table creation scripts here when you create entities

CREATE TABLE IF NOT EXISTS flyway_schema_history (
    installed_rank INTEGER NOT NULL,
    version VARCHAR(50),
    description VARCHAR(200),
    type VARCHAR(20) NOT NULL,
    script VARCHAR(1000) NOT NULL,
    checksum INTEGER,
    installed_by VARCHAR(100) NOT NULL,
    installed_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    execution_time INTEGER NOT NULL,
    success BOOLEAN NOT NULL,
    CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank)
);

-- Add your table creation scripts here
-- Example:
-- CREATE TABLE accounts (
--     id BIGSERIAL PRIMARY KEY,
--     account_number VARCHAR(20) UNIQUE NOT NULL,
--     balance DECIMAL(19,2) NOT NULL DEFAULT 0.00,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
```

#### user-service Migration
**Location**: `user-service/src/main/resources/db/migration/V1__Create_users_table.sql`

```sql
-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email for faster lookups
CREATE INDEX idx_users_email ON users(email);

-- Create index on username for faster lookups
CREATE INDEX idx_users_username ON users(username);
```

## How to Use Flyway Migrations

### Creating New Migrations

1. **Naming Convention**: `V{version}__{description}.sql`
   - Version must start with a capital `V`
   - Use sequential version numbers (V1, V2, V3, etc.)
   - Double underscore `__` separates version from description
   - Description uses underscores instead of spaces

2. **Examples**:
   - `V2__Add_account_transactions_table.sql`
   - `V3__Add_user_roles.sql`
   - `V4__Add_foreign_keys.sql`

3. **Location**: Place migration files in:
   - account-service: `src/main/resources/db/migration/`
   - user-service: `src/main/resources/db/migration/`

### Running Migrations

#### Development (Local)
```bash
# Migrations run automatically when the Spring Boot application starts
mvn spring-boot:run
```

#### Docker
```bash
# Build and start services
docker-compose up -d --build

# Check migration status in logs
docker-compose logs account-service
docker-compose logs user-service
```

### Checking Migration Status

```sql
-- Connect to the database
psql -h localhost -p 5434 -U accountuser -d accountdb

-- View migration history
SELECT * FROM flyway_schema_history ORDER BY installed_rank;
```

## Important Notes

1. **Never Modify Existing Migrations**: Once a migration has been applied, never modify it. Create a new migration instead.

2. **DDL Mode Changed**: `spring.jpa.hibernate.ddl-auto` is now set to `validate` instead of `update`. This means:
   - Hibernate will only validate that the schema matches the entities
   - Schema changes must be done through Flyway migrations
   - This prevents accidental schema modifications

3. **Baseline on Migrate**: The `baseline-on-migrate=true` setting allows Flyway to initialize on existing databases without throwing errors.

4. **Port Conflicts Resolved**:
   - account-db: **5434** → avoids conflict with existing PostgreSQL on 5432
   - user-db: **5433**

## Best Practices

1. **Test Migrations Locally First**: Always test migrations in development before deploying to production.

2. **Rollback Strategy**: For complex changes, create separate migration files that can be rolled back if needed.

3. **Data Migrations**: Separate data migrations from schema migrations when possible:
   - `V2__Add_column.sql` (schema)
   - `V3__Migrate_data.sql` (data)

4. **Use Transactions**: Most DDL statements in PostgreSQL are transactional, so migrations will rollback on error.

5. **Version Control**: Always commit migration files to version control.

## Troubleshooting

### Migration Failed
```bash
# View detailed error in logs
docker-compose logs account-service | grep -i flyway

# Access the database to check flyway_schema_history
docker exec -it luypay-account-db psql -U accountuser -d accountdb
```

### Reset Migrations (Development Only)
```sql
-- Connect to database
psql -h localhost -p 5434 -U accountuser -d accountdb

-- Drop flyway history (WARNING: Development only!)
DROP TABLE flyway_schema_history CASCADE;

-- Drop all tables if needed
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO accountuser;
```

## Next Steps

1. Create entity classes in your services
2. Write corresponding Flyway migration scripts
3. Test migrations locally
4. Deploy to Docker environment
5. Verify migrations in production-like environments before going live

## Resources

- [Flyway Documentation](https://documentation.red-gate.com/flyway)
- [Flyway PostgreSQL Tutorial](https://documentation.red-gate.com/flyway/flyway-cli-and-api/tutorials/tutorial-postgresql)
- [Spring Boot Flyway Integration](https://docs.spring.io/spring-boot/docs/current/reference/html/howto.html#howto.data-initialization.migration-tool.flyway)

