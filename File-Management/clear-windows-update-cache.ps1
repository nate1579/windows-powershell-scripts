# Clear Windows Update Cache Script
# Clears Windows Update download cache

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing Windows Update cache..." -ForegroundColor Green

# Stop Windows Update service
Write-Host "Stopping Windows Update service..." -ForegroundColor Yellow
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue

# Clear Windows Update cache
$updateCachePath = "$env:SystemRoot\SoftwareDistribution\Download"
if (Test-Path $updateCachePath) {
    Write-Host "Clearing update cache..." -ForegroundColor Yellow
    Remove-Item "$updateCachePath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Restart Windows Update service
Write-Host "Starting Windows Update service..." -ForegroundColor Yellow
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

Write-Host "Windows Update cache has been cleared." -ForegroundColor Green