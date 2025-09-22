# Disable Superfetch Script
# Disables Windows Superfetch/SysMain service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Superfetch..." -ForegroundColor Green

# Stop and disable Superfetch/SysMain service
Write-Host "Stopping Superfetch service..." -ForegroundColor Yellow
Stop-Service -Name SysMain -Force -ErrorAction SilentlyContinue
Set-Service -Name SysMain -StartupType Disabled

Write-Host "Superfetch has been disabled." -ForegroundColor Green