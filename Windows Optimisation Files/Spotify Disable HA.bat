powershell.exe -WindowStyle Hidden -Command "$path = \"$env:APPDATA\Spotify\prefs\"; Add-Content $path -Value 'ui.hardware_acceleration=false' -Force"
