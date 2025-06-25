if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Output "Running Windows Disk Cleanup and cleaning temporary files."
Start-Process cleanmgr.exe

$TempFiles = ("C:\Windows\Temp", "$env:LOCALAPPDATA\Temp")

foreach ($Directory in $TempFiles) {
    Get-ChildItem -Path $Directory -Force -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}
Write-Output "`nTemp files cleaned."
Start-Sleep -Seconds 5