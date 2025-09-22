# Disable Telemetry Script
# Disables Windows telemetry and data collection

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Windows telemetry..." -ForegroundColor Green

# Set telemetry to Security level (0)
Write-Host "Setting telemetry level to Security..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -Force

# Disable Connected User Experiences and Telemetry service
Write-Host "Disabling Connected User Experiences and Telemetry service..." -ForegroundColor Yellow
Stop-Service -Name DiagTrack -Force -ErrorAction SilentlyContinue
Set-Service -Name DiagTrack -StartupType Disabled

# Disable additional telemetry services
Write-Host "Disabling additional telemetry services..." -ForegroundColor Yellow
Stop-Service -Name dmwappushservice -Force -ErrorAction SilentlyContinue
Set-Service -Name dmwappushservice -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "Windows telemetry has been disabled." -ForegroundColor Green