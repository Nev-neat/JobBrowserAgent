# Browser-Use WebUI Startup Script
Write-Host "🚀 Starting Browser-Use WebUI..." -ForegroundColor Cyan

# Kill existing Chrome instances
Write-Host "Closing existing Chrome..." -ForegroundColor Yellow
taskkill /F /IM chrome.exe /T 2>$null | Out-Null
Start-Sleep 2

# Start Chrome in debug mode
Write-Host "Starting Chrome in debug mode..." -ForegroundColor Yellow
Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "--remote-debugging-port=9242","--user-data-dir=C:\Users\MSI\AppData\Local\Google\Chrome\User Data","--start-maximized"
Start-Sleep 3

# Verify Chrome is running
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9242/json/version" -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Chrome is running on port 9242" -ForegroundColor Green
} catch {
    Write-Host "❌ Chrome failed to start in debug mode" -ForegroundColor Red
    exit 1
}

# Start the WebUI
Write-Host "Starting WebUI..." -ForegroundColor Yellow
Set-Location $PSScriptRoot
& .\.venv\Scripts\Activate.ps1
python webui.py
