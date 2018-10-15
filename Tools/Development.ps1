Enable-RemoteDesktop
#cinst Microsoft-Hyper-V-All -source windowsFeatures
Install-WindowsFeature -name hyper-v -IncludeManagementTools
Install-BoxstarterPackage -PackageName ./IIS-Features.ps1 -DisableReboots

# Slim IDEs
cinst vscode -y --cacheLocation "C:\temp"
cinst notepadplusplus -y --cacheLocation "C:\temp"
cinst sublimetext2 -y --cacheLocation "C:\temp"

# Debug Tools
cinst fiddler -y --cacheLocation "C:\temp"
cinst postman -y --cacheLocation "C:\temp"
cinst wireshark -y --cacheLocation "C:\temp"

# Source control
cinst git -y -params /GitAndUnixToolsOnPath --cacheLocation "C:\temp"
cinst gitversion -y --cacheLocation "C:\temp"
cinst gource -y --cacheLocation "C:\temp"
cinst poshgit -y --cacheLocation "C:\temp"
cinst git-credential-winstore -y --cacheLocation "C:\temp"

# Other Tools
cinst console-devel -y --cacheLocation "C:\temp"
