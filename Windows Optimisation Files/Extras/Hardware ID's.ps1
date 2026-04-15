$Host.UI.RawUI.WindowTitle = "HWID's"
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

Write-Host "Windows User SIDs"
Get-WmiObject Win32_UserAccount | Select-Object Name, SID | Format-Table -AutoSize

Write-Host "Motherboard"
Get-WmiObject Win32_BaseBoard | Select-Object Product, Manufacturer, SerialNumber | Format-Table -AutoSize
Get-WmiObject Win32_ComputerSystemProduct | Select-Object Name, UUID | Format-Table -AutoSize

Write-Host "CPU"
Get-WmiObject Win32_Processor | Select-Object Name, ProcessorId | Format-Table -AutoSize

Write-Host "RAM"
Get-WmiObject Win32_MemoryChip | Select-Object BankLabel, Manufacturer, PartNumber, SerialNumber | Format-Table -AutoSize

Write-Host "Drives"
Get-WmiObject Win32_DiskDrive | Select-Object Model, SerialNumber | Format-Table -AutoSize

Write-Host "GPU"
Get-WmiObject Win32_VideoController | Select-Object Name, PNPDeviceID | Format-Table -AutoSize

Write-Host "Network"
Get-WmiObject Win32_NetworkAdapter -Filter "AdapterTypeId=0 AND NetConnectionStatus=2" | Select-Object Name, MACAddress | Format-Table -AutoSize

Write-Host "`nPress any key to exit" 
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")