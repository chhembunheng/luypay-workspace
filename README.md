# 💳 LuyPay - Microservices Payment Application

A modern, containerized microservices payment application built with **Spring Boot 4**, **Angular 18**, and **Docker**. Features automated database migrations with **Flyway**, multi-stage Docker builds, and production-ready microservices architecture.

## ⭐ Key Features

- 🎯 **Microservices Architecture** - Modular, scalable service design
- 🔄 **Automated Database Migrations** - Flyway-managed schema versioning
- 🐳 **Full Docker Support** - One-command deployment
- 🔒 **Spring Security** - Built-in authentication & authorization
- 📊 **PostgreSQL** - Reliable, production-ready data storage
- 🌐 **API Gateway** - Centralized routing and load balancing
- ⚡ **Angular 18** - Modern, reactive frontend

## 🏗️ Architecture

```
Frontend (Angular/Nginx)
         ↓ Port 80
    API Gateway (Spring Cloud Gateway)
         ↓ Port 8080
         ├─→ Account Service (Spring Boot) → PostgreSQL (5434)
         │   Port 8081                         accountdb
         │
         └─→ User Service (Spring Boot) → PostgreSQL (5433)
             Port 8082                       userdb
```

**Database Migrations:** Both services use Flyway for automatic schema management on startup.

## ⚡ TL;DR - Quick Start

**Windows:**
```powershell
docker-compose up --build -d
```

**Linux/macOS:**
```bash
docker compose up --build -d
```

Then visit: **http://localhost**

> ⚠️ **First build takes 5-10 minutes** to download dependencies and build services.

---

## 🚀 Quick Start with Docker (Recommended)

### Prerequisites
- **Docker Desktop** (Windows/Mac) or **Docker Engine** (Linux)
- **4GB RAM** minimum available for Docker
- **Free Ports:** 80, 8080, 8081, 8082, 5433, 5434

> 💡 **Tip:** The application uses PostgreSQL 15 for Flyway 11 compatibility with Spring Boot 4.

### 1. Install Docker

#### Windows / macOS
Download and install Docker Desktop from: https://www.docker.com/products/docker-desktop/

#### Linux (Ubuntu/Debian)
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add your user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Install Docker Compose
sudo apt-get update
sudo apt-get install docker-compose-plugin
```

#### Linux (RHEL/CentOS/Fedora)
```bash
# Install Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Install Docker Compose
sudo yum install docker-compose-plugin
```

### 2. Clone the Repository
```bash
git clone https://github.com/chhembunheng/luypay-workspace.git
cd luypay-workspace
```

### 3. Start All Services

#### Windows (PowerShell)
```powershell
# Build and start all services
docker-compose up --build

# Or in detached mode (runs in background)
docker-compose up --build -d
```

#### Linux / macOS (Bash)
```bash
# Build and start all services
docker compose up --build

# Or in detached mode (runs in background)
docker compose up --build -d
```

**First build takes 5-10 minutes** (downloads dependencies)

### 4. Access the Application

| Service | URL | Description |
|---------|-----|-------------|
| 🎨 **Frontend** | http://localhost | Angular application |
| 🚪 **API Gateway** | http://localhost:8080 | Main API endpoint |
| 💰 **Account Service** | http://localhost:8081 | Account management |
| 👤 **User Service** | http://localhost:8082 | User management |

### 5. Stop Services

#### Windows (PowerShell)
```powershell
# Stop all services
docker-compose down

# Stop and remove all data (clean slate)
docker-compose down -v
```

#### Linux / macOS (Bash)
```bash
# Stop all services
docker compose down

# Stop and remove all data (clean slate)
docker compose down -v
```

## 🛠️ Alternative: Run Without Docker

### Prerequisites
- **Java 21** or higher
- **Maven 3.9+**
- **Node.js 22+** & npm
- **PostgreSQL 15** (recommended for Flyway 11 compatibility)

### 1. Setup Databases

**Create databases and users:**

```sql
-- Account Database
CREATE DATABASE accountdb;
CREATE USER accountuser WITH PASSWORD 'accountpass';
GRANT ALL PRIVILEGES ON DATABASE accountdb TO accountuser;

