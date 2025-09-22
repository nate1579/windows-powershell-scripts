# Release and Renew IP Script
# Releases current IP address and requests a new one from DHCP

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Releasing and renewing IP address..." -ForegroundColor Green

# Release current IP address
Write-Host "Releasing current IP address..." -ForegroundColor Yellow
ipconfig /release

# Renew IP address
Write-Host "Renewing IP address..." -ForegroundColor Yellow
ipconfig /renew

Write-Host "IP address has been released and renewed." -ForegroundColor Green