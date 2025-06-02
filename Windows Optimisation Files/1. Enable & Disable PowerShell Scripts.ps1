if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Enable {
    $RegistryPaths = 
        ("HKCU:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell",
        "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell")
    foreach ($Path in $RegistryPaths) {
        Set-ItemProperty -Path $Path -Name ExecutionPolicy -Value Unrestricted -Force
    }
    $PSEPath = "Registry::HKEY_CLASSES_ROOT\Applications\powershell.exe\shell\open\command"
    New-Item -Path $PSEPath -Force | Out-Null
    Set-ItemProperty -Path $PSEPath -Name "(default)" -Value "`"$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe`" -NoLogo -ExecutionPolicy Unrestricted -File `"%1`"" -Force
    $Root = $PSScriptRoot
    if (-not $Root) { $Root = Split-Path -Parent $MyInvocation.MyCommand.Path }
    Get-ChildItem -Path $Root -Recurse | Unblock-File
    Write-Host "PowerShell scripts enabled, files unblocked."
    Pause
}

function Disable {
    Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\Applications\powershell.exe" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\ps1_auto_file" -Recurse -Force -ErrorAction SilentlyContinue
    $RegistryPaths = 
        ("HKCU:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell",
        "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell")
    foreach ($Path in $RegistryPaths) {
        Set-ItemProperty -Path $Path -Name ExecutionPolicy -Value Restricted -Force
    }
    Write-Host "PowerShell scripts disabled."
    Pause
}

do {
    Clear-Host
    Write-Host "1. Enable Powershell scripts"
    Write-Host "2. Disable Powershell scripts"
    Write-Host "3. Exit"
    $Select = Read-Host "Enter 1 ,2 or 3"
    switch ($Select) {
        "1" {Enable}
        "2" {Disable}
        "3" {exit}
        default {
            Write-Host "Invalid option, pick 1, 2, or 3."
            Start-Sleep -Seconds 2
        }
    }
} while ($true)
