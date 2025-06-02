if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function MotherboardModel {
    $Motherboard = Get-WmiObject Win32_BaseBoard | Select-Object -ExpandProperty Product
    return $Motherboard
}
function MotherboardBIOS {
    $MotherboardModel = MotherboardModel
    $URL = "https://www.google.com/search?q=$MotherboardModel+BIOS"
    Start-Process $URL
}
function RestartToBIOS {
    Shutdown.exe /r /fw /t 8
    Write-Host "`nRestarting to BIOS."
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Search for BIOS version update"
    Write-Host "2. Restart to BIOS"
    Write-Host "3. Exit"
    $Select = Read-Host "Enter 1, 2 or 3"
    switch ($Select) {
        "1" {MotherboardBIOS}
        "2" {RestartToBIOS}
        "3" {Exit}
    default {
    Write-Host "Invalid option, pick 1 or 2"
    Start-Sleep -Seconds 2
        }
    }
} while ($true)