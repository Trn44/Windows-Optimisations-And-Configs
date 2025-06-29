if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Install-VCRedistPackages {
    $URLs = @(
    # Visual C++ 2005 x64/x86
    "https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x64.EXE",
    "https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x86.EXE",
    # Visual C++ 2008 x64/x86
    "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe",
    "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe",
    # Visual C++ 2010 x64/x86
    "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe",
    "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe",
    # Visual C++ 2012 x64/x86
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe",
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe",
    # Visual C++ 2013 x64/x86
    "https://aka.ms/highdpimfc2013x64enu",
    "https://aka.ms/highdpimfc2013x86enu",
    # Visual C++ 2015-2022 x64/x86
    "https://aka.ms/vs/17/release/vc_redist.x64.exe",
    "https://aka.ms/vs/17/release/vc_redist.x86.exe")
    $TempFolder = "$env:TEMP\VCRedistributables"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    if ($URL -eq "https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x64.EXE" -or $URL -eq "https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x86.EXE") {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName (C++ 2005 does not support silent install)."
    Start-Process -FilePath $FileDirectory -Wait }
    elseif ($URL -like "*highdpimfc2013*") {
    $FileName = "vcredist2013.exe"
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/quiet", "/norestart" -Wait }
    else {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/quiet", "/norestart" -Wait }
}
    Write-Host "Visual C++ Redistributables installed."
    Start-Sleep -Seconds 4
}

function Install-DirectX { 
    $URLs = @("https://download.microsoft.com/download/1/7/1/1718ccc4-6315-4d8e-9543-8e28a4e18c4c/dxwebsetup.exe")
    $TempFolder = "$env:TEMP\DirectX"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent", "/norestart" -Wait 
}
    Write-Host "DirectX installed."
    Start-Sleep -Seconds 4
}

function Install-Discord { 
    $URLs = @("https://discordapp.com/api/download?platform=win")
    $TempFolder = "$env:TEMP\Discord"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = "DiscordSetup.exe"
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "Discord installed."
    Start-Sleep -Seconds 4
}

function Install-BraveBrowser { 
    $URLs = @("https://github.com/brave/brave-browser/releases/latest/download/BraveBrowserStandaloneSilentSetup.exe")
    $TempFolder = "$env:TEMP\BraveBrowser"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -Wait 
}
    Write-Host "Brave Browser installed."
    Start-Sleep -Seconds 4
}

function Install-7Zip { 
    $URLs = @("https://www.7-zip.org/a/7z2409-x64.exe")
    $TempFolder = "$env:TEMP\7Zip"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "7zip installed."
    Start-Sleep -Seconds 4
}

function Install-Spotify { 
    $URLs = @("https://download.scdn.co/SpotifySetup.exe")
    $TempFolder = "$env:TEMP\Spotify"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "Spotify installed."
    Start-Sleep -Seconds 4
}

function Install-NotepadPP { 
    $URLs = @("https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.8.1/npp.8.8.1.Installer.x64.exe")
    $TempFolder = "$env:TEMP\Notepad++"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "Notepad++ installed."
    Start-Sleep -Seconds 4
}

function Install-HWiNFO { 
    $URLs = @("https://www.hwinfo.com/files/hwi64_826.exe")
    $TempFolder = "$env:TEMP\HWiNFO"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "HWiNFO installed."
    Start-Sleep -Seconds 4
}

function Install-AIDA64 { 
    $URLs = @("https://download.aida64.com/aida64extreme765.exe")
    $TempFolder = "$env:TEMP\AIDA64"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "AIDA64 installed."
    Start-Sleep -Seconds 4
}

function Install-Surfshark { 
    $URLs = @("https://downloads.surfshark.com/windows/latest/SurfsharkSetup.exe")
    $TempFolder = "$env:TEMP\Surfshark"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/exenoui", "/qn" -Wait 
}
    Write-Host "Surfshark installed."
    Start-Sleep -Seconds 4
}

function Install-Autoruns { 
    $URLs = @("https://live.sysinternals.com/Autoruns64.exe")
    $TempFolder = "$env:TEMP\Autoruns"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = "Autoruns64.exe"
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -Wait 
}
    Write-Host "Autoruns installed."
    Start-Sleep -Seconds 4
}

