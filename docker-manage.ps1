# Docker management script for LuyPay
# Usage: .\docker-manage.ps1 [command]

param(
    [Parameter(Position=0)]
    [ValidateSet('start', 'stop', 'restart', 'logs', 'clean', 'build', 'status', 'dev', 'help')]
    [string]$Command = 'help'
)

function Show-Help {
    Write-Host "LuyPay Docker Management Script" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\docker-manage.ps1 [command]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor Green
    Write-Host "  start    - Start all services"
    Write-Host "  stop     - Stop all services"
    Write-Host "  restart  - Restart all services"
    Write-Host "  logs     - View logs from all services"
    Write-Host "  clean    - Stop services and remove volumes"
    Write-Host "  build    - Rebuild and start all services"
    Write-Host "  status   - Show status of all services"
    Write-Host "  dev      - Start only databases (for local development)"
    Write-Host "  help     - Show this help message"
    Write-Host ""
}

function Start-Services {
    Write-Host "Starting all LuyPay services..." -ForegroundColor Green
    docker-compose up -d
    Write-Host "Services started! Use '.\docker-manage.ps1 logs' to view logs" -ForegroundColor Green
}

function Stop-Services {
    Write-Host "Stopping all LuyPay services..." -ForegroundColor Yellow
    docker-compose down
    Write-Host "Services stopped!" -ForegroundColor Green
}

function Restart-Services {
    Write-Host "Restarting all LuyPay services..." -ForegroundColor Yellow
    docker-compose restart
    Write-Host "Services restarted!" -ForegroundColor Green
}

function Show-Logs {
    Write-Host "Showing logs (Press Ctrl+C to exit)..." -ForegroundColor Cyan
    docker-compose logs -f
}

function Clean-Services {
    Write-Host "Stopping services and removing volumes..." -ForegroundColor Red
    $confirmation = Read-Host "This will delete all database data. Continue? (y/n)"
    if ($confirmation -eq 'y') {
        docker-compose down -v
        Write-Host "Services stopped and volumes removed!" -ForegroundColor Green
    } else {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
    }
}

function Build-Services {
    Write-Host "Building and starting all services..." -ForegroundColor Green
    docker-compose up --build -d
    Write-Host "Services built and started!" -ForegroundColor Green
}

function Show-Status {
    Write-Host "Service Status:" -ForegroundColor Cyan
    docker-compose ps
}

function Start-Dev {
    Write-Host "Starting databases only (for local development)..." -ForegroundColor Green
    docker-compose -f docker-compose.dev.yml up -d
    Write-Host "Databases started!" -ForegroundColor Green
    Write-Host "Account DB: localhost:5432" -ForegroundColor Cyan
    Write-Host "User DB: localhost:5433" -ForegroundColor Cyan
}

# Execute command
switch ($Command) {
    'start'   { Start-Services }
    'stop'    { Stop-Services }
    'restart' { Restart-Services }
    'logs'    { Show-Logs }
    'clean'   { Clean-Services }
    'build'   { Build-Services }
    'status'  { Show-Status }
    'dev'     { Start-Dev }
    'help'    { Show-Help }
    default   { Show-Help }
}

