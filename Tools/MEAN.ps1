Install-BoxstarterPackage https://raw.githubusercontent.com/nodejs/node/master/tools/bootstrap/windows_boxstarter -DisableReboots

cinst python2 -y --cacheLocation "C:\temp"

cinst visualstudio2017buildtools -y --cacheLocation "C:\temp"
cinst visualstudio2017-workload-vctools -y --cacheLocation "C:\temp"

cinst nasm -y
cinst nodejs -y --cacheLocation "C:\temp"
cinst mongodb -y --cacheLocation "C:\temp"

# File associations
##Install-ChocolateyFileAssociation ".txt" "$env:programfiles\Sublime Text 3\sublime_text.exe"