# Get the device serial number
Write-Host "Reading device serial number..."
$serial = (Get-WmiObject win32_bios).serialnumber
if ($null -eq $serial) {
    Write-Host "Error: Serial number not found!"
    exit
}
Write-Host "Serial number: $serial"

# Get the location of this script
Write-Host "Getting script location..."
$scriptPath = $PSScriptRoot
if ($null -eq $scriptPath) {
    Write-Host "Error: Script location not found!"
    exit
}
Write-Host "Script is running from: $scriptPath"

# Set the output file path
if ($scriptPath -like "C:\*") {
    $OutputFile = "$scriptPath" + "\HWID\$serial.csv"
} else {
    $OutputFile = "$scriptPath" + "HWID\$serial.csv"
}
Write-Host "Output file: $OutputFile"

# Check if the HWID folder exists
Write-Host "Checking if HWID folder exists..."
$HWIDMappe = Get-Item -Path "$scriptPath\HWID" -ErrorAction SilentlyContinue
if ($null -eq $HWIDMappe) {
    Write-Host "HWID-folder not found, creating..."
    New-Item -Path "$scriptPath\HWID" -ItemType Directory
}

# Get the HWID for the device
Write-Host "Getting HWID..."
& $scriptPath\Get-WindowsAutoPilotInfo.ps1 -OutputFile $OutputFile


# Done!
Write-Host "HWID saved!"