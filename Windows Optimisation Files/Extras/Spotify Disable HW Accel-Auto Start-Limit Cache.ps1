$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

$PrefsPath = "$env:APPDATA\Spotify\prefs"
$Settings = @(
    'ui.hardware_acceleration=false',
    'app.autostart-configured=true',
    'app.autostart-mode="off"',
    'storage.size=256')

if (-not (Test-Path -Path $PrefsPath -PathType Leaf)) {
    New-Item -Path $PrefsPath -ItemType File -Force | Out-Null
}
$PrefsContent = Get-Content -Path $PrefsPath

foreach ($Setting in $Settings) {
    $SpotifySettings = $Setting.Split('=')[0]
    $PrefsContent = $PrefsContent | Where-Object { -not ($_.StartsWith($SpotifySettings)) }
}
$PrefsContent += $Settings
$PrefsContent | Set-Content -Path $PrefsPath -Force
Write-Host "Disabled Spotify Hardware acceleration & Auto start, limited Cache size to 256MB."
Start-Sleep 5
