# LuyPay Docker Deployment Guide

This guide will help you deploy the entire LuyPay microservices application using Docker.

## Architecture

The application consists of:
- **Frontend**: Angular application (nginx on port 80)
- **API Gateway**: Spring Cloud Gateway (port 8080)
- **Account Service**: Spring Boot microservice (port 8081)
- **User Service**: Spring Boot microservice (port 8082)
- **Account Database**: PostgreSQL (port 5432)
- **User Database**: PostgreSQL (port 5433)

## Prerequisites

- Docker Desktop installed and running
- Docker Compose installed (included with Docker Desktop)
- At least 4GB RAM available for Docker
- Ports 80, 8080, 8081, 8082, 5432, 5433 available

## Quick Start

### 1. Build and Start All Services

From the root directory (`luypay-workspace`), run:

```powershell
docker-compose up --build
```

This command will:
- Build all Docker images
- Start PostgreSQL databases
- Start all microservices
- Start the frontend

**Note**: First build may take 5-10 minutes as it downloads dependencies.

### 2. Access the Application

- **Frontend**: http://localhost
- **API Gateway**: http://localhost:8080
- **Account Service**: http://localhost:8081
- **User Service**: http://localhost:8082

## Docker Commands

### Start services (detached mode)
```powershell
docker-compose up -d
```

### Stop services
```powershell
docker-compose down
```

### Stop services and remove volumes (clean slate)
```powershell
docker-compose down -v
```

### View logs
```powershell
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f account-service
docker-compose logs -f user-service
docker-compose logs -f api-gateway
docker-compose logs -f frontend
```

### Rebuild specific service
```powershell
docker-compose up --build account-service
```

### Check service status
```powershell
docker-compose ps
```

### Restart a service
```powershell
docker-compose restart account-service
```

## Database Access

### Account Database
- Host: localhost
- Port: 5432
- Database: accountdb
- Username: accountuser
- Password: accountpass

### User Database
- Host: localhost
- Port: 5433
- Database: userdb
- Username: useruser
- Password: userpass

## Troubleshooting

### Services won't start
1. Check if ports are available:
```powershell
netstat -ano | findstr "80 8080 8081 8082 5432 5433"
```

2. Check Docker logs:
```powershell
docker-compose logs
```

### Database connection issues
Wait for databases to be healthy:
```powershell
docker-compose ps
```

### Clean restart
```powershell
docker-compose down -v
docker-compose up --build
```

### Check container health
```powershell
docker ps
docker inspect <container-id>
```

## Development Tips

### Hot Reload Development
For development with hot reload, you can run services individually:

1. Start only databases:
```powershell
docker-compose up account-db user-db
```

2. Run services locally using your IDE

### Build Individual Services
```powershell
# Account Service
cd account-service
docker build -t luypay-account-service .

# User Service
cd user-service
docker build -t luypay-user-service .

# API Gateway
cd api-gateway
docker build -t luypay-api-gateway .

# Frontend
cd luypay-frontend
docker build -t luypay-frontend .
```

## Production Considerations

Before deploying to production:

1. **Change default passwords** in docker-compose.yml
2. **Use environment files** for sensitive data
3. **Configure proper logging**
4. **Set up health checks** and monitoring
5. **Use Docker secrets** for credentials
6. **Configure resource limits**
7. **Use proper SSL/TLS certificates**
8. **Set up backup strategy** for databases

## Network

All services are connected via a bridge network named `luypay-network`. Services can communicate with each other using their service names (e.g., `account-service`, `user-db`).

## Volumes

Persistent data volumes:
- `account-db-data`: Account database data
- `user-db-data`: User database data

## Scaling Services

To run multiple instances of a service:
```powershell
docker-compose up --scale account-service=3
```

Note: You'll need to configure load balancing for this to work properly.

## Support

For issues or questions, please check:
1. Service logs: `docker-compose logs <service-name>`
2. Docker status: `docker-compose ps`
3. System resources: Ensure enough RAM/CPU available

