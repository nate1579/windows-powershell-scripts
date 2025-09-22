# Restart Print Spooler Script
# Stops and restarts the Windows Print Spooler service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Restarting Print Spooler service..." -ForegroundColor Green

# Stop Print Spooler service
Write-Host "Stopping Print Spooler service..." -ForegroundColor Yellow
Stop-Service -Name Spooler -Force

# Start Print Spooler service
Write-Host "Starting Print Spooler service..." -ForegroundColor Yellow
Start-Service -Name Spooler

Write-Host "Print Spooler service has been restarted." -ForegroundColor Green