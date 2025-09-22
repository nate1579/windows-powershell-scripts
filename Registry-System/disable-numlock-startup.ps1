# Disable NumLock on Startup Script
# Disables NumLock from being turned on automatically at Windows startup

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling NumLock on startup..." -ForegroundColor Green

# Disable NumLock on startup
Write-Host "Setting NumLock to remain off at startup..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value 0 -Force

Write-Host "NumLock will now be disabled on startup." -ForegroundColor Green