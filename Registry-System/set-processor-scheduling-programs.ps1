# Set Processor Scheduling for Programs Script
# Optimizes processor scheduling for foreground programs

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting processor scheduling for programs..." -ForegroundColor Green

# Set processor scheduling to optimize for programs
Write-Host "Optimizing for foreground programs..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -Force

Write-Host "Processor scheduling has been optimized for programs." -ForegroundColor Green