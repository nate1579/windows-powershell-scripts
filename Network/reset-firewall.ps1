# Reset Windows Firewall Script
# Resets Windows Firewall to default settings

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Resetting Windows Firewall..." -ForegroundColor Green

# Reset Windows Firewall to defaults
Write-Host "Resetting firewall to default settings..." -ForegroundColor Yellow
netsh advfirewall reset

Write-Host "Windows Firewall has been reset to defaults." -ForegroundColor Green