-- User Database
CREATE DATABASE userdb;
CREATE USER useruser WITH PASSWORD 'userpass';
GRANT ALL PRIVILEGES ON DATABASE userdb TO useruser;
```

**Update connection strings (if needed):**
- Account Service: [account-service/src/main/resources/application.properties](account-service/src/main/resources/application.properties)
- User Service: [user-service/src/main/resources/application.properties](user-service/src/main/resources/application.properties)

> 📝 **Note:** Flyway will automatically create tables on first startup. No manual schema setup needed.

### 2. Start Backend Services

#### Windows (PowerShell)
```powershell
# Terminal 1 - Account Service
cd account-service
mvn spring-boot:run

# Terminal 2 - User Service (in new terminal)
cd user-service
mvn spring-boot:run

# Terminal 3 - API Gateway (in new terminal)
cd api-gateway
mvn spring-boot:run
```

#### Linux / macOS (Bash)
```bash
# Terminal 1 - Account Service
cd account-service
./mvnw spring-boot:run

# Terminal 2 - User Service (in new terminal)
cd user-service
./mvnw spring-boot:run

# Terminal 3 - API Gateway (in new terminal)
cd api-gateway
./mvnw spring-boot:run
```

### 3. Start Frontend

**Terminal 4:**
```powershell
cd luypay-frontend
npm install
npm start
```

Frontend will be available at: http://localhost:4200

## 📁 Project Structure

```
luypay-workspace/
├── account-service/          # Account management microservice
│   ├── src/
│   ├── Dockerfile
│   └── pom.xml
│
├── user-service/             # User management microservice
│   ├── src/
│   ├── Dockerfile
│   └── pom.xml
│
├── api-gateway/              # API Gateway (routing)
│   ├── src/
│   ├── Dockerfile
│   └── pom.xml
│
├── luypay-frontend/          # Angular frontend
│   ├── src/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── package.json
│
├── docker-compose.yml        # Docker orchestration
├── docker-compose.dev.yml    # Development mode (databases only)
├── docker-manage.ps1         # Management script
└── README.md                 # This file
```

## � Database Migrations (Flyway)

Database schema is managed automatically using **Flyway**. Migrations run on service startup.

### Migration Files Location

**Account Service:**
```
account-service/src/main/resources/db/migration/
└── V1__Initial_setup.sql
```

**User Service:**
```
user-service/src/main/resources/db/migration/
└── V1__Create_users_table.sql
```

### Migration Naming Convention

Flyway requires specific naming:
```
V{VERSION}__{DESCRIPTION}.sql
```

**Examples:**
- `V1__Initial_setup.sql` - First migration
- `V2__Add_email_verification.sql` - Second migration
- `V3__Create_transactions_table.sql` - Third migration

### Adding New Migrations

1. Create new SQL file in `src/main/resources/db/migration/`
2. Follow naming convention with incremented version
3. Restart service - Flyway applies new migrations automatically

**Example:**
```sql
-- V2__Add_status_column.sql
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'ACTIVE';
```

### Configuration

Flyway is configured in `application.properties`:
```properties
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true
```

### Dependencies

Both services use:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-flyway</artifactId>
</dependency>
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-database-postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

> 📚 **Learn more:** [FLYWAY_MIGRATION_SETUP.md](FLYWAY_MIGRATION_SETUP.md)

## �🔧 Docker Management

### Windows - PowerShell Script

Use the PowerShell script for easy management on Windows:

```powershell
# Start all services
.\docker-manage.ps1 start

# Stop all services
.\docker-manage.ps1 stop

# View logs
.\docker-manage.ps1 logs

# Rebuild and start
.\docker-manage.ps1 build

# Check status
.\docker-manage.ps1 status

# Start only databases (for local development)
.\docker-manage.ps1 dev

