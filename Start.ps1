Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/OxymoronDev.1.0.0.nupkg -DisableReboots