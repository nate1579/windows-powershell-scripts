# Reset Network Configuration Script
# Resets various network settings to defaults

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Resetting network configuration..." -ForegroundColor Green

# Reset IP stack
Write-Host "Resetting IP stack..." -ForegroundColor Yellow
netsh int ip reset

# Reset Winsock catalog
Write-Host "Resetting Winsock catalog..." -ForegroundColor Yellow
netsh winsock reset

# Reset Windows Firewall
Write-Host "Resetting Windows Firewall..." -ForegroundColor Yellow
netsh advfirewall reset

# Flush DNS cache
Write-Host "Flushing DNS cache..." -ForegroundColor Yellow
ipconfig /flushdns

# Release and renew IP
Write-Host "Releasing and renewing IP..." -ForegroundColor Yellow
ipconfig /release
ipconfig /renew

Write-Host "Network configuration has been reset." -ForegroundColor Green
Write-Host "Please restart your computer to complete the reset." -ForegroundColor Cyan