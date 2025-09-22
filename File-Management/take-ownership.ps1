# Take Ownership Script
# Takes ownership of specified files or folders

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Take Ownership Tool" -ForegroundColor Green

# Prompt for path
$targetPath = Read-Host "Enter file or folder path to take ownership of"

if (-not (Test-Path $targetPath)) {
    Write-Host "Path not found: $targetPath" -ForegroundColor Red
    exit
}

Write-Host "Taking ownership of: $targetPath" -ForegroundColor Yellow

# Take ownership using takeown command
if (Test-Path $targetPath -PathType Container) {
    # It's a folder
    takeown /f "$targetPath" /r /d y
    icacls "$targetPath" /grant administrators:F /t
} else {
    # It's a file
    takeown /f "$targetPath"
    icacls "$targetPath" /grant administrators:F
}

Write-Host "Ownership has been taken successfully." -ForegroundColor Green