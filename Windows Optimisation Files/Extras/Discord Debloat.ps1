$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Debloating Discord"
Get-Process -Name "Discord" -ErrorAction SilentlyContinue | Stop-Process -Force

$VersionFolder = Get-ChildItem "$env:LOCALAPPDATA\Discord\app-*" -Directory | Sort-Object Name -Descending | Select-Object -First 1
$KeepModules = @("discord_desktop_core", "discord_krisp", "discord_rpc", "discord_utils", "discord_voice")
Get-ChildItem "$($VersionFolder.FullName)\modules" -Directory | Where-Object {
    $Modules = ($_).Name.Split('-')[0] 
    $Modules -notin $KeepModules } | Remove-Item -Recurse -Force
Get-ChildItem "$($VersionFolder.FullName)\locales" -File | Where-Object { $_.Name -ne "en-GB.pak" } | Remove-Item -Force

Write-Host "`nDiscord debloated"
Start-Process "$env:LOCALAPPDATA\Discord\Update.exe" -ArgumentList "--processStart Discord.exe"
Start-Sleep -Seconds 4