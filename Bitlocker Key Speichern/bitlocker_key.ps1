function GB{
  try {
    $bV = Get-BitlockerVolume -MountPoint "C:"
    $rK = (Get-BitlockerVolume -MountPoint "C:").KeyProtector | Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"} | Select-Object -ExpandProperty RecoveryPassword
    return $rK
  } catch {
    return $null
  }
}

$key = GB

if($key){
  Ninja-Property-Set -Name "bitlocker" -Value $key
Write-Output "BL Saved"
} else {
  Write-Output "BL Not Saved"
}