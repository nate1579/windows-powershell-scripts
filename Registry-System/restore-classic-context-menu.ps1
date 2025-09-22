# Restore Classic Context Menu Script
# Disables Windows 11 "Show more options" and restores classic right-click menu

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Restoring classic context menu..." -ForegroundColor Green

# Registry key to disable new context menu
$regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

# Create the registry key and set empty value to restore classic menu
Write-Host "Modifying registry to restore classic context menu..." -ForegroundColor Yellow
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "(Default)" -Value ""

# Restart Windows Explorer to apply changes
Write-Host "Restarting Windows Explorer to apply changes..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Classic context menu has been restored." -ForegroundColor Green
Write-Host "The 'Show more options' submenu has been disabled." -ForegroundColor Cyan