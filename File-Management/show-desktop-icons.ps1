# Show Desktop Icons Script
# Shows all desktop icons

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Showing desktop icons..." -ForegroundColor Green

# Show desktop icons
Write-Host "Setting desktop icons to visible..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 0 -Force

# Refresh desktop
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Desktop icons are now visible." -ForegroundColor Green