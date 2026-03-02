# 🚀 LuyPay Docker Setup - Installation & Quick Start

## ✅ What Has Been Created

Your project is now **fully containerized** with Docker! Here's what was set up:

### 📦 Docker Files (19 files created/modified)
- ✅ 4 Dockerfiles (one for each service)
- ✅ 4 .dockerignore files (optimized builds)
- ✅ 1 docker-compose.yml (full stack orchestration)
- ✅ 1 docker-compose.dev.yml (development mode)
- ✅ 1 nginx.conf (frontend proxy configuration)
- ✅ 3 updated application.properties (environment variable support)
- ✅ 1 docker-manage.ps1 (management script)
- ✅ 1 .env.example (environment template)
- ✅ 1 .gitignore (Docker artifacts)
- ✅ 2 documentation files (DOCKER_README.md, SUMMARY.md)

### 🏗️ Architecture
```
Frontend (Port 80) → API Gateway (Port 8080) → Account Service (Port 8081) → PostgreSQL (5432)
                                              → User Service (Port 8082) → PostgreSQL (5433)
```

## 📋 Prerequisites - Install Docker Desktop

### Step 1: Download Docker Desktop
1. Visit: https://www.docker.com/products/docker-desktop/
2. Download Docker Desktop for Windows
3. Run the installer
4. **Restart your computer** when prompted

### Step 2: Verify Installation
After restart, open PowerShell and run:
```powershell
docker --version
docker-compose --version
```

You should see version numbers like:
```
Docker version 24.0.x
Docker Compose version 2.x.x
```

### Step 3: Start Docker Desktop
- Launch Docker Desktop from Start menu
- Wait for "Docker Desktop is running" status
- Ensure WSL 2 is enabled (Docker will prompt if needed)

## 🎯 Quick Start (After Docker is Installed)

### Option 1: Use Management Script (Easiest)
```powershell
cd C:\Springboot\luypay-workspace

# Build and start everything
.\docker-manage.ps1 build

# Check status
.\docker-manage.ps1 status

# View logs
.\docker-manage.ps1 logs
```

### Option 2: Use Docker Compose Directly
```powershell
cd C:\Springboot\luypay-workspace

# Build and start all services
docker-compose up --build -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

### ⏱️ First Build Time
- **First time**: 5-10 minutes (downloading dependencies)
- **Subsequent builds**: 2-3 minutes (cached layers)

## 🌐 Access Your Application

Once services are running:

| Service | URL | Description |
|---------|-----|-------------|
| **Frontend** | http://localhost | Angular application |
| **API Gateway** | http://localhost:8080 | Main API endpoint |
| **Account Service** | http://localhost:8081 | Direct access (optional) |
| **User Service** | http://localhost:8082 | Direct access (optional) |
| **Account DB** | localhost:5432 | PostgreSQL database |
| **User DB** | localhost:5433 | PostgreSQL database |

## 🛠️ Common Commands

### Start/Stop Services
```powershell
# Start
docker-compose up -d

# Stop
docker-compose down

# Stop and remove all data
docker-compose down -v
```

### View Logs
```powershell
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f account-service
```

### Rebuild After Code Changes
```powershell
# Rebuild specific service
docker-compose up --build account-service

# Rebuild everything
docker-compose up --build
```

### Development Mode (Only Databases)
```powershell
# Start only PostgreSQL databases
.\docker-manage.ps1 dev

# Or manually
docker-compose -f docker-compose.dev.yml up -d

# Now run services from your IDE
# They will connect to Docker databases
```

## 📊 Verify Services Are Running

```powershell
# Check container status
docker-compose ps

# Should show all 6 services as "Up"
# - frontend
# - api-gateway
# - account-service
# - user-service
# - account-db
# - user-db

# Test API Gateway
curl http://localhost:8080/actuator/health

