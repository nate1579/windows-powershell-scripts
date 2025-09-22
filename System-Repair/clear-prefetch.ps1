# Clear Prefetch Script
# Removes all files from the Windows Prefetch folder

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing Prefetch folder..." -ForegroundColor Green

# Clear prefetch folder
$prefetchPath = "$env:SystemRoot\Prefetch"
if (Test-Path $prefetchPath) {
    Remove-Item "$prefetchPath\*" -Force -Recurse
    Write-Host "Prefetch folder has been cleared." -ForegroundColor Green
} else {
    Write-Host "Prefetch folder not found." -ForegroundColor Yellow
}