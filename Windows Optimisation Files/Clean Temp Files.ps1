if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Output "Running Windows Disk Cleanup"
Start-Process cleanmgr.exe

Write-Output "Cleaning C:\Windows\Temp folder"
$WinTemp = "C:\Windows\Temp"
Get-ChildItem -Path $WinTemp -Force -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $File = $_.FullName
    Try {
        Remove-Item -Path $File -Recurse -Force -ErrorAction Stop
        Write-Output "Deleted: $File"
    } Catch {
        Write-Output "$_"
    }
}

Write-Output "Cleaning C:\Users\$env:USERNAME\AppData\Local\Temp folder"
$UserTemp = "$env:LOCALAPPDATA\Temp"
Get-ChildItem -Path $UserTemp -Force -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $File = $_.FullName
    Try {
        Remove-Item -Path $File -Recurse -Force -ErrorAction Stop
        Write-Output "Deleted: $File"
    } Catch {
        Write-Output "$_"
    }
}
Read-Host "`nPress Enter to exit"
