# Start Fax Service Script
# Starts and enables Windows Fax service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting Fax service..." -ForegroundColor Green

# Start and enable Fax service
Write-Host "Enabling Fax service..." -ForegroundColor Yellow
Set-Service -Name Fax -StartupType Manual -ErrorAction SilentlyContinue
Start-Service -Name Fax -ErrorAction SilentlyContinue

Write-Host "Fax service has been started and enabled." -ForegroundColor Green