# Clean restart (removes all data)
.\docker-manage.ps1 clean
```

### Linux / macOS - Docker Compose Commands

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f

# Rebuild and start
docker compose up --build -d

# Check status
docker compose ps

# Start only databases (for local development)
docker compose -f docker-compose.dev.yml up -d

# Clean restart (removes all data)
docker compose down -v
docker compose up --build -d
```

## 🔍 Common Commands

### View Logs

#### Windows
```powershell
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f account-service
docker-compose logs -f user-service
docker-compose logs -f api-gateway
docker-compose logs -f frontend
```

#### Linux / macOS
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f account-service
docker compose logs -f user-service
docker compose logs -f api-gateway
docker compose logs -f frontend
```

### Check Service Status
```bash
# Works on all platforms
docker compose ps
# or
docker-compose ps
```

### Restart a Service
```bash
# Works on all platforms
docker compose restart account-service
# or
docker-compose restart account-service
```

### Rebuild Specific Service
```bash
# Works on all platforms
docker compose up --build account-service
# or
docker-compose up --build account-service
```

## 🗄️ Database Access

### Account Database
- **Host:** localhost
- **Port:** 5434
- **Database:** accountdb
- **Username:** accountuser
- **Password:** accountpass

### User Database
- **Host:** localhost
- **Port:** 5433
- **Database:** userdb
- **Username:** useruser
- **Password:** userpass

**Connect using psql:**
```bash
# Account DB
psql -h localhost -p 5434 -U accountuser -d accountdb

# User DB
psql -h localhost -p 5433 -U useruser -d userdb
```

**Or using Docker:**
```bash
# Account DB
docker exec -it luypay-account-db psql -U accountuser -d accountdb

# User DB
docker exec -it luypay-user-db psql -U useruser -d userdb
```

### View Migration Status

Check Flyway migration history:
```sql
-- Shows all applied migrations
SELECT * FROM flyway_schema_history;
```

## 🧪 API Endpoints

### Through API Gateway (http://localhost:8080)

**Account Service:**
- `GET /accounts` - List all accounts
- `GET /accounts/{id}` - Get account by ID
- `POST /accounts` - Create account
- `PUT /accounts/{id}` - Update account
- `DELETE /accounts/{id}` - Delete account

**User Service:**
- `GET /users` - List all users
- `GET /users/{id}` - Get user by ID
- `POST /users` - Create user
- `PUT /users/{id}` - Update user
- `DELETE /users/{id}` - Delete user

### Direct Service Access

**Account Service (http://localhost:8081):**
- Direct access to account endpoints

**User Service (http://localhost:8082):**
- Direct access to user endpoints
- **Note:** Requires authentication (Spring Security enabled)
  - Username: `user`
  - Password: Check logs with `docker-compose logs user-service | findstr password`

## 🔒 Security Note

The User Service has Spring Security enabled. For development, you can:

1. **Find the auto-generated password:**

#### Windows (PowerShell)
```powershell
docker-compose logs user-service | findstr password
```

#### Linux / macOS (Bash)
```bash
docker compose logs user-service | grep password
```

2. **Use Basic Auth:**
   - Username: `user`
   - Password: (from logs)

## 🛠️ Technologies Used

**Backend:**
- ☕ **Java 21** - Modern LTS Java version
- 🍃 **Spring Boot 4.0.3** - Latest Spring framework
- 🌐 **Spring Cloud Gateway** - API gateway & routing
- 🗃️ **Spring Data JPA** - Database abstraction with Hibernate 7
- 🔄 **Flyway 11** - Database migration management
- 🐘 **PostgreSQL 15** - Reliable relational database
- 🔒 **Spring Security** - Authentication & authorization
- 📦 **Maven 3.9** - Dependency management

**Frontend:**
- 🅰️ **Angular 18** - Modern TypeScript framework
- 📘 **TypeScript 5** - Type-safe JavaScript
- 🎨 **SCSS** - Enhanced CSS styling
- 🌐 **Nginx** - Production web server

**DevOps:**
- 🐳 **Docker 24+** - Containerization
- 🐙 **Docker Compose** - Multi-container orchestration
- 🔧 **Multi-stage Builds** - Optimized container images

## 🐛 Troubleshooting

### Services won't start

#### Check if ports are available

**Windows:**
```powershell
netstat -ano | findstr "80 8080 8081 8082 5433 5434"
```

**Linux / macOS:**
```bash
sudo lsof -i :80,8080,8081,8082,5433,5434
# or
sudo netstat -tulpn | grep -E "80|8080|8081|8082|5433|5434"
```

#### Check Docker is running
```bash
# Works on all platforms
docker --version
docker compose version
```

### Migration Issues

#### Flyway migration fails

**Symptom:** Service crashes with `Unsupported Database: PostgreSQL X.X`

**Solution:**
- Ensure PostgreSQL 15 is used (defined in [docker-compose.yml](docker-compose.yml))
- Flyway 11 Community Edition (included with Spring Boot 4) supports PostgreSQL up to version 15

**Check migration status:**
```bash
# View service logs for Flyway output
docker logs luypay-user-service | grep -i flyway
docker logs luypay-account-service | grep -i flyway

