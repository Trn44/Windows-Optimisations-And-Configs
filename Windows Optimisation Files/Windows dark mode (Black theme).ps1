$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Restart-Explorer {
    Stop-Process -Name explorer -Force
    Start-Process explorer
}

function Apply-Theme {
    param (
        [string]$Content,
        [string]$FileName
    )
    $TempPath = "$env:TEMP\$FileName"
    $Content | Out-File -Encoding ASCII -FilePath $TempPath
    reg import $TempPath
    Remove-Item $TempPath
    Restart-Explorer
}

function BlackTheme {
    $BlackTheme = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent]
"AccentPalette"=hex:00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00
"StartColorMenu"=dword:00000000
"AccentColorMenu"=dword:00000000
"@
    Apply-Theme -Content $BlackTheme -FileName "Black.reg"
}

function RevertDefaultTheme {
    $DefaultTheme = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
"StartColorMenu"=dword:ff3d3f41
"AccentColorMenu"=dword:ff484a4c
"AccentPalette"=hex(3):DF,DE,DC,00,A6,A5,A1,00,68,65,62,00,4C,4A,48,00,41,\
3F,3D,00,27,25,24,00,10,0D,0D,00,10,7C,10,00
"@
    Apply-Theme -Content $DefaultTheme -FileName "Default.reg"
}

do {
    Clear-Host
    Write-Host "1. Apply Dark Theme"
    Write-Host "2. Revert to Default Theme"
    $Select = Read-Host "Enter 1 or 2"
    switch ($Select) {
        "1" {BlackTheme; break}
        "2" {RevertDefaultTheme; break}
        default {
            Write-Host "Invalid option, pick 1 or 2"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)
