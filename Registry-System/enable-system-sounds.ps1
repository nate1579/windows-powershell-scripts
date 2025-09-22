# Enable System Sounds Script
# Enables Windows system sounds

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling system sounds..." -ForegroundColor Green

# Enable system sounds
Write-Host "Setting sound scheme to Windows default..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\AppEvents\Schemes" -Name "(Default)" -Value "Windows Default" -Force

Write-Host "System sounds have been enabled." -ForegroundColor Green