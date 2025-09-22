# Enable Windows Defender Script
# Enables Windows Defender real-time protection

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows Defender..." -ForegroundColor Green

# Enable Windows Defender services
Write-Host "Enabling Windows Defender services..." -ForegroundColor Yellow
Set-Service -Name WinDefend -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name WinDefend -ErrorAction SilentlyContinue

# Enable Windows Defender real-time protection
Write-Host "Enabling real-time protection..." -ForegroundColor Yellow
Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue

Write-Host "Windows Defender has been enabled." -ForegroundColor Green