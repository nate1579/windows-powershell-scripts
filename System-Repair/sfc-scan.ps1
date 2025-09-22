# SFC Scan Script
# Runs System File Checker to scan and repair system files

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Running SFC scan..." -ForegroundColor Green

# Run SFC scan
Write-Host "Starting System File Checker scan..." -ForegroundColor Yellow
sfc /scannow

Write-Host "SFC scan completed." -ForegroundColor Green