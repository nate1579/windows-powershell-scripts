# Auto Flush DNS on Startup Script
# Creates a scheduled task to flush DNS cache on startup

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting up auto DNS flush on startup..." -ForegroundColor Green

# Create scheduled task to flush DNS on startup
Write-Host "Creating scheduled task..." -ForegroundColor Yellow
$action = New-ScheduledTaskAction -Execute "ipconfig" -Argument "/flushdns"
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "AutoFlushDNS" -Action $action -Trigger $trigger -Principal $principal -Force

Write-Host "Auto DNS flush on startup has been configured." -ForegroundColor Green