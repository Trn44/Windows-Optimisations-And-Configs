if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

cmd /c "powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 99999999-9999-9999-9999-999999999999 >nul 2>&1"
cmd /c "powercfg /SETACTIVE 99999999-9999-9999-9999-999999999999 >nul 2>&1"


do {
    Clear-Host
    Write-Host "1. Set Powerplan"
    Write-Host "2. Restart to default Powerplan"
    Write-Host "`nEsc to Exit"
   $KeyPress = [System.Console]::ReadKey($true)
    switch ($KeyPress.Key) {
        'D1' {Powerplan}
        'D2' {DefaultPowerplan}
        'Escape' {Exit}
        default { Write-Host "`nInvalid option, pick 1, 2 or Esc to exit"; Start-Sleep -Seconds 2}
    }
} while ($true)