# Set Services to Manual Script
# Sets non-essential Windows services to manual startup

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Setting non-essential services to manual..." -ForegroundColor Green

# List of services to set to manual
$servicesToManual = @(
    "Fax", "TabletInputService", "WSearch", "SysMain", "Themes",
    "WMPNetworkSvc", "WinRM", "RemoteRegistry", "Browser"
)

foreach ($service in $servicesToManual) {
    $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($svc) {
        Write-Host "Setting $service to manual..." -ForegroundColor Yellow
        Set-Service -Name $service -StartupType Manual -ErrorAction SilentlyContinue
    }
}

Write-Host "Non-essential services have been set to manual startup." -ForegroundColor Green