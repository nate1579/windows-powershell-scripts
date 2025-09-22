# Display System Information Script
# Shows detailed system information

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "System Information Report" -ForegroundColor Green
Write-Host "========================" -ForegroundColor Green

# Operating System Information
$os = Get-WmiObject -Class Win32_OperatingSystem
Write-Host "`nOperating System:" -ForegroundColor Yellow
Write-Host "OS Name: $($os.Caption)"
Write-Host "Version: $($os.Version)"
Write-Host "Build: $($os.BuildNumber)"
Write-Host "Architecture: $($os.OSArchitecture)"
Write-Host "Install Date: $($os.InstallDate)"

# Computer Information
$computer = Get-WmiObject -Class Win32_ComputerSystem
Write-Host "`nComputer Information:" -ForegroundColor Yellow
Write-Host "Computer Name: $($computer.Name)"
Write-Host "Manufacturer: $($computer.Manufacturer)"
Write-Host "Model: $($computer.Model)"
Write-Host "Total RAM: $([math]::Round($computer.TotalPhysicalMemory/1GB, 2)) GB"
Write-Host "Domain: $($computer.Domain)"

# Processor Information
$processor = Get-WmiObject -Class Win32_Processor
Write-Host "`nProcessor Information:" -ForegroundColor Yellow
Write-Host "Name: $($processor.Name)"
Write-Host "Cores: $($processor.NumberOfCores)"
Write-Host "Logical Processors: $($processor.NumberOfLogicalProcessors)"
Write-Host "Max Clock Speed: $($processor.MaxClockSpeed) MHz"

# Disk Information
Write-Host "`nDisk Information:" -ForegroundColor Yellow
Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object {
    $freeSpace = [math]::Round($_.FreeSpace/1GB, 2)
    $totalSize = [math]::Round($_.Size/1GB, 2)
    Write-Host "Drive $($_.DeviceID) - Total: $totalSize GB, Free: $freeSpace GB"
}

Write-Host "`nSystem information report completed." -ForegroundColor Green