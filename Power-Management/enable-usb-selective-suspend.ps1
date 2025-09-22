# Enable USB Selective Suspend Script
# Enables USB selective suspend to allow USB devices to go to sleep for power saving

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling USB selective suspend..." -ForegroundColor Green

# Enable USB selective suspend for AC power
Write-Host "Enabling USB selective suspend on AC power..." -ForegroundColor Yellow
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1

# Enable USB selective suspend for battery power
Write-Host "Enabling USB selective suspend on battery power..." -ForegroundColor Yellow
powercfg /setdcvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1

# Apply settings
powercfg /setactive scheme_current

Write-Host "USB selective suspend has been enabled." -ForegroundColor Green