# Test Frontend
curl http://localhost
```

## 🔧 Troubleshooting

### Port Already in Use
```powershell
# Check what's using ports
netstat -ano | findstr "80 8080 8081 8082 5432 5433"

# Kill process by PID (replace XXXX with actual PID)
taskkill /PID XXXX /F
```

### Services Won't Start
```powershell
# Check logs for errors
docker-compose logs

# Try clean restart
docker-compose down -v
docker-compose up --build
```

### Docker Desktop Not Running
- Open Docker Desktop from Start menu
- Wait for it to fully start
- Check system tray for Docker icon

### Out of Memory
- Open Docker Desktop → Settings → Resources
- Increase Memory to at least 4GB
- Apply & Restart

## 📁 Project Structure

```
luypay-workspace/
├── docker-compose.yml              # Main orchestration
├── docker-compose.dev.yml          # Development mode
├── docker-manage.ps1               # Management script
├── DOCKER_README.md                # Detailed guide
├── SUMMARY.md                      # Architecture overview
├── START_HERE.md                   # This file
├── .env.example                    # Environment template
├── .gitignore                      # Git ignore rules
│
├── account-service/
│   ├── Dockerfile                  # Account service container
│   ├── .dockerignore              # Build optimization
│   └── src/main/resources/
│       └── application.properties  # Updated config
│
├── user-service/
│   ├── Dockerfile                  # User service container
│   ├── .dockerignore              # Build optimization
│   └── src/main/resources/
│       └── application.properties  # Updated config
│
├── api-gateway/
│   ├── Dockerfile                  # Gateway container
│   ├── .dockerignore              # Build optimization
│   └── src/main/resources/
│       └── application.properties  # Updated config
│
└── luypay-frontend/
    ├── Dockerfile                  # Frontend container
    ├── nginx.conf                  # Nginx configuration
    └── .dockerignore              # Build optimization
```

## 🎓 Learning Resources

- **Your Documentation**: Read `DOCKER_README.md` for detailed info
- **Architecture**: Check `SUMMARY.md` for system overview
- **Docker Docs**: https://docs.docker.com/
- **Docker Compose**: https://docs.docker.com/compose/

## ✨ What's Different Now?

### Before Docker
- Manual setup of PostgreSQL databases
- Configure connection strings for each service
- Start each service individually
- Port conflicts and environment issues

### After Docker
- **One command** starts everything: `docker-compose up`
- **Isolated environment**: No conflicts with local installations
- **Consistent setup**: Works the same on any machine
- **Easy cleanup**: `docker-compose down` removes everything
- **Production-ready**: Same containers can deploy anywhere

## 🚀 Next Steps

1. **Install Docker Desktop** (if not already installed)
2. **Run**: `.\docker-manage.ps1 build`
3. **Access**: http://localhost
4. **Develop**: Make changes, rebuild specific services
5. **Deploy**: Use same containers in production

## 💡 Pro Tips

### Faster Development
```powershell
# Only run databases, code in IDE
.\docker-manage.ps1 dev
```

### Clean Restart
```powershell
# Nuclear option - fresh start
docker-compose down -v
docker system prune -a
docker-compose up --build
```

### Check Resource Usage
```powershell
docker stats
```

### Database Backup
```powershell
docker-compose exec account-db pg_dump -U accountuser accountdb > backup.sql
```

## ❓ Need Help?

1. Check `DOCKER_README.md` for detailed documentation
2. View logs: `docker-compose logs -f`
3. Check status: `docker-compose ps`
4. Verify Docker is running: `docker --version`

## 🎉 Success Indicators

When everything works, you'll see:
- ✅ 6 containers running (`docker-compose ps`)
- ✅ Frontend loads at http://localhost
- ✅ API Gateway responds at http://localhost:8080/actuator/health
- ✅ No error logs in `docker-compose logs`

---

**You're all set!** 🎊

Your microservices application is fully containerized and ready to run with Docker.

Install Docker Desktop, then run: `.\docker-manage.ps1 build`

