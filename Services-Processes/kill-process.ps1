# Kill Process Script
# Kills all instances of a specified process

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Kill Process Tool" -ForegroundColor Green

# Prompt for process name
$processName = Read-Host "Enter process name to kill (without .exe)"

if ([string]::IsNullOrEmpty($processName)) {
    Write-Host "No process name provided." -ForegroundColor Red
    exit
}

# Check if process exists
$processes = Get-Process -Name $processName -ErrorAction SilentlyContinue

if ($processes) {
    Write-Host "Found $($processes.Count) instance(s) of $processName" -ForegroundColor Yellow

    # Kill all instances
    $processes | ForEach-Object {
        Write-Host "Killing process: $($_.Name) (PID: $($_.Id))" -ForegroundColor Yellow
        Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    }

    Write-Host "All instances of $processName have been terminated." -ForegroundColor Green
} else {
    Write-Host "Process '$processName' not found." -ForegroundColor Red
}