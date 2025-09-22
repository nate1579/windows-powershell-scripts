# Hide Desktop Icons Script
# Hides all desktop icons

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Hiding desktop icons..." -ForegroundColor Green

# Hide desktop icons
Write-Host "Setting desktop icons to hidden..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 1 -Force

# Refresh desktop
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Desktop icons have been hidden." -ForegroundColor Green