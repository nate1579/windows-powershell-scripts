# Restart File Explorer Script
# Stops and restarts Windows Explorer process

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Restarting File Explorer..." -ForegroundColor Green

# Stop Windows Explorer
Write-Host "Stopping Windows Explorer..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force

# Start Windows Explorer
Write-Host "Starting Windows Explorer..." -ForegroundColor Yellow
Start-Process explorer

Write-Host "File Explorer has been restarted." -ForegroundColor Green