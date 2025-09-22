# Enable Advertising ID Script
# Enables Windows advertising ID tracking

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling advertising ID..." -ForegroundColor Green

# Enable advertising ID
Write-Host "Enabling advertising ID tracking..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 0 -Force

Write-Host "Advertising ID has been enabled." -ForegroundColor Green