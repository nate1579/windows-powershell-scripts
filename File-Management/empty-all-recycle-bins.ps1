# Empty All Recycle Bins Script
# Empties recycle bins on all drives

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Emptying all recycle bins..." -ForegroundColor Green

# Empty recycle bins on all drives
Write-Host "Clearing recycle bins on all drives..." -ForegroundColor Yellow
Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object {
    $recyclePath = "$($_.DeviceID)\`$Recycle.Bin"
    if (Test-Path $recyclePath) {
        Remove-Item "$recyclePath\*" -Force -Recurse -ErrorAction SilentlyContinue
    }
}

# Also use built-in command
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "All recycle bins have been emptied." -ForegroundColor Green