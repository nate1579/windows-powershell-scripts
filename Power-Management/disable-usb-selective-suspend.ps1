# Disable USB Selective Suspend Script
# Disables USB selective suspend to prevent USB devices from going to sleep

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling USB selective suspend..." -ForegroundColor Green

# Disable USB selective suspend for AC power
Write-Host "Disabling USB selective suspend on AC power..." -ForegroundColor Yellow
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

# Disable USB selective suspend for battery power
Write-Host "Disabling USB selective suspend on battery power..." -ForegroundColor Yellow
powercfg /setdcvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

# Apply settings
powercfg /setactive scheme_current

Write-Host "USB selective suspend has been disabled." -ForegroundColor Green