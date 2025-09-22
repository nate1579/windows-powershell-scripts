# Clear Recent Documents Script
# Clears recent documents history

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Clearing recent documents..." -ForegroundColor Green

# Clear recent documents
$recentPath = "$env:APPDATA\Microsoft\Windows\Recent"
if (Test-Path $recentPath) {
    Write-Host "Clearing recent documents..." -ForegroundColor Yellow
    Remove-Item "$recentPath\*" -Force -Recurse -ErrorAction SilentlyContinue
}

# Clear Office recent files
$officeVersions = @("16.0", "15.0", "14.0")
foreach ($version in $officeVersions) {
    $officePath = "HKCU:\Software\Microsoft\Office\$version"
    if (Test-Path $officePath) {
        Write-Host "Clearing Office $version recent files..." -ForegroundColor Yellow
        Get-ChildItem $officePath -Recurse | Where-Object { $_.Name -like "*File MRU*" } | ForEach-Object {
            Remove-Item $_.PSPath -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Recent documents have been cleared." -ForegroundColor Green