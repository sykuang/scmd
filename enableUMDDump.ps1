function enableUMDDump {
  param (
    [bool]$enable = $true
  )
  if ($enable) {
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\" /v DumpType /t REG_DWORD /d "2" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\" /v DumpFolder /t REG_EXPAND_SZ /d "C:\crashdumps" /f
  }
  else {
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps" /f
  }
}
if ($args[0] -eq "1") {
  enableUMDDump $true
}
elseif ($args[0] -eq "0") {
  enableUMDDump  0
}
elseif (!($args[0])){
  enableUMDDump $true
}
else {
  try{
    $enable=$args[0] | Out-String
    $enable=[System.Convert]::ToBoolean($enable)
  }
  catch {
    Write-Host "Invalid argument. Please provide a boolean value."
    return
  }
  enableUMDDump $enable
}