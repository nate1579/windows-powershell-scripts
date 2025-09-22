# Clear Temporary Internet Files Script
# Clears temporary internet files from all browsers

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing temporary internet files..." -ForegroundColor Green

# Clear IE/Edge temporary files
$iePath = "$env:LOCALAPPDATA\Microsoft\Windows\INetCache"
if (Test-Path $iePath) {
    Write-Host "Clearing Internet Explorer cache..." -ForegroundColor Yellow
    Remove-Item "$iePath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear Chrome temporary files
$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
if (Test-Path $chromePath) {
    Write-Host "Clearing Chrome temporary files..." -ForegroundColor Yellow
    Remove-Item "$chromePath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear Firefox temporary files
$firefoxPath = "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles"
if (Test-Path $firefoxPath) {
    Write-Host "Clearing Firefox temporary files..." -ForegroundColor Yellow
    Get-ChildItem $firefoxPath | ForEach-Object {
        $cachePath = Join-Path $_.FullName "cache2"
        if (Test-Path $cachePath) {
            Remove-Item "$cachePath\*" -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Temporary internet files have been cleared." -ForegroundColor Green