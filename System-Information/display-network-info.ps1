# Display Network Information Script
# Shows detailed network adapter and connection information

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Network Information Report" -ForegroundColor Green
Write-Host "==========================" -ForegroundColor Green

# Network Adapters
Write-Host "`nNetwork Adapters:" -ForegroundColor Yellow
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed | Format-Table -AutoSize

# IP Configuration
Write-Host "`nIP Configuration:" -ForegroundColor Yellow
Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" -and $_.IPAddress -ne "127.0.0.1" } |
    Select-Object InterfaceAlias, IPAddress, PrefixLength | Format-Table -AutoSize

# DNS Servers
Write-Host "`nDNS Servers:" -ForegroundColor Yellow
Get-DnsClientServerAddress | Where-Object { $_.ServerAddresses } |
    Select-Object InterfaceAlias, ServerAddresses | Format-Table -AutoSize

# Default Gateway
Write-Host "`nDefault Gateways:" -ForegroundColor Yellow
Get-NetRoute | Where-Object { $_.DestinationPrefix -eq "0.0.0.0/0" } |
    Select-Object InterfaceAlias, NextHop | Format-Table -AutoSize

# Network Statistics
Write-Host "`nNetwork Statistics:" -ForegroundColor Yellow
Get-NetAdapterStatistics | Where-Object { $_.BytesReceived -gt 0 -or $_.BytesSent -gt 0 } |
    Select-Object Name, BytesReceived, BytesSent | Format-Table -AutoSize

# Wireless Networks (if Wi-Fi is available)
try {
    $wifiProfiles = netsh wlan show profiles 2>$null
    if ($wifiProfiles) {
        Write-Host "`nWi-Fi Profiles:" -ForegroundColor Yellow
        $wifiProfiles | Select-String "All User Profile" | ForEach-Object {
            $profileName = ($_ -split ":")[1].Trim()
            Write-Host "  $profileName"
        }
    }
} catch {
    Write-Host "Wi-Fi information not available." -ForegroundColor Gray
}

Write-Host "`nNetwork information report completed." -ForegroundColor Green