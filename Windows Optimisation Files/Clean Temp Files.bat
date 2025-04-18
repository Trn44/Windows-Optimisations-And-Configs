@echo off

echo Deleting Temp Files
set folder=C:\Windows\Temp
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q) > NUL 2>&1
set folder=%userprofile%\AppData\Local\Temp
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q) > NUL 2>&1

echo Running Disk Cleanup
set R_Key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches
for %%k in (
    "Active Setup Temp Folders"
    "Thumbnail Cache"
    "Delivery Optimization Files"
    "D3D Shader Cache"
    "Downloaded Program Files"
    "Internet Cache Files"
    "Setup Log Files"
    "Temporary Files"
    "Windows Error Reporting Files"
    "Offline Pages Files"
    "Recycle Bin"
) do (
    reg add "%R_Key%\%%k" /v StateFlags0011 /t REG_DWORD /d 00000002 /f > NUL 2>&1
)
start /wait cleanmgr.exe /sagerun:11

echo Clearing Event Logs
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :eventlog "%%G")
:eventlog
echo Clearing %1
wevtutil.exe cl %1
