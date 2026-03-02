# 💳 LuyPay - Microservices Payment Application

A modern, containerized microservices application built with Spring Boot, Angular, and Docker.

## 🏗️ Architecture

```
Frontend (Angular/Nginx)
         ↓ Port 80
    API Gateway (Spring Cloud Gateway)
         ↓ Port 8080
         ├─→ Account Service (Spring Boot) → PostgreSQL (5432)
         │   Port 8081
         │
         └─→ User Service (Spring Boot) → PostgreSQL (5433)
             Port 8082
```

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

---

## 🚀 Quick Start with Docker (Recommended)

### Prerequisites
- **Docker** installed and running
  - **Windows/Mac:** [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - **Linux:** Docker Engine + Docker Compose
- **4GB RAM** available for Docker
- **Ports available**: 80, 8080, 8081, 8082, 5432, 5433

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
- Java 21 or higher
- Maven 3.9+
- Node.js 22+
- PostgreSQL 16
- npm

### 1. Setup Databases

**Account Database:**
```sql
CREATE DATABASE accountdb;
CREATE USER accountuser WITH PASSWORD 'accountpass';
GRANT ALL PRIVILEGES ON DATABASE accountdb TO accountuser;
```

**User Database:**
```sql
CREATE DATABASE userdb;
CREATE USER useruser WITH PASSWORD 'userpass';
GRANT ALL PRIVILEGES ON DATABASE userdb TO useruser;
```

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

## 🔧 Docker Management

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
- **Port:** 5432
- **Database:** accountdb
- **Username:** accountuser
- **Password:** accountpass

### User Database
- **Host:** localhost
- **Port:** 5433
- **Database:** userdb
- **Username:** useruser
- **Password:** userpass

**Connect using:**
```powershell
# Account DB
psql -h localhost -p 5432 -U accountuser -d accountdb

# User DB
psql -h localhost -p 5433 -U useruser -d userdb
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
- ☕ Java 21
- 🍃 Spring Boot 4.0.3
- 🌐 Spring Cloud Gateway
- 🗃️ Spring Data JPA
- 🐘 PostgreSQL 16
- 🔒 Spring Security
- 📦 Maven

**Frontend:**
- 🅰️ Angular 18+
- 📘 TypeScript
- 🎨 SCSS
- 🌐 Nginx

**DevOps:**
- 🐳 Docker
- 🐙 Docker Compose
- 🔧 Multi-stage Builds

## 🐛 Troubleshooting

### Services won't start

#### Check if ports are available

**Windows:**
```powershell
netstat -ano | findstr "80 8080 8081 8082 5432 5433"
```

**Linux / macOS:**
```bash
sudo lsof -i :80,8080,8081,8082,5432,5433
# or
sudo netstat -tulpn | grep -E "80|8080|8081|8082|5432|5433"
```

#### Check Docker is running
```bash
# Works on all platforms
docker --version
docker compose version
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

## 📚 Additional Documentation

- [DOCKER_README.md](DOCKER_README.md) - Detailed Docker guide
- [START_HERE.md](START_HERE.md) - Getting started guide
- [SUMMARY.md](SUMMARY.md) - Project summary

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

## 👥 Authors

- **Chhem Bunheng** - [GitHub](https://github.com/chhembunheng)

## 🙏 Acknowledgments

- Spring Boot Team
- Angular Team
- Docker Community

---

**Repository:** https://github.com/chhembunheng/luypay-workspace

For detailed Docker instructions, see [DOCKER_README.md](DOCKER_README.md)
