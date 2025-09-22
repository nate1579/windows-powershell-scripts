# Reset Windows Store Cache Script
# Resets Windows Store cache using wsreset

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Resetting Windows Store cache..." -ForegroundColor Green

# Reset Windows Store cache
Write-Host "Running wsreset..." -ForegroundColor Yellow
wsreset.exe

Write-Host "Windows Store cache has been reset." -ForegroundColor Green