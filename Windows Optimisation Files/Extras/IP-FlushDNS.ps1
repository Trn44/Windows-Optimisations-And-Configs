if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.WindowTitle = "DNS & IP Reset"
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Flushing DNS Cache and Renewing IP"
ipconfig /release
ipconfig /renew
Clear-DnsClientCache

Write-Host "`nIP Addresses:" -ForegroundColor Green
ipconfig | Select-String "IPv4"
Write-Host "`nDNS Cache:" -ForegroundColor Green
Get-DnsClientCache | Measure-Object

Write-Host "`nPress any key to exit"
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")