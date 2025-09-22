# Manage Scheduled Tasks Script
# Lists and manages Windows scheduled tasks

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Managing Scheduled Tasks" -ForegroundColor Green

# List all scheduled tasks
Write-Host "`nActive scheduled tasks:" -ForegroundColor Yellow
Get-ScheduledTask | Where-Object { $_.State -eq "Ready" } | Select-Object TaskName, TaskPath, State | Format-Table -AutoSize

Write-Host "`nTo disable a task, use:" -ForegroundColor Cyan
Write-Host "Disable-ScheduledTask -TaskName 'TaskName'" -ForegroundColor Gray

Write-Host "`nTo enable a task, use:" -ForegroundColor Cyan
Write-Host "Enable-ScheduledTask -TaskName 'TaskName'" -ForegroundColor Gray

Write-Host "`nScheduled tasks have been listed." -ForegroundColor Green