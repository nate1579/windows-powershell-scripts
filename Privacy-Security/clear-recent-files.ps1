# Clear Recent Files History Script
# Clears Windows recent files and folders history

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing recent files history..." -ForegroundColor Green

# Clear recent files
$recentPath = "$env:APPDATA\Microsoft\Windows\Recent"
if (Test-Path $recentPath) {
    Write-Host "Clearing recent files..." -ForegroundColor Yellow
    Remove-Item "$recentPath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear jump lists
$jumpListPath = "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations"
if (Test-Path $jumpListPath) {
    Write-Host "Clearing jump lists..." -ForegroundColor Yellow
    Remove-Item "$jumpListPath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

Write-Host "Recent files history has been cleared." -ForegroundColor Green