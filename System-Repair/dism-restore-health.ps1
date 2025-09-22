# DISM Restore Health Script
# Runs DISM to restore Windows image health

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Running DISM restore health..." -ForegroundColor Green

# Run DISM restore health
Write-Host "Starting DISM image health restoration..." -ForegroundColor Yellow
dism /online /cleanup-image /restorehealth

Write-Host "DISM restore health completed." -ForegroundColor Green