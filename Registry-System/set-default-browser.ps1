# Set Default Browser Script
# Sets default web browser

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Set Default Browser Tool" -ForegroundColor Green

Write-Host "`nAvailable browsers:" -ForegroundColor Yellow
Write-Host "1. Chrome"
Write-Host "2. Firefox"
Write-Host "3. Edge"
Write-Host "4. Internet Explorer"

$choice = Read-Host "`nEnter your choice (1-4)"

switch ($choice) {
    "1" {
        $browser = "ChromeHTML"
        $browserName = "Chrome"
    }
    "2" {
        $browser = "FirefoxURL"
        $browserName = "Firefox"
    }
    "3" {
        $browser = "MSEdgeHTM"
        $browserName = "Edge"
    }
    "4" {
        $browser = "IE.HTTP"
        $browserName = "Internet Explorer"
    }
    default {
        Write-Host "Invalid choice." -ForegroundColor Red
        exit
    }
}

Write-Host "Setting $browserName as default browser..." -ForegroundColor Yellow

# Set default browser associations
$associations = @("http", "https", "ftp", "html", "htm")
foreach ($assoc in $associations) {
    cmd /c "assoc .$assoc=$browser" 2>$null
}

Write-Host "$browserName has been set as the default browser." -ForegroundColor Green