# Connect to database and check migration history
docker exec -it luypay-user-db psql -U useruser -d userdb -c "SELECT * FROM flyway_schema_history;"
```

#### Reset database and re-run migrations

**⚠️ Warning: This deletes all data**

```bash
# Stop services
docker-compose down

# Remove database volumes
docker volume rm luypay-workspace_user-db-data luypay-workspace_account-db-data

# Restart - Flyway will recreate schema
docker-compose up -d
```

### Clean Restart

#### Windows (PowerShell)
```powershell
# Stop everything and remove volumes
docker-compose down -v

# Rebuild from scratch
docker-compose up --build
```

#### Linux / macOS (Bash)
```bash
# Stop everything and remove volumes
docker compose down -v

# Rebuild from scratch
docker compose up --build
```

### Database Connection Issues
Wait for databases to be healthy:
```bash
# Works on all platforms
docker compose ps
```

Look for "healthy" status on database containers.

### View Container Logs
```bash
# Works on all platforms
docker logs luypay-account-service
docker logs luypay-user-service
docker logs luypay-api-gateway
docker logs luypay-frontend
```

### Out of Memory

**Windows/Mac (Docker Desktop):**
1. Docker Desktop → Settings → Resources
2. Increase Memory to at least 4GB
3. Apply & Restart

**Linux:**
Docker uses system memory directly. Ensure at least 4GB available:
```bash
free -h
```

## 🚀 Development Workflow

### Running in Development Mode

**1. Start only databases:**

#### Windows (PowerShell)
```powershell
docker-compose -f docker-compose.dev.yml up -d
```

#### Linux / macOS (Bash)
```bash
docker compose -f docker-compose.dev.yml up -d
```

**2. Run services in your IDE:**
- Account Service on port 8081
- User Service on port 8082
- API Gateway on port 8080

**3. Run frontend with hot reload:**
```bash
# Works on all platforms
cd luypay-frontend
npm install
npm start
```

Frontend will be available at: http://localhost:4200

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is for educational purposes.

## 👥 Author

**Chhem Bunheng** - [GitHub](https://github.com/chhembunheng)

## 🙏 Acknowledgments

- Spring Boot & Spring Cloud Teams
- Flyway by Redgate
- Angular Team
- Docker & PostgreSQL Communities

---

## 📌 Important Notes

- ✅ **Flyway automatically creates tables** - No manual schema setup needed
- ✅ **PostgreSQL 15** is used for Flyway 11 compatibility with Spring Boot 4
- ✅ **Database migrations** run automatically on service startup
- ✅ **Spring Security** is enabled on User Service (check logs for password)

**Repository:** https://github.com/chhembunheng/luypay-workspace
