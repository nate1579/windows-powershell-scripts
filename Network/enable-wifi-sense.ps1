# Enable WiFi Sense Script
# Enables Windows WiFi Sense password sharing features

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling WiFi Sense..." -ForegroundColor Green

# Enable WiFi Sense
Write-Host "Enabling WiFi Sense password sharing..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowWiFiHotSpotReporting" -Name "Value" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Wifi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Value 1 -Force

Write-Host "WiFi Sense has been enabled." -ForegroundColor Green