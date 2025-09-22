# Update All Programs Script
# Updates programs using winget and Windows Update

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting program updates..." -ForegroundColor Green

# Check if winget is available
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "`nUpdating programs with winget..." -ForegroundColor Yellow
    winget upgrade --all --silent --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "winget not found. Please install App Installer from Microsoft Store." -ForegroundColor Red
}

# Install and import PSWindowsUpdate module for Windows Updates
Write-Host "`nChecking for Windows Updates..." -ForegroundColor Yellow
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
}
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -AutoReboot

Write-Host "`nProgram updates completed." -ForegroundColor Green