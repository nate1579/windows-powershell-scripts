# Clear Windows Temp Script
# Removes temporary files from Windows and user temp folders

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing temporary files..." -ForegroundColor Green

# Clear Windows temp folder
$windowsTemp = "$env:SystemRoot\Temp"
if (Test-Path $windowsTemp) {
    Write-Host "Clearing Windows temp folder..." -ForegroundColor Yellow
    Remove-Item "$windowsTemp\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear user temp folder
$userTemp = "$env:TEMP"
if (Test-Path $userTemp) {
    Write-Host "Clearing user temp folder..." -ForegroundColor Yellow
    Remove-Item "$userTemp\*" -Force -Recurse -ErrorAction SilentlyContinue
}

Write-Host "Temporary files have been cleared." -ForegroundColor Green