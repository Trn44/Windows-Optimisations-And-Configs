if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

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
    Write-Host "1. Motherboard BIOS update"
    Write-Host "2. Restart to BIOS"
    Write-Host "3. Exit"
    switch (Read-Host "Enter 1, 2 or 3") {
        "1" {MotherboardBIOS}
        "2" {RestartBIOS}
        "3" {exit}
        default { Write-Host "Invalid option, pick 1, 2 or 3"; Start-Sleep -Seconds 2 }
    }
} while ($true)