if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Creating System Restore Point."
Checkpoint-Computer -Description "User Restore Point" -RestorePointType "MODIFY_SETTINGS"
Start-Sleep -Seconds 8