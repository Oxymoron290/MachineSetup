Set-ExecutionPolicy Bypass -Scope Process -Force
# install chocolatey
Invoke-Expression  ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# install boxstarter
if($PSVersionTable.PSVersion.Major -lt 3){
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); get-boxstarter -Force
}
else
{
    . { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; get-boxstarter -Force
}

refreshenv

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Full.ps1 -DisableReboots