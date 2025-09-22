# Windows Memory Diagnostic Script
# Schedules memory diagnostic to run on next reboot

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting Windows Memory Diagnostic..." -ForegroundColor Green

# Schedule memory diagnostic for next restart
mdsched.exe

Write-Host "Windows Memory Diagnostic has been scheduled." -ForegroundColor Green
Write-Host "Your computer will restart and run the memory test." -ForegroundColor Cyan