# Set Virtual Memory to Automatic Script
# Sets virtual memory (page file) to system managed

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting virtual memory to automatic..." -ForegroundColor Green

# Set virtual memory to system managed
Write-Host "Configuring automatic virtual memory management..." -ForegroundColor Yellow
$cs = Get-WmiObject -Class Win32_ComputerSystem
$cs.AutomaticManagedPagefile = $true
$cs.Put() | Out-Null

Write-Host "Virtual memory has been set to automatic." -ForegroundColor Green