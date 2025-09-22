# Enable Windows Firewall Completely Script
# Enables Windows Firewall for all profiles

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows Firewall completely..." -ForegroundColor Green

# Enable firewall for all profiles
Write-Host "Enabling firewall for all profiles..." -ForegroundColor Yellow
netsh advfirewall set allprofiles state on

Write-Host "Windows Firewall has been enabled for all profiles." -ForegroundColor Green