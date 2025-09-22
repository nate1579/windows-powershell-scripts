# Enable Hibernate Script
# Enables hibernate feature and creates hiberfil.sys

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling hibernate..." -ForegroundColor Green

# Enable hibernate
Write-Host "Turning on hibernate feature..." -ForegroundColor Yellow
powercfg /hibernate on

Write-Host "Hibernate has been enabled and hiberfil.sys created." -ForegroundColor Green