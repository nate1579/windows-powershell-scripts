# Check Windows Activation Status Script
# Displays Windows activation status and product key information

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Windows Activation Status" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

# Get activation status
Write-Host "`nChecking activation status..." -ForegroundColor Yellow
$activationStatus = slmgr /xpr

# Get license status
$license = Get-WmiObject -Class SoftwareLicensingProduct | Where-Object { $_.PartialProductKey -and $_.Name -like "*Windows*" }

if ($license) {
    Write-Host "`nLicense Information:" -ForegroundColor Yellow
    Write-Host "Product Name: $($license.Name)"
    Write-Host "License Status: $($license.LicenseStatus)"
    Write-Host "Partial Product Key: $($license.PartialProductKey)"

    # Interpret license status
    switch ($license.LicenseStatus) {
        0 { Write-Host "Status: Unlicensed" -ForegroundColor Red }
        1 { Write-Host "Status: Licensed" -ForegroundColor Green }
        2 { Write-Host "Status: OOB Grace" -ForegroundColor Yellow }
        3 { Write-Host "Status: OOT Grace" -ForegroundColor Yellow }
        4 { Write-Host "Status: Non-Genuine Grace" -ForegroundColor Red }
        5 { Write-Host "Status: Notification" -ForegroundColor Yellow }
        6 { Write-Host "Status: Extended Grace" -ForegroundColor Yellow }
    }
}

# Show detailed activation info
Write-Host "`nDetailed activation information:" -ForegroundColor Yellow
slmgr /dlv

Write-Host "`nActivation status check completed." -ForegroundColor Green