if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

function Optimize-Registry {
    param (
        [string]$Content,
        [string]$FileName
    )
    $TempPath = "$env:TEMP\$FileName"
    $Content | Out-File -Encoding ASCII -FilePath $TempPath
    reg import $TempPath
    Remove-Item $TempPath

}

function OptimiseRegistry {
    $OptimiseRegistry = @"
Windows Registry Editor Version 5.00

; Windows Settings

; Performance Settings

; Visual Settings

; Application Settings

; Telemetry & Spyware
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000000
"FeatureManagementEnabled"=dword:00000000
"OemPreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEverEnabled"=dword:00000000
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
"SilentInstalledAppsEnabled"=dword:00000000
"SlideshowEnabled"=dword:00000000
"SoftLandingEnabled"=dword:00000000
"SubscribedContent-310093Enabled"=dword:00000000
"SubscribedContent-314559Enabled"=dword:00000000
"SubscribedContent-314563Enabled"=dword:00000000
"SubscribedContent-338387Enabled"=dword:00000000
"SubscribedContent-338388Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353698Enabled"=dword:00000000
"SubscribedContentEnabled"=dword:00000000
"SystemPaneSuggestionsEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000
"DoNotShowFeedbackNotifications"=dword:00000001
"LimitDiagnosticLogCollection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows]
"CEIPEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableConsumerFeatures"=dword:00000001
"DisableSoftLanding"=dword:00000001
"DisableWindowsConsumerFeatures"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization]
"AllowInputPersonalization"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000
"PublishUserActivities"=dword:00000000
"UploadUserActivities"=dword:00000000
"AllowClipboardHistory"=dword:00000000
"AllowCrossDeviceClipboard"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"BingSearchEnabled"=dword:00000000
"AllowSearchToUseLocation"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
"DisableLocation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config]
"AutoConnectAllowedOEM"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppHost]
"EnableWebContentEvaluation"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"NoConnectedUser"=dword:00000003

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

"@
    Optimize-Registry -Content $OptimiseRegistry -FileName "OptimiseReg.reg"
    Write-Host "`nApplied Registry Optimisations, restart PC to apply changes."
    Start-Sleep -Seconds 5
}
function RevertRegistry {
    $RevertRegistry = @"
Windows Registry Editor Version 5.00

; Windows Settings

; Performance Settings

; Visual Settings

; Application Settings

; Telemetry & Spyware
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000001
"FeatureManagementEnabled"=dword:00000001
"OemPreInstalledAppsEnabled"=dword:00000001
"PreInstalledAppsEnabled"=dword:00000001
"PreInstalledAppsEverEnabled"=dword:00000001
"RotatingLockScreenEnabled"=dword:00000001
"RotatingLockScreenOverlayEnabled"=dword:00000001
"SilentInstalledAppsEnabled"=dword:00000001
"SlideshowEnabled"=dword:00000001
"SoftLandingEnabled"=dword:00000001
"SubscribedContent-310093Enabled"=-
"SubscribedContent-314563Enabled"=-
"SubscribedContent-338388Enabled"=-
"SubscribedContent-338389Enabled"=-
"SubscribedContent-338389Enabled"=-
"SubscribedContent-338393Enabled"=-
"SubscribedContent-338393Enabled"=-
"SubscribedContent-353694Enabled"=-
"SubscribedContent-353694Enabled"=-
"SubscribedContent-353696Enabled"=-
"SubscribedContent-353696Enabled"=-
"SubscribedContent-353698Enabled"=-
"SubscribedContentEnabled"=dword:00000001
"SystemPaneSuggestionsEnabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000003
"DoNotShowFeedbackNotifications"=-
"LimitDiagnosticLogCollection"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows]
"CEIPEnable"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=-

"@
    Optimize-Registry -Content $RevertRegistry -FileName "RemoveOptimisations.reg"
    Write-Host "`nReverted Registry Optimisations, restart PC to revert changes."
    Start-Sleep -Seconds 5
}

do {
    Clear-Host
    Write-Host "1. Apply Registry Optimisations"
    Write-Host "2. Revert Registry Optimisations"
    $Select = Read-Host "Enter 1 or 2"
    switch ($Select) {
        "1" {OptimiseRegistry; break}
        "2" {RevertRegistry; break}
        default {
            Write-Host "Invalid option, pick 1 or 2"
            Start-Sleep -Seconds 2
        }
    }
} while ($true)