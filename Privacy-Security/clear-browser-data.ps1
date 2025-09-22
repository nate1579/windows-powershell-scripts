# Clear Browser Data Script
# Clears cache and data from Chrome, Edge, and Firefox

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing browser data..." -ForegroundColor Green

# Clear Chrome cache
$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
if (Test-Path $chromePath) {
    Write-Host "Clearing Chrome cache..." -ForegroundColor Yellow
    Remove-Item "$chromePath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear Edge cache
$edgePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"
if (Test-Path $edgePath) {
    Write-Host "Clearing Edge cache..." -ForegroundColor Yellow
    Remove-Item "$edgePath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear Firefox cache
$firefoxPath = "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles"
if (Test-Path $firefoxPath) {
    Write-Host "Clearing Firefox cache..." -ForegroundColor Yellow
    Get-ChildItem $firefoxPath | ForEach-Object {
        $cachePath = Join-Path $_.FullName "cache2"
        if (Test-Path $cachePath) {
            Remove-Item "$cachePath\*" -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Browser data has been cleared." -ForegroundColor Green