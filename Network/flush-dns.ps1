# Flush DNS Script
# Clears the DNS resolver cache

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Flushing DNS cache..." -ForegroundColor Green

# Flush DNS cache
ipconfig /flushdns

Write-Host "DNS cache has been flushed." -ForegroundColor Green