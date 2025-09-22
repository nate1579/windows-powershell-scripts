# Disable Hibernate Script
# Disables hibernate feature and deletes hiberfil.sys

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling hibernate..." -ForegroundColor Green

# Disable hibernate
Write-Host "Turning off hibernate feature..." -ForegroundColor Yellow
powercfg /hibernate off

Write-Host "Hibernate has been disabled and hiberfil.sys removed." -ForegroundColor Green