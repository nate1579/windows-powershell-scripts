# Disable Windows Error Reporting Script
# Disables Windows Error Reporting service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Windows Error Reporting..." -ForegroundColor Green

# Disable Error Reporting service
Write-Host "Stopping Error Reporting service..." -ForegroundColor Yellow
Stop-Service -Name WerSvc -Force -ErrorAction SilentlyContinue
Set-Service -Name WerSvc -StartupType Disabled -ErrorAction SilentlyContinue

# Disable Error Reporting via registry
Write-Host "Disabling Error Reporting via registry..." -ForegroundColor Yellow
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Force

Write-Host "Windows Error Reporting has been disabled." -ForegroundColor Green