# Set Balanced Power Plan Script
# Sets Windows to balanced power plan

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting balanced power plan..." -ForegroundColor Green

# Set balanced power plan
Write-Host "Activating balanced plan..." -ForegroundColor Yellow
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

Write-Host "Balanced power plan has been activated." -ForegroundColor Green