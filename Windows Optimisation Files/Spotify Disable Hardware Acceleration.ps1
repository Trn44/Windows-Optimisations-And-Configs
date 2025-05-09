$prefsPath = "$env:APPDATA\Spotify\prefs"
$disableSetting = 'ui.hardware_acceleration=false'
$enableSetting = 'ui.hardware_acceleration=true'

# Creating the prefs file if it does not exist
if (-not (Test-Path -Path $prefsPath -PathType Leaf)) {
    New-Item -Path $prefsPath -ItemType File -Force | Out-Null
}

# Reading file
$prefsContent = Get-Content -Path $prefsPath

# Disable hardware acceleration
$prefsContent = $prefsContent | Where-Object { $_ -ne $enableSetting }
if ($prefsContent -notcontains $disableSetting) {
    $prefsContent += $disableSetting
}

# Writing to file
$prefsContent | Set-Content -Path $prefsPath -Force