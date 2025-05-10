$PrefsPath = "$env:APPDATA\Spotify\prefs"
$HWADisableSetting = 'ui.hardware_acceleration=false'
$HWAEnableSetting = 'ui.hardware_acceleration=true'

if (-not (Test-Path -Path $PrefsPath -PathType Leaf)) {
    New-Item -Path $PrefsPath -ItemType File -Force | Out-Null
}

$PrefsContent = Get-Content -Path $PrefsPath

$PrefsContent = $PrefsContent | Where-Object { $_ -ne $HWAEnableSetting }
if ($PrefsContent -notcontains $HWADisableSetting) {
    $PrefsContent += $HWADisableSetting
}

$PrefsContent | Set-Content -Path $PrefsPath -Force
