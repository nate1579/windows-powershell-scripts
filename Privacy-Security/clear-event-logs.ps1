# Clear Windows Event Logs Script
# Clears all Windows event logs

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing Windows event logs..." -ForegroundColor Green

# Clear all event logs
Write-Host "Clearing all event logs..." -ForegroundColor Yellow
Get-EventLog -List | ForEach-Object { Clear-EventLog -LogName $_.Log -ErrorAction SilentlyContinue }

# Clear additional logs using WevtUtil
Write-Host "Clearing additional logs..." -ForegroundColor Yellow
wevtutil el | ForEach-Object { wevtutil cl $_ 2>$null }

Write-Host "All Windows event logs have been cleared." -ForegroundColor Green