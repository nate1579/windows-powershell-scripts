# Enable Sticky Keys Script
# Enables Sticky Keys accessibility feature

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Enabling Sticky Keys..." -ForegroundColor Green

# Enable Sticky Keys
Write-Host "Enabling Sticky Keys feature..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "510" -Force

Write-Host "Sticky Keys has been enabled." -ForegroundColor Green