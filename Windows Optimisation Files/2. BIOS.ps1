if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function MotherboardBIOS {
    $MB = (Get-CimInstance Win32_BaseBoard).Product
    Start-Process "https://www.google.com/search?q=$MB+BIOS"
    Write-Host "`nSearched BIOS updates for motherboard model: $MB"
    Start-Sleep -Seconds 8
}

function RestartBIOS {
    Shutdown /r /fw /t 8
    Write-Host "`nRestarting to BIOS"
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Search for BIOS update"
    Write-Host "2. Restart to BIOS"
    Write-Host "`nEsc to Exit"
   $KeyPress = [System.Console]::ReadKey($true)
    switch ($KeyPress.Key) {
        'D1' {MotherboardBIOS}
        'D2' {RestartBIOS}
        'Escape' {Exit}
        default { Write-Host "`nInvalid option, pick 1, 2 or Esc to exit"; Start-Sleep -Seconds 2}
    }
} while ($true)