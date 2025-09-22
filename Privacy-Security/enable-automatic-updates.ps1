# Enable Automatic Updates Script
# Enables Windows automatic updates

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling automatic updates..." -ForegroundColor Green

# Enable automatic updates
Write-Host "Setting Windows Update to automatic..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Value 4 -Force

# Start Windows Update service
Write-Host "Starting Windows Update service..." -ForegroundColor Yellow
Set-Service -Name wuauserv -StartupType Automatic
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

Write-Host "Automatic updates have been enabled." -ForegroundColor Green