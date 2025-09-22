# Enable Windows Update P2P Sharing Script
# Enables peer-to-peer sharing of Windows Updates

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows Update P2P sharing..." -ForegroundColor Green

# Enable Windows Update P2P sharing
Write-Host "Enabling delivery optimization..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 1 -Force

Write-Host "Windows Update P2P sharing has been enabled." -ForegroundColor Green