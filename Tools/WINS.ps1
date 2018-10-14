cinst -y dotnetcore-sdk
cinst -y visualstudio2017enterprise
cinst -y resharper
cinst -y nugetpackageexplorer
cinst -y sql-server-management-studio
cinst -y ilspy
cinst -y dotpeek
cinst -y linqpad


Install-ChocolateyVsixPackage xunit http://visualstudiogallery.msdn.microsoft.com/463c5987-f82b-46c8-a97e-b1cde42b9099/file/66837/1/xunit.runner.visualstudio.vsix
Install-ChocolateyVsixPackage autowrocktestable http://visualstudiogallery.msdn.microsoft.com/ea3a37c9-1c76-4628-803e-b10a109e7943/file/73131/1/AutoWrockTestable.vsix

# File associations
##Install-ChocolateyFileAssociation ".txt" "$env:programfiles\Sublime Text 3\sublime_text.exe"