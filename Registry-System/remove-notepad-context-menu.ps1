# Remove Notepad from Context Menu Script
# Removes "Edit with Notepad" from right-click context menu

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Removing Notepad from context menu..." -ForegroundColor Green

# Remove Notepad from various file type context menus
$fileTypes = @("*", "txtfile", "batfile", "cmdfile", "regfile")

foreach ($type in $fileTypes) {
    $path = "HKCR:\$type\shell\edit"
    if (Test-Path $path) {
        Write-Host "Removing Notepad from $type context menu..." -ForegroundColor Yellow
        Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Notepad has been removed from context menu." -ForegroundColor Green