if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function RestartToBIOS {
	shutdown.exe /r /fw /t 8
    Write-Host "`nRestarting to BIOS."
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Restart to BIOS"
    Write-Host "2. Exit"
    $Select = Read-Host "Enter 1 or 2"
    switch ($Select) {
        "1" {RestartToBIOS}
        "2" {Exit}
        default {
            Write-Host "Invalid option, pick 1 or 2"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)