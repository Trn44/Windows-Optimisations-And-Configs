if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function MouseAcceleration {
param ($MouseAccel)
$RegFile = if ($MouseAccel) {
@"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"
"@
} 

else {
@"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"
"@
}

    $Temp = "$env:TEMP\MouseAcceleration.reg"
    $RegFile | Out-File -Encoding ASCII $Temp
    reg import $Temp
    Remove-Item $Temp
    Stop-Process -Name explorer -Force
    Start-Process explorer
}

do {
    Clear-Host
    Write-Host "1. Disable Mouse Acceleration"
    Write-Host "2. Enable Mouse Acceleration"
    Write-Host "3. Exit"
    switch (Read-Host "Enter 1, 2 or 3") {
        "1" {MouseAcceleration $true}
        "2" {MouseAcceleration $false}
        "3" {exit}
        default { Write-Host "Invalid option, pick 1, 2 or 3"; Start-Sleep -Seconds 2 }
    }
} while ($true)