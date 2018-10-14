Enable-RemoteDesktop
#cinst Microsoft-Hyper-V-All -source windowsFeatures
Install-WindowsFeature -name hyper-v -IncludeManagementTools
Install-BoxstarterPackage -PackageName ./IIS-Features.ps1 -DisableReboots

# Slim IDEs
cinst -y vscode
cinst -y notepadplusplus
cinst -y sublimetext2

# Debug Tools
cinst -y fiddler
cinst -y postman
cinst -y wireshark

# Source control
cinst -y git
cinst -y gitversion
cinst -y gource
cinst -y poshgit
cinst -y git-credential-winstore

# Other Tools
cinst -y console-devel
