# Disable Sleep and Hibernate Script
# Disables sleep and hibernate power settings

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling sleep and hibernate..." -ForegroundColor Green

# Disable hibernate
Write-Host "Disabling hibernate..." -ForegroundColor Yellow
powercfg /hibernate off

# Disable sleep timeouts
Write-Host "Disabling sleep timeouts..." -ForegroundColor Yellow
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

# Disable monitor timeout (optional - keeps display on)
Write-Host "Disabling monitor timeout..." -ForegroundColor Yellow
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

Write-Host "Sleep and hibernate have been disabled." -ForegroundColor Green