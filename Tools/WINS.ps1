cinst -y dotnetcore-sdk
cinst -y visualstudio2017enterprise
cinst -y resharper
cinst -y nugetpackageexplorer
cinst -y sql-server-management-studio
cinst -y ilspy
cinst -y dotpeek
cinst -y linqpad

# File associations
##Install-ChocolateyFileAssociation ".txt" "$env:programfiles\Sublime Text 3\sublime_text.exe"