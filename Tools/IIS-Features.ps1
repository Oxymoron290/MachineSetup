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