if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.WindowTitle = "Disable Memory Compression"
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Windows 11 Default = Enabled. Not recommended to disable if you have less than 16GB RAM."

function Disable {
Write-Host "Disabling Memory Compression"
Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue | Out-Null
Start-Sleep -Seconds 5
Get-MMAgent | Format-List -Property MemoryCompression
Start-Sleep -Seconds 5
}
  

function Enable {
Write-Host "Enabling Memory Compression"
Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue | Out-Null
Start-Sleep -Seconds 5
Get-MMAgent | Format-List -Property MemoryCompression
Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Disable Memory Compression"
    Write-Host "2. Enable Memory Compression"
    Write-Host "`nEsc to Exit"
   $KeyPress = [System.Console]::ReadKey($true)
    switch ($KeyPress.Key) {
        'D1' {Disable}
        'D2' {Enable}
        'Escape' {Exit}
        default { Write-Host "`nInvalid option, pick 1, 2 or Esc to exit"; Start-Sleep -Seconds 2}
    }
} while ($true)