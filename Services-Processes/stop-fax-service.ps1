# Stop Fax Service Script
# Stops and disables Windows Fax service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Stopping Fax service..." -ForegroundColor Green

# Stop and disable Fax service
Write-Host "Disabling Fax service..." -ForegroundColor Yellow
Stop-Service -Name Fax -Force -ErrorAction SilentlyContinue
Set-Service -Name Fax -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "Fax service has been stopped and disabled." -ForegroundColor Green