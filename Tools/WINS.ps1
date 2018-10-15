cinst dotnetcore-sdk -y --cacheLocation "C:\temp"
cinst visualstudio2017enterprise -y --cacheLocation "C:\temp"
cinst resharper -y --cacheLocation "C:\temp"
cinst nugetpackageexplorer -y --cacheLocation "C:\temp"
cinst azure-data-studio -y --cacheLocation "C:\temp"
cinst sql-server-management-studio -y --cacheLocation "C:\temp"
cinst ilspy -y --cacheLocation "C:\temp"
cinst dotpeek -y --cacheLocation "C:\temp"
cinst linqpad -y --cacheLocation "C:\temp"


Install-ChocolateyVsixPackage xunit http://visualstudiogallery.msdn.microsoft.com/463c5987-f82b-46c8-a97e-b1cde42b9099/file/66837/1/xunit.runner.visualstudio.vsix
Install-ChocolateyVsixPackage autowrocktestable http://visualstudiogallery.msdn.microsoft.com/ea3a37c9-1c76-4628-803e-b10a109e7943/file/73131/1/AutoWrockTestable.vsix

# File associations
##Install-ChocolateyFileAssociation ".txt" "$env:programfiles\Sublime Text 3\sublime_text.exe"