function Install-DDU { 
    $URLs = @("https://www.wagnardsoft.com/DDU/download/DDU%20v18.1.1.5_setup.exe")
    $TempFolder = "$env:TEMP\DDU"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "Display Driver Uninstaller installed."
    Start-Sleep -Seconds 4
}

function Install-MSIAfterburner { 
    $URLs = @("https://github.com/Trn44/Files-Applications/raw/main/MSIAfterburnerSetup466Beta5.exe")
    $TempFolder = "$env:TEMP\MSIAfterburner"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -ArgumentList "/silent" -Wait 
}
    Write-Host "MSI Afterburner installed."
    Start-Sleep -Seconds 4
}

function Install-NVCleanstall { 
    $URLs = @("https://github.com/Trn44/Files-Applications/raw/main/NVCleanstall_1.19.0.exe")
    $TempFolder = "$env:TEMP\NVCleanstall"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = "NVCleanstall_1.19.0.exe"
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -Wait 
}
    Write-Host "NVCleanstall installed."
    Start-Sleep -Seconds 4
}

function Install-GPUZ { 
    $URLs = @("https://github.com/Trn44/Files-Applications/raw/main/GPU-Z.2.66.0.exe")
    $TempFolder = "$env:TEMP\GPUZ"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -Wait 
}
    Write-Host "GPU-Z installed."
    Start-Sleep -Seconds 4
}

function Install-CPUZ { 
    $URLs = @("https://github.com/Trn44/Files-Applications/raw/main/cpuz_x64.exe")
    $TempFolder = "$env:TEMP\CPUZ"
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    foreach ($URL in $URLs) {
    $FileName = Split-Path $URL -Leaf
    $FileDirectory = Join-Path $TempFolder $FileName
    Invoke-WebRequest -Uri $URL -OutFile $FileDirectory
    Write-Host "Installing $FileName"
    Start-Process -FilePath $FileDirectory -Wait 
}
    Write-Host "CPU-Z installed."
    Start-Sleep -Seconds 4
}


do {
    Clear-Host
    Write-Host "| Windows Components |"
    Write-Host "1. Install C++ Redistributables"
    Write-Host "2. Install DirectX"
    Write-Host "`n| Software & Programs |"
    Write-Host "3. Install Discord"
    Write-Host "4. Install Brave Browser"
    Write-Host "5. Install 7zip"
    Write-Host "6. Install Spotify"
    Write-Host "7. Install Notepad++"
    Write-Host "8. Install HWiNFO"
    Write-Host "9. Install AIDA64"
    Write-Host "10. Install Surfshark VPN"
    Write-Host "11. Install Autoruns"
    Write-Host "12. Install VMware Workstation"
    Write-Host "`n| GPU & CPU Software |"
    Write-Host "13. Install Display Driver Uninstaller (DDU)"
    Write-Host "14. Install MSI Afterburner"
    Write-Host "15. Install NVCleanstall"
    Write-Host "16. Install GPU-Z"
    Write-Host "17. Install CPU-Z"
    Write-Host "18. Install Zen Timings"
    Write-Host "`n| Game Launchers |"
    Write-Host "19. Install Steam"
    Write-Host "20. Install Epic Games Launcher"
    Write-Host "`n*PLACEHOLDER*. Exit"
    $Select = Read-Host "`nEnter 1 - 10"
    switch ($Select) {
        "1"  {Install-VCRedistPackages}
        "2"  {Install-DirectX}
        "3"  {Install-Discord}
        "4"  {Install-BraveBrowser}
        "5"  {Install-7Zip}
        "6"  {Install-Spotify}
        "7"  {Install-NotepadPP}
        "8"  {Install-HWiNFO}
        "9"  {Install-AIDA64}
        "10" {Install-Surfshark}
        "11" {Install-Autoruns}
        "12" {Install-VMWareWorkstation}
        "13" {Install-DDU}
        "14" {Install-MSIAfterburner}
        "15" {Install-NVCleanstall}
        "16" {Install-GPUZ}
        "17" {Install-CPUZ}
        "18" {Install-ZenTimings}
        "19" {Install-Steam}
        "20" {Install-EpicGamesLauncher}
        "*PLACEHOLDER*" {Exit}
        default {
            Write-Host "Invalid option, pick 1 - *PLACEHOLDER*"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)