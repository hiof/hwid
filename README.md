# hiof/hwid

## Instructions

Pull all contents of this repository and save on an empty USB-drive.

### Getting HWID from a new device

1. Start the device you want to fetch the HWID from.
2. When the Windows-setup screen appears, press the key-combination Fn + Shift + F10 to open a CMD-window.
3. Enter the following command:

   ````powershell
    powershell D:\Get-HWID.ps1
   ````

4. Wait until "HWID saved!" is logged to the console.
5. Eject the USB-drive

The HWID-file will be saved as *serialnumber*.csv to a folder named "HWID" on the USB-drive.

### Getting HWID from a device that is already set up

1. Open a CMD-window as administrator.
2. Enter the following command:

    ````powershell
    powershell D:\Get-HWID.ps1
    ````

3. Wait until "HWID saved!" is logged to the console.
4. Eject the USB-drive

### Merging multiple HWIDs

To import multiple HWIDs to Intune, you will need to combine the csv-files before importing.

1. Open a "Run"-window (Win+R)
2. Enter the following command:

   ````powershell
    powershell.exe -executionpolicy bypass -command "D:\HWID-merger.ps1"
   ````

3. Enter the path to the HWID folder on your USB-drive when prompted.
4. Wait until "HWIDs combined!" is logged to the console.
5. Upload the "Autopilot-HWID.csv" file located under "HWID" on the USB-drive to Intune.

> [!NOTE]
> In the examples here, "D:\" is the letter for the USB-drive. This may vary if you have multiple USB storage devices or multiple partitions attached.
