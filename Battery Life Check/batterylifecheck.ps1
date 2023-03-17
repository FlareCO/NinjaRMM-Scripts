if ((Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty PCSystemType) -eq 2) {
    $battery = Get-WmiObject -Class Win32_Battery

    $charging = $false
    if ($battery.BatteryStatus -eq 2) {
        $charging = $true
    }

    $batteryLife = "$($battery.EstimatedChargeRemaining)%"
    if ($charging) {
        $batteryLife += " (charging)"
    }

    $fieldSaveName = "batterylifecheck"
    Ninja-Property-Set -Name $fieldSaveName -Value $batteryLife

    Get-NinjaDevice | Select-Object -Property "batterylifecheck"
} else {
    $fieldSaveName = "batterylifecheck"
    Ninja-Property-Set -Name $fieldSaveName -Value "Keine Batterie"
    Get-NinjaDevice | Select-Object -Property "batterylifecheck"
}
