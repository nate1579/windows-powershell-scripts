# Set Processor Scheduling for Background Services Script
# Optimizes processor scheduling for background services

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting processor scheduling for background services..." -ForegroundColor Green

# Set processor scheduling to optimize for background services
Write-Host "Optimizing for background services..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 24 -Force

Write-Host "Processor scheduling has been optimized for background services." -ForegroundColor Green