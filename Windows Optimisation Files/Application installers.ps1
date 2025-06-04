if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Install-VCRedistPackages {
function Install-PlaceholderApp1 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp2 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp3 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp4 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp5 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp6 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp7 { Write-Host "Installing Placeholder"; Pause }
function Install-PlaceholderApp8 { Write-Host "Installing Placeholder"; Pause }

do {
    Clear-Host
    Write-Host "1. Install C++ Redistributables"
    Write-Host "2. Install Placeholder App"
    Write-Host "3. Install Placeholder App"
    Write-Host "4. Install Placeholder App"
    Write-Host "5. Install Placeholder App"
    Write-Host "6. Install Placeholder App"
    Write-Host "7. Install Placeholder App"
    Write-Host "8. Install Placeholder App"
    Write-Host "9. Install Placeholder App"
    Write-Host "10. Exit"
    $Select = Read-Host "Enter 1 - 10"
    switch ($Select) {
        "1"  {Install-VCRedistPackages}
        "2"  {Install-PlaceholderApp}
        "3"  {Install-PlaceholderApp}
        "4"  {Install-PlaceholderApp}
        "5"  {Install-PlaceholderApp}
        "6"  {Install-PlaceholderApp}
        "7"  {Install-PlaceholderApp}
        "8"  {Install-PlaceholderApp}
        "9"  {Install-PlaceholderApp}
        "10" {Exit}
        default {
            Write-Host "Invalid option, pick 1 - 10"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)