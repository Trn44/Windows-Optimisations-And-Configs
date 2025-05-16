@echo off
title HWID's
echo Windows User SIDs
wmic useraccount get name,sid
echo ------------------------------------------------------------------------
echo Motherboard
wmic baseboard get product,manufacturer,serialnumber
wmic path win32_computersystemproduct get name,UUID
echo ------------------------------------------------------------------------
echo CPU
wmic cpu get name,processorid
echo ------------------------------------------------------------------------
echo RAM
wmic memorychip get banklabel,manufacturer,partnumber,serialnumber
echo ------------------------------------------------------------------------
echo Drives
wmic diskdrive get model,serialnumber
echo ------------------------------------------------------------------------
echo GPU
wmic path win32_VideoController get name,PNPDeviceID
echo ------------------------------------------------------------------------
echo Network
wmic nic where (AdapterTypeId=0 AND NetConnectionStatus=2) get Name,MACAddress
echo ------------------------------------------------------------------------
echo Press any key to exit...
pause >nul
