# Create System Restore Point Script
# Creates a new system restore point

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Creating system restore point..." -ForegroundColor Green

# Create restore point with current date/time
$description = "Manual Restore Point - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "Creating restore point: $description" -ForegroundColor Yellow

Checkpoint-Computer -Description $description -RestorePointType "MODIFY_SETTINGS"

Write-Host "System restore point has been created." -ForegroundColor Green