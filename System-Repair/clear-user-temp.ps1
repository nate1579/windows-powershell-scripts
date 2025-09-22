# Clear User Temp Script
# Removes temporary files from the current user's temp folder

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing user temporary files..." -ForegroundColor Green

# Clear user temp folder
$userTemp = "$env:TEMP"
if (Test-Path $userTemp) {
    Write-Host "Clearing $userTemp..." -ForegroundColor Yellow
    Remove-Item "$userTemp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "User temp folder has been cleared." -ForegroundColor Green
} else {
    Write-Host "User temp folder not found." -ForegroundColor Yellow
}