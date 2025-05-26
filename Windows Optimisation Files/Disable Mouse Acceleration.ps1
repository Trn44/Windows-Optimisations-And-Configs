if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function MouseAcceleration {
    param (
        [string]$Content,
        [string]$FileName
    )
    $TempPath = "$env:TEMP\$FileName"
    $Content | Out-File -Encoding ASCII -FilePath $TempPath
    reg import $TempPath
    Remove-Item $TempPath

}

function DisableMouseAcceleration {
    $DisableMouseAcceleration = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"
"@
    Mouse-Acceleration -Content $DisableMouseAcceleration -FileName "DisableMA.reg"
    Write-Host "`nDisabled mouse acceleration."
    Start-Sleep -Seconds 5
}
function EnableMouseAcceleration {
    $EnableMouseAcceleration = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"
"@
    Mouse-Acceleration -Content $EnableMouseAcceleration -FileName "EnableMA.reg"
    Write-Host "`nEnabled Mouse Acceleration."
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Disable Mouse Acceleration"
    Write-Host "2. Enable Mouse Acceleration"
    $Select = Read-Host "Enter 1 or 2"
    switch ($Select) {
        "1" {DisableMouseAcceleration; break}
        "2" {EnableMouseAcceleration; break}
        default {
            Write-Host "Invalid option, pick 1 or 2"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)