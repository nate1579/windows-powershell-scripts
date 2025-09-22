# Manage Startup Programs Script
# Lists and manages Windows startup programs

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Managing startup programs..." -ForegroundColor Green

# List all startup programs
Write-Host "`nCurrent startup programs:" -ForegroundColor Yellow
Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table -AutoSize

Write-Host "`nTo disable a startup program, use:" -ForegroundColor Cyan
Write-Host "Disable-ScheduledTask -TaskName 'TaskName'" -ForegroundColor Gray
Write-Host "Or use Task Scheduler GUI or System Configuration (msconfig)" -ForegroundColor Gray

Write-Host "`nStartup programs have been listed." -ForegroundColor Green