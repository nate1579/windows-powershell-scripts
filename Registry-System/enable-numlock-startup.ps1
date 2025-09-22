# Enable NumLock on Startup Script
# Enables NumLock to be turned on automatically at Windows startup

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling NumLock on startup..." -ForegroundColor Green

# Enable NumLock on startup
Write-Host "Setting NumLock to turn on at startup..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value 2 -Force

Write-Host "NumLock will now be enabled on startup." -ForegroundColor Green