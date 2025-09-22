# Disable Windows Defender Script
# Disables Windows Defender real-time protection

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Windows Defender..." -ForegroundColor Green

# Disable Windows Defender real-time protection
Write-Host "Disabling real-time protection..." -ForegroundColor Yellow
Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue

# Disable Windows Defender services
Write-Host "Disabling Windows Defender services..." -ForegroundColor Yellow
Set-Service -Name WinDefend -StartupType Disabled -ErrorAction SilentlyContinue
Stop-Service -Name WinDefend -Force -ErrorAction SilentlyContinue

Write-Host "Windows Defender has been disabled." -ForegroundColor Green