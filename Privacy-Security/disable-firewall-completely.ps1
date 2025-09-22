# Disable Windows Firewall Completely Script
# Disables Windows Firewall for all profiles

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Windows Firewall completely..." -ForegroundColor Green

# Disable firewall for all profiles
Write-Host "Disabling firewall for all profiles..." -ForegroundColor Yellow
netsh advfirewall set allprofiles state off

Write-Host "Windows Firewall has been disabled for all profiles." -ForegroundColor Green