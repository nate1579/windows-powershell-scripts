# Add PowerShell to Context Menu Script
# Adds "Open PowerShell here" to right-click context menu

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Adding PowerShell to context menu..." -ForegroundColor Green

# Add PowerShell to folder context menu
Write-Host "Adding PowerShell to folder context menu..." -ForegroundColor Yellow
New-Item -Path "HKCR:\Directory\shell\PowerShell" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\Directory\shell\PowerShell" -Name "(Default)" -Value "Open PowerShell here" -Force
New-Item -Path "HKCR:\Directory\shell\PowerShell\command" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\Directory\shell\PowerShell\command" -Name "(Default)" -Value "powershell.exe -noexit -command Set-Location '%1'" -Force

# Add PowerShell to background context menu
Write-Host "Adding PowerShell to background context menu..." -ForegroundColor Yellow
New-Item -Path "HKCR:\Directory\Background\shell\PowerShell" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\Directory\Background\shell\PowerShell" -Name "(Default)" -Value "Open PowerShell here" -Force
New-Item -Path "HKCR:\Directory\Background\shell\PowerShell\command" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\Directory\Background\shell\PowerShell\command" -Name "(Default)" -Value "powershell.exe -noexit -command Set-Location '%V'" -Force

Write-Host "PowerShell has been added to context menu." -ForegroundColor Green