# System Repair Script
# Runs SFC scan and DISM restore health commands

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting system repair process..." -ForegroundColor Green

# Run SFC scan
Write-Host "`nRunning SFC /scannow..." -ForegroundColor Yellow
sfc /scannow

# Run DISM restore health
Write-Host "`nRunning DISM restore health..." -ForegroundColor Yellow
dism /online /cleanup-image /restorehealth

Write-Host "`nSystem repair process completed." -ForegroundColor Green
Write-Host "Please restart your computer if prompted." -ForegroundColor Cyan