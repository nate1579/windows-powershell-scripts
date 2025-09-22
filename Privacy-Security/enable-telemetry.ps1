# Enable Telemetry Script
# Enables Windows telemetry and data collection

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows telemetry..." -ForegroundColor Green

# Set telemetry to Full level (3)
Write-Host "Setting telemetry level to Full..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 3 -Force

# Enable Connected User Experiences and Telemetry service
Write-Host "Enabling Connected User Experiences and Telemetry service..." -ForegroundColor Yellow
Set-Service -Name DiagTrack -StartupType Automatic
Start-Service -Name DiagTrack -ErrorAction SilentlyContinue

# Enable additional telemetry services
Write-Host "Enabling additional telemetry services..." -ForegroundColor Yellow
Set-Service -Name dmwappushservice -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name dmwappushservice -ErrorAction SilentlyContinue

Write-Host "Windows telemetry has been enabled." -ForegroundColor Green