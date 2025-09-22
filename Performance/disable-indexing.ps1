# Disable Windows Indexing Script
# Disables Windows Search indexing service

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling Windows indexing..." -ForegroundColor Green

# Stop and disable Windows Search service
Write-Host "Stopping Windows Search service..." -ForegroundColor Yellow
Stop-Service -Name WSearch -Force -ErrorAction SilentlyContinue
Set-Service -Name WSearch -StartupType Disabled

Write-Host "Windows indexing has been disabled." -ForegroundColor Green