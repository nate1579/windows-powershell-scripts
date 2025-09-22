# Clear Thumbnail Cache Script
# Clears Windows thumbnail cache

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing thumbnail cache..." -ForegroundColor Green

# Clear thumbnail cache
$thumbnailPath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
if (Test-Path $thumbnailPath) {
    Write-Host "Clearing thumbnail cache files..." -ForegroundColor Yellow
    Get-ChildItem $thumbnailPath -Filter "thumbcache_*.db" | Remove-Item -Force -ErrorAction SilentlyContinue
}

Write-Host "Thumbnail cache has been cleared." -ForegroundColor Green