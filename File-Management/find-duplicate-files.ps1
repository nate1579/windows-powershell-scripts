# Find Duplicate Files Script
# Finds duplicate files in specified directory

# Check if running as administrator, if not, restart as admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Elevating to administrator privileges..." -ForegroundColor Yellow
    Start-Process PowerShell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""
    exit
}

Write-Host "Finding duplicate files..." -ForegroundColor Green

# Prompt for directory
$searchPath = Read-Host "Enter directory path to search for duplicates (or press Enter for C:\Users\$env:USERNAME)"
if ([string]::IsNullOrEmpty($searchPath)) {
    $searchPath = "C:\Users\$env:USERNAME"
}

Write-Host "Searching for duplicates in: $searchPath" -ForegroundColor Yellow

# Find duplicate files by size and hash
$files = Get-ChildItem -Path $searchPath -Recurse -File -ErrorAction SilentlyContinue
$duplicates = $files | Group-Object Length | Where-Object { $_.Count -gt 1 } | ForEach-Object {
    $_.Group | ForEach-Object {
        $_ | Add-Member -NotePropertyName Hash -NotePropertyValue (Get-FileHash $_.FullName -Algorithm MD5).Hash -PassThru
    } | Group-Object Hash | Where-Object { $_.Count -gt 1 }
}

if ($duplicates) {
    Write-Host "`nDuplicate files found:" -ForegroundColor Red
    $duplicates | ForEach-Object {
        Write-Host "`nDuplicate set (Size: $($_.Group[0].Length) bytes):" -ForegroundColor Yellow
        $_.Group | ForEach-Object { Write-Host "  $($_.FullName)" -ForegroundColor Gray }
    }
} else {
    Write-Host "No duplicate files found." -ForegroundColor Green
}