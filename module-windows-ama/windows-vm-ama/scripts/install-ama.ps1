# Install the Azure Monitor Agent
$ErrorActionPreference = "Stop"

# Install the Azure Monitor Agent
Invoke-WebRequest -Uri "https://aka.ms/InstallAzureMonitorAgent" -OutFile "$env:temp\ama_installer.exe"
Start-Process -FilePath "$env:temp\ama_installer.exe" -ArgumentList "/quiet" -Wait

Write-Host "Azure Monitor Agent installed successfully."
