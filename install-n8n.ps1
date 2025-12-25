# n8n Installation Script for Windows
# Run this script in PowerShell as Administrator
# Usage: .\install-n8n.ps1

Write-Host "=== n8n Installation Script for Windows ===" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "WARNING: Not running as Administrator. Some operations may fail." -ForegroundColor Yellow
    Write-Host "Consider running PowerShell as Administrator for best results." -ForegroundColor Yellow
    Write-Host ""
}

# Function to check if a command exists
function Test-Command {
    param($command)
    $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
}

# Check if Node.js is installed
Write-Host "Checking for Node.js installation..." -ForegroundColor Yellow
if (Test-Command node) {
    $nodeVersion = node --version
    Write-Host "✓ Node.js is already installed: $nodeVersion" -ForegroundColor Green
    
    # Check if version is adequate (v18.10+)
    $versionNumber = [version]($nodeVersion -replace 'v', '' -replace '-.*', '')
    $requiredVersion = [version]"18.10.0"
    
    if ($versionNumber -lt $requiredVersion) {
        Write-Host "⚠ Warning: Node.js version should be 18.10 or higher" -ForegroundColor Yellow
        Write-Host "Current version: $nodeVersion" -ForegroundColor Yellow
        Write-Host "Please update Node.js from https://nodejs.org/" -ForegroundColor Yellow
        Write-Host ""
        $continue = Read-Host "Do you want to continue anyway? (y/n)"
        if ($continue -ne 'y' -and $continue -ne 'Y') {
            exit
        }
    }
} else {
    Write-Host "✗ Node.js is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Node.js..." -ForegroundColor Yellow
    
    # Check if winget is available
    if (Test-Command winget) {
        Write-Host "Using winget to install Node.js..." -ForegroundColor Cyan
        try {
            winget install OpenJS.NodeJS.LTS --silent
            Write-Host "✓ Node.js installed successfully!" -ForegroundColor Green
        } catch {
            Write-Host "⚠ Winget installation failed. Please install manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Winget not found." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Please install Node.js manually from:" -ForegroundColor Yellow
        Write-Host "https://nodejs.org/en/download/" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "After installation, run this script again." -ForegroundColor Yellow
        Start-Process "https://nodejs.org/en/download/"
        exit
    }
    
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    # Verify Node.js installation
    Start-Sleep -Seconds 2
    if (-not (Test-Command node)) {
        Write-Host "✗ Node.js installation verification failed" -ForegroundColor Red
        Write-Host "Please restart PowerShell and run this script again" -ForegroundColor Yellow
        exit
    }
}

Write-Host ""
Write-Host "Checking npm..." -ForegroundColor Yellow
if (Test-Command npm) {
    $npmVersion = npm --version
    Write-Host "✓ npm is installed: v$npmVersion" -ForegroundColor Green
} else {
    Write-Host "✗ npm not found. Please reinstall Node.js" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "Installing n8n globally..." -ForegroundColor Yellow
Write-Host "This may take a few minutes. You'll see the installation progress below:" -ForegroundColor Cyan
Write-Host ""

try {
    npm install n8n -g
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ n8n installed successfully!" -ForegroundColor Green
    } else {
        throw "npm installation failed"
    }
} catch {
    Write-Host ""
    Write-Host "✗ Failed to install n8n" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Try running: npm install n8n -g --verbose" -ForegroundColor Yellow
    exit
}

# Verify n8n installation
Write-Host ""
Write-Host "Verifying n8n installation..." -ForegroundColor Yellow
if (Test-Command n8n) {
    $n8nVersion = n8n --version
    Write-Host "✓ n8n version: $n8nVersion" -ForegroundColor Green
} else {
    Write-Host "⚠ n8n command not found. You may need to restart PowerShell." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "To start n8n, run:" -ForegroundColor Cyan
Write-Host "  n8n" -ForegroundColor White
Write-Host ""
Write-Host "n8n will be accessible at: http://localhost:5678" -ForegroundColor Cyan
Write-Host ""
Write-Host "Data will be stored in: $env:USERPROFILE\.n8n" -ForegroundColor Gray
Write-Host ""

$startNow = Read-Host "Would you like to start n8n now? (y/n)"
if ($startNow -eq 'y' -or $startNow -eq 'Y') {
    Write-Host ""
    Write-Host "Starting n8n..." -ForegroundColor Green
    Write-Host "Access n8n at: http://localhost:5678" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop n8n" -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Seconds 2
    n8n
} else {
    Write-Host ""
    Write-Host "Installation complete! Run 'n8n' whenever you're ready to start." -ForegroundColor Green
}