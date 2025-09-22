# Clear Recycle Bin Script
# Empties the recycle bin for all drives

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing Recycle Bin..." -ForegroundColor Green

# Clear recycle bin for all drives
Clear-RecycleBin -Force

Write-Host "Recycle Bin has been emptied." -ForegroundColor Green