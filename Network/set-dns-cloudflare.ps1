# Set DNS to Cloudflare Script
# Sets DNS servers to Cloudflare DNS (1.1.1.1 and 1.0.0.1)

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting DNS to Cloudflare DNS..." -ForegroundColor Green

# Set DNS to Cloudflare DNS for all active network adapters
Write-Host "Configuring DNS servers..." -ForegroundColor Yellow
$adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
foreach ($adapter in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses "1.1.1.1","1.0.0.1"
}

Write-Host "DNS has been set to Cloudflare DNS (1.1.1.1, 1.0.0.1)." -ForegroundColor Green