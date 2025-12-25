# n8n Uninstallation Script for Windows
# Run this script in PowerShell
# Usage: .\uninstall-n8n.ps1

Write-Host "=== n8n Uninstallation Script for Windows ===" -ForegroundColor Cyan
Write-Host ""

# Function to check if a command exists
function Test-Command {
    param($command)
    $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
}

# Check if n8n is installed
Write-Host "Checking for n8n installation..." -ForegroundColor Yellow
if (-not (Test-Command n8n)) {
    Write-Host "✓ n8n is not installed on this system" -ForegroundColor Green
    Write-Host ""
    $checkData = Read-Host "Would you like to check for n8n data folder? (y/n)"
    if ($checkData -eq 'y' -or $checkData -eq 'Y') {
        # Skip to data removal section
    } else {
        Write-Host "Uninstallation complete!" -ForegroundColor Green
        exit
    }
} else {
    $n8nVersion = n8n --version 2>$null
    Write-Host "Found n8n installation: $n8nVersion" -ForegroundColor Cyan
    Write-Host ""
}

# Check if n8n is running
Write-Host "Checking if n8n is currently running..." -ForegroundColor Yellow
$n8nProcess = Get-Process -Name "node" -ErrorAction SilentlyContinue | Where-Object {$_.CommandLine -like "*n8n*"}
if ($n8nProcess) {
    Write-Host "⚠ n8n is currently running (PID: $($n8nProcess.Id))" -ForegroundColor Yellow
    $stopProcess = Read-Host "Do you want to stop it? (y/n)"
    if ($stopProcess -eq 'y' -or $stopProcess -eq 'Y') {
        Stop-Process -Id $n8nProcess.Id -Force
        Write-Host "✓ Stopped n8n process" -ForegroundColor Green
        Start-Sleep -Seconds 2
    } else {
        Write-Host "⚠ Please stop n8n before uninstalling" -ForegroundColor Yellow
        exit
    }
}
Write-Host ""

# Uninstall n8n
if (Test-Command n8n) {
    Write-Host "Uninstalling n8n..." -ForegroundColor Yellow
    try {
        npm uninstall n8n -g 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ n8n uninstalled successfully!" -ForegroundColor Green
        } else {
            throw "npm uninstallation failed"
        }
    } catch {
        Write-Host "✗ Failed to uninstall n8n" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try running manually: npm uninstall n8n -g" -ForegroundColor Yellow
        exit
    }
}

# Handle data folder
Write-Host ""
Write-Host "=== Data Folder Management ===" -ForegroundColor Cyan
$dataFolder = "$env:USERPROFILE\.n8n"

if (Test-Path $dataFolder) {
    Write-Host "Found n8n data folder at: $dataFolder" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This folder contains:" -ForegroundColor Yellow
    Write-Host "  - All your workflows" -ForegroundColor White
    Write-Host "  - Credentials" -ForegroundColor White
    Write-Host "  - Execution history" -ForegroundColor White
    Write-Host "  - Database" -ForegroundColor White
    Write-Host ""
    Write-Host "⚠ WARNING: This action cannot be undone!" -ForegroundColor Red
    Write-Host ""
    
    $removeData = Read-Host "Do you want to remove the data folder? (yes/no)"
    if ($removeData -eq 'yes' -or $removeData -eq 'YES') {
        Write-Host ""
        Write-Host "Creating backup before deletion..." -ForegroundColor Yellow
        $backupFolder = "$env:USERPROFILE\.n8n_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        
        try {
            Copy-Item -Path $dataFolder -Destination $backupFolder -Recurse -Force
            Write-Host "✓ Backup created at: $backupFolder" -ForegroundColor Green
            Write-Host ""
            
            $confirmDelete = Read-Host "Backup created. Proceed with deletion? (yes/no)"
            if ($confirmDelete -eq 'yes' -or $confirmDelete -eq 'YES') {
                Remove-Item -Path $dataFolder -Recurse -Force
                Write-Host "✓ Data folder removed successfully" -ForegroundColor Green
            } else {
                Write-Host "✓ Data folder kept. Backup available at: $backupFolder" -ForegroundColor Green
            }
        } catch {
            Write-Host "✗ Error during backup/deletion: $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "✓ Data folder kept at: $dataFolder" -ForegroundColor Green
    }
} else {
    Write-Host "No n8n data folder found at: $dataFolder" -ForegroundColor Gray
}

# Clear npm cache (optional)
Write-Host ""
$clearCache = Read-Host "Would you like to clear npm cache? (y/n)"
if ($clearCache -eq 'y' -or $clearCache -eq 'Y') {
    Write-Host "Clearing npm cache..." -ForegroundColor Yellow
    npm cache clean --force
    Write-Host "✓ npm cache cleared" -ForegroundColor Green
}

# Summary
Write-Host ""
Write-Host "=== Uninstallation Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  ✓ n8n package removed" -ForegroundColor Green
if (Test-Path $dataFolder) {
    Write-Host "  ℹ Data folder retained at: $dataFolder" -ForegroundColor Cyan
} else {
    Write-Host "  ✓ Data folder removed" -ForegroundColor Green
}
Write-Host ""
Write-Host "To reinstall n8n in the future, run:" -ForegroundColor Cyan
Write-Host "  npm install n8n -g" -ForegroundColor White
Write-Host ""