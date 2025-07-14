if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)) 
{Start-Process powershell -Args "-File `"$PSCommandPath`"" -Verb RunAs; exit}

$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

$Username = Read-Host "Enter account username"
$Output = Join-Path -Path (Split-Path -Parent $PSCommandPath) -ChildPath "autounattend.xml"
if (Test-Path $Output) { Remove-Item $Output -Force }

$XML = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS"
            xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <InputLocale>0809:00000809</InputLocale>
            <SystemLocale>en-GB</SystemLocale>
            <UILanguage>en-GB</UILanguage>
            <UILanguageFallback>en-GB</UILanguageFallback>
            <UserLocale>en-GB</UserLocale>
        </component>
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <TimeZone>GMT Standard Time</TimeZone>
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideLocalAccountScreen>true</HideLocalAccountScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <NetworkLocation>Home</NetworkLocation>
                <ProtectYourPC>3</ProtectYourPC>
                <SkipMachineOOBE>true</SkipMachineOOBE>
                <SkipUserOOBE>true</SkipUserOOBE>
            </OOBE>
            <UserAccounts>
                <AdministratorPassword>
                    <PlainText>true</PlainText>
                    <Value></Value>
                </AdministratorPassword>
                <LocalAccounts>
                    <LocalAccount wcm:action="add">
                        <Group>Administrators</Group>
                        <Name>USERNAME</Name>
                        <Password>
                            <PlainText>true</PlainText>
                            <Value></Value>
                        </Password>
                    </LocalAccount>
                </LocalAccounts>
            </UserAccounts>
        </component>
    </settings>
    <settings pass="specialize">
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Path>net accounts /maxpwage:unlimited</Path>
                    <WillReboot>Never</WillReboot>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>2</Order>
                    <Path>net user USERNAME /active:Yes</Path>
                    <WillReboot>Never</WillReboot>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>3</Order>
                    <Path>net user USERNAME /passwordreq:no</Path>
                    <WillReboot>Never</WillReboot>
                </RunSynchronousCommand>
            </RunSynchronous>
        </component>
        <component name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <SkipAutoActivation>true</SkipAutoActivation>
        </component>
        <component name="Microsoft-Windows-UnattendedJoin" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <Identification>
                <JoinWorkgroup>WORKGROUP</JoinWorkgroup>
            </Identification>
        </component>
    </settings>
    <settings pass="windowsPE">
        <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <InputLocale>0809:00000809</InputLocale>
            <SystemLocale>en-GB</SystemLocale>
            <UILanguage>en-GB</UILanguage>
            <UILanguageFallback>en-GB</UILanguageFallback>
            <UserLocale>en-GB</UserLocale>
            <SetupUILanguage>
                <UILanguage>en-GB</UILanguage>
            </SetupUILanguage>
        </component>
        <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1 /f</Path>
                    <Description>Add BypassTPMCheck</Description>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>2</Order>
                    <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1 /f</Path>
                    <Description>Add BypassRAMCheck</Description>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>3</Order>
                    <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1 /f</Path>
                    <Description>Add BypassSecureBootCheck</Description>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>4</Order>
                    <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d 1 /f</Path>
                    <Description>Add BypassCPUCheck</Description>
                </RunSynchronousCommand>
                <RunSynchronousCommand wcm:action="add">
                    <Order>5</Order>
                    <Path>reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d 1 /f</Path>
                    <Description>Add BypassStorageCheck</Description>
                </RunSynchronousCommand>
            </RunSynchronous>
            <Diagnostics>
                <OptIn>false</OptIn>
            </Diagnostics>
            <DynamicUpdate>
                <Enable>false</Enable>
                <WillShowUI>OnError</WillShowUI>
            </DynamicUpdate>
            <UserData>
                <AcceptEula>true</AcceptEula>
                <ProductKey>
                    <Key>VK7JG-NPHTM-C97JM-9MPGT-3V66T</Key>
                </ProductKey>
            </UserData>
        </component>
    </settings>
</unattend>
"@

$UserXML = $XML -replace "USERNAME", [System.Security.SecurityElement]::Escape($Username)
$UserXML | Out-File -FilePath $Output -Encoding UTF8
Write-Host "autounattend created at $Output, copy to bootable USB root directory"
Read-Host "`nPress Enter to exit"