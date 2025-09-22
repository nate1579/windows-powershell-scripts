# Enable HomeGroup Script
# Enables Windows HomeGroup services

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling HomeGroup services..." -ForegroundColor Green

# Enable HomeGroup Listener service
Write-Host "Enabling HomeGroup Listener service..." -ForegroundColor Yellow
Set-Service -Name HomeGroupListener -StartupType Manual -ErrorAction SilentlyContinue
Start-Service -Name HomeGroupListener -ErrorAction SilentlyContinue

# Enable HomeGroup Provider service
Write-Host "Enabling HomeGroup Provider service..." -ForegroundColor Yellow
Set-Service -Name HomeGroupProvider -StartupType Manual -ErrorAction SilentlyContinue
Start-Service -Name HomeGroupProvider -ErrorAction SilentlyContinue

Write-Host "HomeGroup services have been enabled." -ForegroundColor Green