# Enable Windows Indexing Script
# Enables Windows Search indexing service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Windows indexing..." -ForegroundColor Green

# Enable and start Windows Search service
Write-Host "Starting Windows Search service..." -ForegroundColor Yellow
Set-Service -Name WSearch -StartupType Automatic
Start-Service -Name WSearch -ErrorAction SilentlyContinue

Write-Host "Windows indexing has been enabled." -ForegroundColor Green