try{
    #---- TEMPORARY ---
    Disable-UAC
    
    #---- Windows Settings
    Disable-BingSearch
    Disable-GameBarTips

    Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

    Disable-InternetExplorerESC
    Update-ExecutionPolicy Unrestricted

    Set-TaskbarOptions -Dock Bottom -Combine Full -Lock -AlwaysShowIconsOn
    #Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock
    #Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -AlwaysShowIconsOn
    try {
    # Setting Time Zone
    Write-BoxstarterMessage "Setting time zone to Central Standard Time"
    & C:\Windows\system32\tzutil /s "Central Standard Time"

    # Set Windows power options
    Write-BoxstarterMessage "Setting Standby Timeout to Never"
    powercfg -change -standby-timeout-ac 0
    powercfg -change -standby-timeout-dc 0

    Write-BoxstarterMessage "Setting Monitor Timeout to 20 minutes"
    powercfg -change -monitor-timeout-ac 20
    powercfg -change -monitor-timeout-dc 20

    Write-BoxstarterMessage "Setting Disk Timeout to Never"
    powercfg -change -disk-timeout-ac 0
    powercfg -change -disk-timeout-dc 0

    # AC lid close action (do nothing)
    powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
    # DC lid close action (sleep)
    powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1

    Write-BoxstarterMessage "Turning off Windows Hibernation"
    powercfg -h off

    # Some from: @NickCraver's gist https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9

    # Privacy: Let apps use my advertising ID: Disable
    If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
        New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
    }
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

    # WiFi Sense: HotSpot Sharing: Disable
    If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
    }
    Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

    # WiFi Sense: Shared HotSpot Auto-Connect: Disable
    Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

    # Start Menu: Disable Bing Search Results
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0
    # To Restore (Enabled):
    # Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 1

    # Disable Telemetry (requires a reboot to take effect)
    # Note this may break Insider builds for your organization
    # Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
    # Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

    # Change Explorer home screen back to "This PC"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1
    # Change it back to "Quick Access" (Windows 10 default)
    # Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 2

    # Better File Explorer
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1		
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1		
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
    
    # These make "Quick Access" behave much closer to the old "Favorites"
    # Disable Quick Access: Recent Files
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
    # Disable Quick Access: Frequent Folders
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0
    # To Restore:
    # Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 1
    # Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 1

    # Dark theme for file exlorer
    If (-Not (Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize)) {
        New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes -Name Personalize | Out-Null
    }
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Type DWord -Value 0
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Type DWord -Value 0

    # Disable the Lock Screen (the one before password prompt - to prevent dropping the first character)
    If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
        New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
    }
    Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1
    # To Restore:
    # Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1

    # Lock screen (not sleep) on lid close
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 1
    # To Restore:
    # Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 0

    # Use the Windows 7-8.1 Style Volume Mixer
    If (-Not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name MTCUVC | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Name EnableMtcUvc -Type DWord -Value 0
    # To Restore (Windows 10 Style Volume Control):
    # Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Name EnableMtcUvc -Type DWord -Value 1

    # Disable Xbox Gamebar
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

    # Turn off People in Taskbar
    If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
        New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
    }
    Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0
    } catch{
        Write-BoxstarterMessage "Registry Edits failed"
    }

    try {
    Write-BoxstarterMessage "Removing Bloatware"
    #---- Remove bloatware
    # Alarms
    Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

    # Autodesk
    Get-AppxPackage *Autodesk* | Remove-AppxPackage

    # Bing Weather, News, Sports, and Finance (Money):
    Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
    Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
    Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
    Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

    # BubbleWitch
    Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

    # Candy Crush
    Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

    # Comms Phone
    Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

    # Dell
    Get-AppxPackage *Dell* | Remove-AppxPackage

    # Dropbox
    Get-AppxPackage *Dropbox* | Remove-AppxPackage

    # Facebook
    Get-AppxPackage *Facebook* | Remove-AppxPackage

    # Feedback Hub
    Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

    # Get Started
    Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

    # Keeper
    Get-AppxPackage *Keeper* | Remove-AppxPackage

    # Mail & Calendar
    Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage

    # Maps
    #Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

    # March of Empires
    Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

    # McAfee Security
    Get-AppxPackage *McAfee* | Remove-AppxPackage

    # Uninstall McAfee Security App
    $mcafee = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "McAfee Security" } | select UninstallString
    if ($mcafee) {
        $mcafee = $mcafee.UninstallString -Replace "C:\Program Files\McAfee\MSC\mcuihost.exe",""
        Write "Uninstalling McAfee..."
        start-process "C:\Program Files\McAfee\MSC\mcuihost.exe" -arg "$mcafee" -Wait
    }

    # Messaging
    Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

    # Minecraft
    Get-AppxPackage *Minecraft* | Remove-AppxPackage

    # Netflix
    Get-AppxPackage *Netflix* | Remove-AppxPackage

    # Office Hub
    Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

    # One Connect
    Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage

    # OneNote
    Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage

    # People
    Get-AppxPackage Microsoft.People | Remove-AppxPackage

    # Phone
    Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

    # Photos
    #Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage

    # Plex
    Get-AppxPackage *Plex* | Remove-AppxPackage

    # Skype (Metro version)
    Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

    # Sound Recorder
    Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

    # Solitaire
    Get-AppxPackage *Solitaire* | Remove-AppxPackage

    # Sticky Notes
    Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

    # Sway
    Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

    # Twitter
    Get-AppxPackage *Twitter* | Remove-AppxPackage

    # Xbox
    Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
    Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage

    # Zune Music, Movies & TV
    Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
    Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
    } catch {
        Write-BoxstarterMessage "Bloatware Removal Failed"
    }
    # =============================================
    # ---------------------------------------------
    # =============================================

    try {
    Write-BoxstarterMessage "installing chocolatey"
    cinst inconsolata -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing unchecky"
    cinst unchecky -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Spotify"
    cinst spotify -y --ignore-checksum --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Slack"
    cinst slack -y --cacheLocation "C:\temp"

    # Install Browsers
    Write-BoxstarterMessage "Installing Browsers"
    cinst googlechrome -y --cacheLocation "C:\temp"
    cinst adblockpluschrome -y --cacheLocation "C:\temp"
    #cinst firefox -y --cacheLocation "C:\temp"
    cinst flashplayerplugin -y --cacheLocation "C:\temp"
    cinst opera -y --cacheLocation "C:\temp"
    }catch {
        Write-BoxStarterMessage "Productivity Tools installation failed"
    }

    Write-BoxstarterMessage "Installing work environment"
    
    try {
    Enable-RemoteDesktop
    cinst Microsoft-Hyper-V-All -source windowsFeatures
    Install-WindowsFeature -name hyper-v -IncludeManagementTools
    Install-WindowsFeature -name containers
    
    # enable IIS features
    cinst IIS-WebServerRole -source windowsfeatures
    cinst IIS-WebServer -source windowsfeatures
    cinst IIS-CommonHttpFeatures -source windowsfeatures
    cinst IIS-ApplicationDevelopment -source windowsfeatures
    cinst IIS-Security -source windowsfeatures
    cinst IIS-URLAuthorization -source windowsfeatures
    cinst IIS-RequestFiltering -source windowsfeatures
    cinst IIS-NetFxExtensibility -source windowsfeatures
    cinst IIS-HealthAndDiagnostics -source windowsfeatures
    cinst IIS-HttpLogging -source windowsfeatures
    cinst IIS-LoggingLibraries -source windowsfeatures
    cinst IIS-RequestMonitor -source windowsfeatures
    cinst IIS-HttpTracing -source windowsfeatures
    cinst IIS-IPSecurity -source windowsfeatures
    cinst IIS-Performance -source windowsfeatures
    cinst IIS-WebServerManagementTools -source windowsfeatures
    cinst IIS-IIS6ManagementCompatibility -source windowsfeatures
    cinst IIS-Metabase -source windowsfeatures
    cinst IIS-ISAPIExtensions -source windowsfeatures
    cinst IIS-ISAPIFilter -source windowsfeatures
    cinst IIS-BasicAuthentication -source windowsfeatures
    cinst IIS-WindowsAuthentication -source windowsfeatures
    cinst IIS-CGI -source windowsfeatures
    cinst IIS-ASPNET -source windowsfeatures
    cinst IIS-ASP -source windowsfeatures
    cinst IIS-HttpCompressionDynamic -source windowsfeatures
    cinst IIS-ManagementScriptingTools -source windowsfeatures
    cinst IIS-StaticContent -source windowsfeatures
    cinst IIS-DefaultDocument -source windowsfeatures
    cinst IIS-DirectoryBrowsing -source windowsfeatures
    cinst IIS-WebDAV -source windowsfeatures 
    cinst IIS-ServerSideIncludes -source windowsfeatures
    cinst IIS-CustomLogging -source windowsfeatures
    cinst IIS-HttpCompressionStatic -source windowsfeatures
    cinst IIS-ManagementConsole -source windowsfeatures
    cinst IIS-ManagementService -source windowsfeatures
    cinst IIS-WMICompatibility -source windowsfeatures
    cinst IIS-LegacyScripts -source windowsfeatures
    cinst IIS-LegacySnapIn -source windowsfeatures
    cinst IIS-FTPServer -source windowsfeatures
    cinst IIS-FTPSvc -source windowsfeatures 
    cinst IIS-FTPExtensibility -source windowsfeatures
    cinst IIS-DigestAuthentication -source windowsfeatures

    #Register .NET 4.0 with IIS
    ."$env:windir\microsoft.net\framework\v4.0.30319\aspnet_regiis.exe" -i
    
    # Runtimes
    cinst visualstudio2017buildtools -y --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US" --cacheLocation "C:\temp"
    #cinst visualstudio2017-workload-vctools -y --cacheLocation "C:\temp"
    } catch {
        Write-BoxstarterMessage " IIS install failed"
    }

    Write-BoxstarterMessage "Installing Runtimes"
    cinst dotnetcore-sdk -y --cacheLocation "C:\temp"
    cinst jdk8 -y --cacheLocation "C:\temp"
    cinst golang -y --cacheLocation "C:\temp"
    cinst rust -y --cacheLocation "C:\temp"
    cinst erlang -y --cacheLocation "C:\temp"
    cinst elixir -y --cacheLocation "C:\temp"
    cinst python2 -y --cacheLocation "C:\temp"

    #cinst nodejs -y --cacheLocation "C:\temp"
    cinst nvm -y --cacheLocation "C:\temp"
    refresh-env
    nvm install --lts
    nvm use --lts
    npm install -g windows-build-tools --production
    npm install -g eslint
    cinst yarn -y --cacheLocation "C:\temp"

    # Slim IDEs
    Write-BoxstarterMessage "Installing slim IDEs"
    cinst vscode -y --cacheLocation "C:\temp"
    refresh-env
    code --install-extension "dbaeumer.vscode-eslint"
    code --install-extension "mjmcloug.vscode-elixir"
    code --install-extension "jakebecker.elixir-ls"
    code --install-extension "eamodio.gitlens"
    code --install-extension "rbbit.typescript-hero"
    code --install-extension "dskwrk.vscode-generate-getter-setter"
    code --install-extension "vsmobile.vscode-react-native"
    code --install-extension "davidanson.vscode-markdownlint"
    code --install-extension "shd101wyy.markdown-preview-enhanced"

    cinst notepadplusplus -y --cacheLocation "C:\temp"
    cinst sublimetext2 -y --cacheLocation "C:\temp"
    cinst nimbletext -y --cacheLocation "C:\temp"
    cinst nimbleset -y --cacheLocation "C:\temp"
    cinst azure-data-studio -y --cacheLocation "C:\temp"
    cinst linqpad -y --cacheLocation "C:\temp"
    cinst zeal -y --cacheLocation "C:\temp"
    cinst logseq -y --cacheLocation "C:\temp"
    
    # Source control
    Write-BoxstarterMessage "Installing Source control tools"
    #cinst git -y -params /GitAndUnixToolsOnPath --cacheLocation "C:\temp"
    cinst gitversion -y --cacheLocation "C:\temp"
    cinst gource -y --cacheLocation "C:\temp"
    cinst poshgit -y --cacheLocation "C:\temp"
    cinst git-credential-winstore -y --cacheLocation "C:\temp"
    
    # Other Tools
    cinst console-devel -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Java stack tools"
    cinst eclipse -y --cacheLocation "C:\temp"
    cinst gradle -y --cacheLocation "C:\temp"

    Write-BoxstarterMessage "Installing MEAN stack tools"
    #Install-BoxstarterPackage https://raw.githubusercontent.com/nodejs/node/master/tools/bootstrap/windows_boxstarter -DisableReboots
    cinst nasm -y
    cinst mongodb -y --cacheLocation "C:\temp"
    
    #Write-BoxstarterMessage "Installing LAMP stack tools"
    #cinst Microsoft-Windows-Subsystem-Linux -source windowsfeatures
    
    Write-BoxstarterMessage "Installing WINS stack tools"
    cinst visualstudio2017community -y --cacheLocation "C:\temp"
    #cinst visualstudio2017enterprise -y --cacheLocation "C:\temp"
    #cinst resharper -y --cacheLocation "C:\temp"
    cinst nugetpackageexplorer -y --cacheLocation "C:\temp"
    cinst sql-server-management-studio -y --cacheLocation "C:\temp"
    cinst ilspy -y --cacheLocation "C:\temp"
    cinst dotpeek -y --cacheLocation "C:\temp"

    #cinst docker-desktop -y --cacheLocation "C:\temp"

    #Install-ChocolateyVsixPackage xunit http://visualstudiogallery.msdn.microsoft.com/463c5987-f82b-46c8-a97e-b1cde42b9099/file/66837/1/xunit.runner.visualstudio.vsix
    #Install-ChocolateyVsixPackage autowrocktestable http://visualstudiogallery.msdn.microsoft.com/ea3a37c9-1c76-4628-803e-b10a109e7943/file/73131/1/AutoWrockTestable.vsix

    Write-BoxstarterMessage "Installing mobile tools"
    cinst android-sdk -y --cacheLocation "C:\temp"
    cinst androidstudio -y --cacheLocation "C:\temp"

    Write-BoxstarterMessage "Installing architect tools"
    cinst plantuml -y --cacheLocation "C:\temp"
    cinst staruml3 -y --cacheLocation "C:\temp"
    cinst yed -y --cacheLocation "C:\temp"
    cinst freemind -y --cacheLocation "C:\temp"
    cinst freeplane -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Designer tools"
    cinst screentogif -y --cacheLocation "C:\temp"
    cinst paint.net -y --cacheLocation "C:\temp"
    cinst gimp -y --cacheLocation "C:\temp"
    cinst inkscape -y --cacheLocation "C:\temp"
    cinst sharex -y --cacheLocation "C:\temp"
    cinst firealpaca -y --cacheLocation "C:\temp"
    # painttool sai`

    cinst audacity -y --cacheLocation "C:\temp"
    cinst audacity-lame -y --cacheLocation "C:\temp"
    cinst audacity-ffmpeg -y --cacheLocation "C:\temp"
    cinst obs-studio -y --cacheLocation "C:\temp"
    cinst shotcut -y --cacheLocation "C:\temp"
    cinst kdenlive -y --cacheLocation "C:\temp"
    cinst openshot -y --cacheLocation "C:\temp"
    cinst handbrake -y --cacheLocation "C:\temp"

    cinst blender -y --cacheLocation "C:\temp"
    cinst opentoonz -y --cacheLocation "C:\temp"
    cinst synfig -y --cacheLocation "C:\temp"
    # pencil2d

    cinst pencil -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Arduino tools"
    cinst arduino -y --cacheLocation "C:\temp"
    cinst fritzing -y --cacheLocation "C:\temp"
    
    # Debug Tools
    Write-BoxstarterMessage "Installing Debug tools"
    cinst fiddler -y --cacheLocation "C:\temp"
    cinst postman -y --cacheLocation "C:\temp"
    cinst wireshark -y --cacheLocation "C:\temp"
    
    Write-BoxstarterMessage "Installing Operations tools"
    cinst anydesk -y --cacheLocation "C:\temp"
    cinst putty -y --cacheLocation "C:\temp"
    cinst sysinternals -y --cacheLocation "C:\temp"
    cinst nirlauncher -y --cacheLocation "C:\temp"
    cinst filezilla -y --cacheLocation "C:\temp"
    cinst bluescreenview -y --cacheLocation "C:\temp"
    cinst windirstat -y --cacheLocation "C:\temp"
    cinst rufus -y --cacheLocation "C:\temp"
    cinst osquery -y --cacheLocation "C:\temp"
    cinst lockhunter -y --cacheLocation "C:\temp"
    cinst rdcman -y --cacheLocation "C:\temp"
    cinst pstools -y --cacheLocation "C:\temp"
    cinst combofix -y --cacheLocation "C:\temp"
    cinst imgburn -y --cacheLocation "C:\temp"
    cinst nssm -y --cacheLocation "C:\temp"
    cinst windowsrepair -y --cacheLocation "C:\temp"
    cinst gpu-z -y --cacheLocation "C:\temp"
    cinst advanced-ip-scanner -y --cacheLocation "C:\temp"    

    #--- Restore Temporary Settings ---
    Enable-UAC

    # Install Windows Updates
    Write-BoxstarterMessage "Running Windows Update"
    Enable-MicrosoftUpdate
    Install-WindowsUpdate -Full -AcceptEula 

    Write-BoxstarterMessage "Machine is complete!"

    ##--- Rename the Computer ---
    ## Requires restart, or add the -Restart flag
    #Write-BoxstarterMessage "Renaming PC to " $NewMachineName
    #if ($env:computername -ne $NewMachineName) {
    #    Rename-Computer -NewName $NewMachineName
    #}
} catch {
    Write-BoxstarterMessage 'Boxstarter Error: ' $($_.Exception.Message)
    throw
}
