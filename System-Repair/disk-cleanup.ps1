# Disk Cleanup Script
# Runs Windows Disk Cleanup utility

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting Disk Cleanup..." -ForegroundColor Green

# Run Disk Cleanup for C: drive with automatic cleanup
cleanmgr.exe /d C: /VERYLOWDISK

Write-Host "Disk Cleanup has been launched." -ForegroundColor Green