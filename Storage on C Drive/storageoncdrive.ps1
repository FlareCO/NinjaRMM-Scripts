# Get the available and used space on the C: drive
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'"
$availableGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)

# Set the custom field using Ninja-Property-Set
$fieldName = "storageoncdrive"
$fieldValue = "$usedGB / $availableGB GB"
Ninja-Property-Set -Name $fieldName -Value $fieldValue

# Confirm the custom field was set correctly
Get-NinjaDevice | Select-Object -Property storageoncdrive
