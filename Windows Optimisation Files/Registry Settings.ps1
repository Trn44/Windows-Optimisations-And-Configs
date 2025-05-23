if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Optimize-Registry {
    param (
        [string]$Content,
        [string]$FileName
    )
    $TempPath = "$env:TEMP\$FileName"
    $Content | Out-File -Encoding ASCII -FilePath $TempPath
    reg import $TempPath
    Remove-Item $TempPath

}

function OptimiseRegistry {
    $OptimiseRegistry = @"
Windows Registry Editor Version 5.00

"@
    Optimize-Registry -Content $OptimiseRegistry -FileName "OptimiseReg.reg"
    Write-Host "`nApplied Registry Optimisations, restart PC to apply changes."
    Start-Sleep -Seconds 5
}
function RevertRegistry {
    $RevertRegistry = @"
Windows Registry Editor Version 5.00

"@
    Optimize-Registry -Content $RevertRegistry -FileName "RemoveOptimisations.reg"
    Write-Host "`nReverted Registry Optimisations, restart PC to revert changes."
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Apply Registry Optimisations"
    Write-Host "2. Revert Registry Optimisations"
    $Select = Read-Host "Enter 1 or 2"
    switch ($Select) {
        "1" {OptimiseRegistry; break}
        "2" {RevertRegistry; break}
        default {
            Write-Host "Invalid option, pick 1 or 2"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)