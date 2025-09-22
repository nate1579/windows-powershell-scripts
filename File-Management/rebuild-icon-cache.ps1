# Rebuild Icon Cache Script
# Rebuilds Windows icon cache

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Rebuilding icon cache..." -ForegroundColor Green

# Stop Explorer
Write-Host "Stopping Windows Explorer..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force

# Clear icon cache
$iconCachePath = "$env:LOCALAPPDATA\IconCache.db"
if (Test-Path $iconCachePath) {
    Write-Host "Clearing icon cache..." -ForegroundColor Yellow
    Remove-Item $iconCachePath -Force -ErrorAction SilentlyContinue
}

# Clear additional icon cache files
$explorerPath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
if (Test-Path $explorerPath) {
    Write-Host "Clearing additional icon cache files..." -ForegroundColor Yellow
    Get-ChildItem $explorerPath -Filter "iconcache_*.db" | Remove-Item -Force -ErrorAction SilentlyContinue
}

# Restart Explorer
Write-Host "Starting Windows Explorer..." -ForegroundColor Yellow
Start-Process explorer

Write-Host "Icon cache has been rebuilt." -ForegroundColor Green