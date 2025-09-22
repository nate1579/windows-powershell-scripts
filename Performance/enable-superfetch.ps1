# Enable Superfetch Script
# Enables Windows Superfetch/SysMain service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Superfetch..." -ForegroundColor Green

# Enable and start Superfetch/SysMain service
Write-Host "Starting Superfetch service..." -ForegroundColor Yellow
Set-Service -Name SysMain -StartupType Automatic
Start-Service -Name SysMain -ErrorAction SilentlyContinue

Write-Host "Superfetch has been enabled." -ForegroundColor Green