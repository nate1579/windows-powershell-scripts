# Show WiFi Passwords Script
# Displays saved WiFi passwords

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Showing saved WiFi passwords..." -ForegroundColor Green

# Get all WiFi profiles
$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }

foreach ($profile in $profiles) {
    Write-Host "`nProfile: $profile" -ForegroundColor Yellow
    $password = netsh wlan show profile name="$profile" key=clear | Select-String "Key Content" | ForEach-Object { ($_ -split ":")[1].Trim() }
    if ($password) {
        Write-Host "Password: $password" -ForegroundColor Green
    } else {
        Write-Host "No password or open network" -ForegroundColor Gray
    }
}

Write-Host "`nAll saved WiFi passwords have been displayed." -ForegroundColor Green