# Enable Sleep Script
# Enables sleep power settings with default timeouts

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling sleep..." -ForegroundColor Green

# Enable sleep timeouts (30 minutes on AC, 15 minutes on battery)
Write-Host "Setting sleep timeouts..." -ForegroundColor Yellow
powercfg /change standby-timeout-ac 30
powercfg /change standby-timeout-dc 15

Write-Host "Sleep has been enabled with default timeouts." -ForegroundColor Green