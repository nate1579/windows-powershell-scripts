# Disable System Sounds Script
# Disables Windows system sounds

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Disabling system sounds..." -ForegroundColor Green

# Disable system sounds
Write-Host "Setting sound scheme to none..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\AppEvents\Schemes" -Name "(Default)" -Value ".None" -Force

# Disable specific sound events
$soundEvents = @(
    "SystemStart", "SystemExit", "CriticalBatteryAlarm", "LowBatteryAlarm",
    "MailBeep", "NewMail", "Notification.Default", "WindowsLogoff", "WindowsLogon"
)

foreach ($event in $soundEvents) {
    $path = "HKCU:\AppEvents\Schemes\Apps\.Default\$event\.Current"
    if (Test-Path $path) {
        Set-ItemProperty -Path $path -Name "(Default)" -Value "" -Force
    }
}

Write-Host "System sounds have been disabled." -ForegroundColor Green