if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.WindowTitle = "Disable Memory Compression"
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Disabling Memory Compression"
Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue | Out-Null
Start-Sleep -Seconds 5
Get-MMAgent | Format-List -Property MemoryCompression
Write-Host "`nPress any key to exit"
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")