# Set DNS to Google Script
# Sets DNS servers to Google DNS (8.8.8.8 and 8.8.4.4)

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting DNS to Google DNS..." -ForegroundColor Green

# Set DNS to Google DNS for all active network adapters
Write-Host "Configuring DNS servers..." -ForegroundColor Yellow
$adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
foreach ($adapter in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses "8.8.8.8","8.8.4.4"
}

Write-Host "DNS has been set to Google DNS (8.8.8.8, 8.8.4.4)." -ForegroundColor Green