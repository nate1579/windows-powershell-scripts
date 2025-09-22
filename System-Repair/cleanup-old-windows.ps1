# Cleanup Old Windows Installation Script
# Removes Windows.old folder and previous Windows installations

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting cleanup of old Windows installations..." -ForegroundColor Green

# Run Disk Cleanup utility to remove previous Windows installations
Write-Host "`nRunning Disk Cleanup to remove previous Windows installations..." -ForegroundColor Yellow
cleanmgr.exe /d C: /VERYLOWDISK

# Also run DISM to cleanup old Windows installations
Write-Host "`nRunning DISM cleanup for previous Windows installations..." -ForegroundColor Yellow
dism /online /cleanup-image /startcomponentcleanup /resetbase

Write-Host "`nCleanup process completed." -ForegroundColor Green
Write-Host "Old Windows installation files have been removed." -ForegroundColor Cyan