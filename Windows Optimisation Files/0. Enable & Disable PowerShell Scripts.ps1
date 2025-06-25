if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Enable {
    try {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" ` -Name "ExecutionPolicy" -Value "Unrestricted" -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" ` -Name "ExecutionPolicy" -Value "Unrestricted" -Force
        $Ps1Path = "HKLM:\Software\Classes\ps1_auto_file\shell\open\command"
        New-Item -Path $Ps1Path -Force | Out-Null
        Set-ItemProperty -Path $Ps1Path -Name "(default)" ` -Value "`"$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe`" -NoLogo -ExecutionPolicy unrestricted -File `"%1`"" ` -Force
        Set-ItemProperty -Path "HKLM:\Software\Classes\.ps1" -Name "(default)" -Value "ps1_auto_file" -Force
        Get-ChildItem -Path $PSScriptRoot -Recurse -File | Unblock-File
        Write-Host "Enabled & Unblock PowerShell scripts."
        Start-Sleep -Seconds 2
    } catch {
        Write-Host "Error enabling scripts: $_"
        Start-Sleep -Seconds 2
    }
}

function Disable {
    try {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" ` -Name "ExecutionPolicy" -Value "Restricted" -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" ` -Name "ExecutionPolicy" -Value "Restricted" -Force
        Remove-Item -Path "HKLM:\Software\Classes\ps1_auto_file" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\Software\Classes\.ps1" -Name "(default)" -Force -ErrorAction SilentlyContinue
        Write-Host "Disabled PowerShell scripts." 
        Start-Sleep -Seconds 2
    } catch {
        Write-Host "Error disabling scripts: $_"
        Start-Sleep -Seconds 2
    }
}

do {
    Clear-Host
    Write-Host "1. Enable & Unblock PowerShell scripts"
    Write-Host "2. Disable PowerShell scripts"
    Write-Host "3. Exit"
    $Select = Read-Host "Enter 1, 2 or 3"
    switch ($Select) {
        "1" {Enable}
        "2" {Disable}
        "3" {Exit}
        default {
            Write-Host "Invalid option, pick 1, 2 or 3."
            Start-Sleep -Seconds 2
        }
    }
} while ($true)