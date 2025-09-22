# List Installed Programs Script
# Lists all installed programs with versions

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Installed Programs Report" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

Write-Host "`nScanning installed programs..." -ForegroundColor Yellow

# Get installed programs from registry
$programs = @()

# 64-bit programs
$programs += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Where-Object { $_.DisplayName -and $_.DisplayName -notlike "Update for*" -and $_.DisplayName -notlike "Security Update*" } |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

# 32-bit programs on 64-bit systems
if ([Environment]::Is64BitOperatingSystem) {
    $programs += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Where-Object { $_.DisplayName -and $_.DisplayName -notlike "Update for*" -and $_.DisplayName -notlike "Security Update*" } |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
}

# Sort and display
$programs | Sort-Object DisplayName | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize

Write-Host "`nTotal programs found: $($programs.Count)" -ForegroundColor Green
Write-Host "Installed programs report completed." -ForegroundColor Green