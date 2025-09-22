# Show Hardware Temperature Script
# Displays hardware temperature information (if available)

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Hardware Temperature Information" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

Write-Host "`nChecking for temperature sensors..." -ForegroundColor Yellow

try {
    # Try to get temperature from WMI
    $tempSensors = Get-WmiObject -Namespace "root\wmi" -Class MSAcpi_ThermalZoneTemperature -ErrorAction SilentlyContinue

    if ($tempSensors) {
        Write-Host "`nThermal Zone Temperatures:" -ForegroundColor Yellow
        $tempSensors | ForEach-Object {
            $tempCelsius = [math]::Round(($_.CurrentTemperature / 10) - 273.15, 1)
            $tempFahrenheit = [math]::Round(($tempCelsius * 9/5) + 32, 1)
            Write-Host "Zone: $($_.InstanceName) - $tempCelsius°C ($tempFahrenheit°F)"
        }
    } else {
        Write-Host "No thermal zone sensors found via WMI." -ForegroundColor Yellow
    }

    # Try to get CPU temperature
    $cpuTemp = Get-WmiObject -Class Win32_PerfRawData_Counters_ThermalZoneInformation -ErrorAction SilentlyContinue
    if ($cpuTemp) {
        Write-Host "`nCPU Temperature Zones:" -ForegroundColor Yellow
        $cpuTemp | ForEach-Object {
            $tempKelvin = $_.HighPrecisionTemperature / 10
            $tempCelsius = [math]::Round($tempKelvin - 273.15, 1)
            Write-Host "Zone: $($_.Name) - $tempCelsius°C"
        }
    }

} catch {
    Write-Host "Temperature sensors not accessible or not available." -ForegroundColor Red
}

Write-Host "`nNote: Temperature monitoring requires specific hardware support." -ForegroundColor Cyan
Write-Host "For detailed temperature monitoring, consider using specialized tools like HWiNFO64." -ForegroundColor Cyan

Write-Host "`nHardware temperature check completed." -ForegroundColor Green