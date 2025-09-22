# Enable Windows Error Reporting Script
# Enables Windows Error Reporting service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows Error Reporting..." -ForegroundColor Green

# Enable Error Reporting service
Write-Host "Starting Error Reporting service..." -ForegroundColor Yellow
Set-Service -Name WerSvc -StartupType Manual -ErrorAction SilentlyContinue
Start-Service -Name WerSvc -ErrorAction SilentlyContinue

# Enable Error Reporting via registry
Write-Host "Enabling Error Reporting via registry..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 0 -Force

Write-Host "Windows Error Reporting has been enabled." -ForegroundColor Green