# Get the total and used storage of all local drives
$totalGB = [math]::Round((Get-WmiObject -Class Win32_LogicalDisk | Measure-Object -Property Size -Sum).Sum / 1GB, 2)
$usedGB = [math]::Round((Get-WmiObject -Class Win32_LogicalDisk | Measure-Object -Property FreeSpace -Sum).Sum / 1GB, 2)
$availableGB = $totalGB - $usedGB

# Set the custom field using Ninja-Property-Set
$fieldName = "TotalStorageOnDevice"
$fieldValue = "$availableGB / $totalGB GB"
Ninja-Property-Set -Name $fieldName -Value $fieldValue

# Confirm the custom field was set correctly
Get-NinjaDevice | Select-Object -Property TotalStorageOnDevice
