if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function WindowsServices {
param ($Services)
if ($Services) {
    Set-Service "AJRouter" -StartupType Disabled
    Set-Service "ALG" -StartupType Disabled
    Set-Service "AssignedAccessManagerSvc" -StartupType Disabled
    Set-Service "tzautoupdate" -StartupType Disabled
    Set-Service "BthAvctpSvc" -StartupType Disabled
    Set-Service "BcastDVRUserService" -StartupType Disabled
    Set-Service "BDESVC" -StartupType Disabled
    Set-Service "BTAGService" -StartupType Disabled
    Set-Service "PeerDistSvc" -StartupType Disabled
    Set-Service "autotimesvc" -StartupType Disabled
    Set-Service "CertPropSvc" -StartupType Disabled
    Set-Service "DiagTrack" -StartupType Disabled
    Set-Service "DmEnrollmentSvc" -StartupType Disabled
    Set-Service "dmwappushservice" -StartupType Disabled
    Set-Service "diagsvc" -StartupType Disabled
    Set-Service "DPS" -StartupType Disabled
    Set-Service "WdiServiceHost" -StartupType Disabled
    Set-Service "WdiSystemHost" -StartupType Disabled
    Set-Service "DialogBlockingService" -StartupType Disabled
    Set-Service "TrkWks" -StartupType Disabled
    Set-Service "MapsBroker" -StartupType Disabled
    Set-Service "DusmSvc" -StartupType Disabled
    Set-Service "lfsvc" -StartupType Disabled
    Set-Service "SharedAccess" -StartupType Disabled
    Set-Service "iphlpsvc" -StartupType Disabled
    Set-Service "diagnosticshub.standardcollector.service" -StartupType Disabled
    Set-Service "NetTcpPortSharing" -StartupType Disabled
    Set-Service "CscService" -StartupType Disabled
    Set-Service "WpcMonSvc" -StartupType Disabled
    Set-Service "SEMgrSvc" -StartupType Disabled
    Set-Service "PNRPsvc" -StartupType Disabled
    Set-Service "p2psvc" -StartupType Disabled
    Set-Service "p2pimsvc" -StartupType Disabled
    Set-Service "PhoneSvc" -StartupType Disabled
    Set-Service "PNRPAutoReg" -StartupType Disabled
    Set-Service "WPDBusEnum" -StartupType Disabled
    Set-Service "Spooler" -StartupType Disabled
    Set-Service "PrintNotify" -StartupType Disabled
    Set-Service "PcaSvc" -StartupType Disabled
    Set-Service "RmSvc" -StartupType Disabled
    Set-Service "TroubleshootingSvc" -StartupType Disabled
    Set-Service "RasAuto" -StartupType Disabled
    Set-Service "RasMan" -StartupType Disabled
    Set-Service "SessionEnv" -StartupType Disabled
    Set-Service "TermService" -StartupType Disabled
    Set-Service "UmRdpService" -StartupType Disabled
    Set-Service "RpcLocator" -StartupType Disabled
    Set-Service "RemoteRegistry" -StartupType Disabled
    Set-Service "RetailDemo" -StartupType Disabled
    Set-Service "RemoteAccess" -StartupType Disabled
    Set-Service "seclogon" -StartupType Disabled
    Set-Service "LanmanServer" -StartupType Disabled
    Set-Service "shpamsvc" -StartupType Disabled
    Set-Service "ShellHWDetection" -StartupType Disabled
    Set-Service "SCardSvr" -StartupType Disabled
    Set-Service "ScDeviceEnum" -StartupType Disabled
    Set-Service "SCPolicySvc" -StartupType Disabled
    Set-Service "SysMain" -StartupType Disabled
    Set-Service "lmhosts" -StartupType Disabled
    Set-Service "Themes" -StartupType Disabled
    Set-Service "TabletInputService" -StartupType Disabled
    Set-Service "upnphost" -StartupType Disabled
    Set-Service "UevAgentService" -StartupType Disabled
    Set-Service "VacSvc" -StartupType Disabled
    Set-Service "WerSvc" -StartupType Disabled
    Set-Service "stisvc" -StartupType Disabled
    Set-Service "wisvc" -StartupType Disabled
    Set-Service "WinRM" -StartupType Disabled
    Set-Service "WSearch" -StartupType Disabled
    Set-Service "LanmanWorkstation" -StartupType Disabled
    Write-Host "Services disabled"; Start-Sleep -Seconds 2 }

else {
    Set-Service "AJRouter" -StartupType Manual
    Set-Service "ALG" -StartupType Manual
    Set-Service "AssignedAccessManagerSvc" -StartupType Manual
    Set-Service "tzautoupdate" -StartupType Manual
    Set-Service "BthAvctpSvc" -StartupType Manual
    Set-Service "BcastDVRUserService" -StartupType Manual
    Set-Service "BDESVC" -StartupType Manual
    Set-Service "BTAGService" -StartupType Manual
    Set-Service "PeerDistSvc" -StartupType Manual
    Set-Service "autotimesvc" -StartupType Manual
    Set-Service "CertPropSvc" -StartupType Manual
    Set-Service "DiagTrack" -StartupType Manual
    Set-Service "DmEnrollmentSvc" -StartupType Manual
    Set-Service "dmwappushservice" -StartupType Manual
    Set-Service "diagsvc" -StartupType Manual
    Set-Service "DPS" -StartupType Automatic
    Set-Service "WdiServiceHost" -StartupType Manual
    Set-Service "WdiSystemHost" -StartupType Manual
    Set-Service "DialogBlockingService" -StartupType Manual
    Set-Service "TrkWks" -StartupType Manual
    Set-Service "MapsBroker" -StartupType Manual
    Set-Service "DusmSvc" -StartupType Manual
    Set-Service "lfsvc" -StartupType Manual
    Set-Service "SharedAccess" -StartupType Manual
    Set-Service "iphlpsvc" -StartupType Automatic
    Set-Service "diagnosticshub.standardcollector.service" -StartupType Manual
    Set-Service "NetTcpPortSharing" -StartupType Disabled
    Set-Service "CscService" -StartupType Manual
    Set-Service "WpcMonSvc" -StartupType Manual
    Set-Service "SEMgrSvc" -StartupType Manual
    Set-Service "PNRPsvc" -StartupType Manual
    Set-Service "p2psvc" -StartupType Manual
    Set-Service "p2pimsvc" -StartupType Manual
    Set-Service "PhoneSvc" -StartupType Manual
    Set-Service "PNRPAutoReg" -StartupType Manual
    Set-Service "WPDBusEnum" -StartupType Manual
    Set-Service "Spooler" -StartupType Automatic
    Set-Service "PrintNotify" -StartupType Manual
    Set-Service "PcaSvc" -StartupType Automatic
    Set-Service "RmSvc" -StartupType Manual
    Set-Service "TroubleshootingSvc" -StartupType Manual
    Set-Service "RasAuto" -StartupType Manual
    Set-Service "RasMan" -StartupType Manual
    Set-Service "SessionEnv" -StartupType Manual
    Set-Service "TermService" -StartupType Manual
    Set-Service "UmRdpService" -StartupType Manual
    Set-Service "RpcLocator" -StartupType Manual
    Set-Service "RemoteRegistry" -StartupType Disabled
    Set-Service "RetailDemo" -StartupType Manual
    Set-Service "RemoteAccess" -StartupType Manual
    Set-Service "seclogon" -StartupType Manual
    Set-Service "LanmanServer" -StartupType Automatic
    Set-Service "shpamsvc" -StartupType Manual
    Set-Service "ShellHWDetection" -StartupType Automatic
    Set-Service "SCardSvr" -StartupType Manual
    Set-Service "ScDeviceEnum" -StartupType Manual
    Set-Service "SCPolicySvc" -StartupType Manual
    Set-Service "SysMain" -StartupType Automatic
    Set-Service "lmhosts" -StartupType Manual
    Set-Service "Themes" -StartupType Automatic
    Set-Service "TabletInputService" -StartupType Manual
    Set-Service "upnphost" -StartupType Manual
    Set-Service "UevAgentService" -StartupType Manual
    Set-Service "VacSvc" -StartupType Manual
    Set-Service "WerSvc" -StartupType Manual
    Set-Service "stisvc" -StartupType Manual
    Set-Service "wisvc" -StartupType Manual
    Set-Service "WinRM" -StartupType Manual
    Set-Service "WSearch" -StartupType Automatic
    Write-Host "Services reverted to default"; Start-Sleep -Seconds 2 } 
}

do {
    Clear-Host
    Write-Host "1. Disable services"
    Write-Host "2. Revert to default services"
    Write-Host "`nEsc to Exit"
   $KeyPress = [System.Console]::ReadKey($true)
    switch ($KeyPress.Key) {
        'D1' {WindowsServices $true}
        'D2' {WindowsServices $false}
        'Escape' {Exit}
        default { Write-Host "`nInvalid option, pick 1, 2 or Esc to exit"; Start-Sleep -Seconds 2 }
    }
} while ($true)