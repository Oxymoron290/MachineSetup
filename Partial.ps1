
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

    cinst notepadplusplus -y --cacheLocation "C:\temp"
    cinst sublimetext2 -y --cacheLocation "C:\temp"
    cinst nimbletext -y --cacheLocation "C:\temp"
    cinst nimbleset -y --cacheLocation "C:\temp"
    cinst azure-data-studio -y --cacheLocation "C:\temp"
    cinst linqpad -y --cacheLocation "C:\temp"
    
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

    cinst audacity -y --cacheLocation "C:\temp"
    cinst audacity-lame -y --cacheLocation "C:\temp"
    cinst audacity-ffmpeg -y --cacheLocation "C:\temp"
    cinst obs-studio -y --cacheLocation "C:\temp"
    cinst shotcut -y --cacheLocation "C:\temp"
    cinst handbrake -y --cacheLocation "C:\temp"

    cinst blender -y --cacheLocation "C:\temp"
    
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
