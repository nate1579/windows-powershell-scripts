# Disable HomeGroup Script
# Disables Windows HomeGroup services

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling HomeGroup services..." -ForegroundColor Green

# Disable HomeGroup Listener service
Write-Host "Disabling HomeGroup Listener service..." -ForegroundColor Yellow
Stop-Service -Name HomeGroupListener -Force -ErrorAction SilentlyContinue
Set-Service -Name HomeGroupListener -StartupType Disabled -ErrorAction SilentlyContinue

# Disable HomeGroup Provider service
Write-Host "Disabling HomeGroup Provider service..." -ForegroundColor Yellow
Stop-Service -Name HomeGroupProvider -Force -ErrorAction SilentlyContinue
Set-Service -Name HomeGroupProvider -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "HomeGroup services have been disabled." -ForegroundColor Green