# Disk Check Script
# Runs chkdsk on all available drives

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Starting disk check process..." -ForegroundColor Green

# Get all fixed drives
$drives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }

foreach ($drive in $drives) {
    $driveLetter = $drive.DeviceID
    Write-Host "`nChecking drive $driveLetter..." -ForegroundColor Yellow

    # Run chkdsk with /f (fix errors) and /r (locate bad sectors and recover readable information)
    chkdsk $driveLetter /f /r
}

Write-Host "`nDisk check process completed." -ForegroundColor Green
Write-Host "Please restart your computer if prompted." -ForegroundColor Cyan