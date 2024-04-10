# Prompt the user for the location of the HWID files
$HWIDFolder = Read-Host "Enter the location of the HWID folder on your USB-drive (example: D:\HWID)"

# Get all the HWID files in the folder
$hwidFiles = Get-ChildItem -Path $HWIDFolder -Filter *.csv -File

if ($hwidFiles.Count -eq 0) {
    Write-Host "Error: No HWID-files found."
    exit
}

# Check if the merged HWID file already exists
if ($true -eq (Test-Path -Path "$HWIDFolder\Autopilot-HWID.csv")){
    Write-Host "Error: The Autopilot-HWID.csv file already exists."
    exit
}

# Create a new CSV file to store the merged HWID data
$mergedHWIDFile = Join-Path -Path $HWIDFolder -ChildPath "Autopilot-HWID.csv"
$header = "Device Serial Number,Windows Product ID,Hardware Hash"
$header | Out-File -FilePath $mergedHWIDFile -Encoding utf8

# Loop through each HWID file
Write-Host "Reading HWID-files..."
foreach ($hwidFile in $hwidFiles) {
    # Read the contents of the HWID file
    $hwidData = Get-Content -Path $hwidFile.FullName
    Write-Host "Writing HWID for $($hwidFile.Name)"

    # Skip the header row
    $hwidData = $hwidData | Select-Object -Skip 1

    # Append the HWID data to the merged HWID file
    $hwidData | Out-File -FilePath $mergedHWIDFile -Append -Encoding utf8
}

Write-Host "HWIDs combined!"
Pause