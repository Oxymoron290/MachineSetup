#Requires -RunAsAdministrator
# Description: Boxstarter Script
# Author: Jess Frazelle <jess@linux.com>
# Last Updated: 2017-09-11
#
# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-GIST>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots
#
# Learn more: http://boxstarter.org/Learn/WebLauncher

param(
[parameter(Mandatory=$true, HelpMessage="This will be what the machine's name will be set to.")]
[alias("name")]
[string]
#[ValidateScript()]
$NewMachineName,
[parameter(HelpMessage="This will ensure that no professional settings or programs are installed.")]
[alias("play")]
[switch]
$Personal,
[parameter(HelpMessage="This switch will ensure that no personal settings or programs are installed.")]
[alias("work")]
[switch]
$Professional,
[parameter(HelpMessage="This will ensure that no Java related settings or programs are installed.")]
[switch]
$DisableJava,
[parameter(HelpMessage="This will ensure that no MEAN related settings or programs are installed.")]
[switch]
$DisableMEAN,
[parameter(HelpMessage="This will ensure that no LAMP related settings or programs are installed.")]
[switch]
$DisableLAMP,
[parameter(HelpMessage="This will ensure that no WINS related settings or programs are installed.")]
[switch]
$DisableWINS,
[parameter(HelpMessage="This will ensure that no Mobile related settings or programs are installed.")]
[switch]
$DisableMobile,
[parameter(HelpMessage="This will ensure that no Architecture related settings or programs are installed.")]
[switch]
$DisableArchitect,
[parameter(HelpMessage="This will ensure that no Design related settings or programs are installed.")]
[switch]
$DisableDesigner,
[parameter(HelpMessage="This will ensure that no Arduino related settings or programs are installed.")]
[switch]
$DisableArduino,
[parameter(HelpMessage="This will ensure that no Operations related settings or programs are installed.")]
[switch]
$DisableOperations)

if($PSVersionTable.PSVersion.Major -lt 3){
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); get-boxstarter -Force
    exit
}
else
{
    . { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
}

try{
    #---- TEMPORARY ---
    Disable-UAC
    
    #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/WindowsSettings.ps1 -DisableReboots
    #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Bloatware.ps1 -DisableReboots
    #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Common.ps1 -DisableReboots
    if(-Not ($Personal)) # skip all professional scripts
    {
        Write-BoxstarterMessage "Installing work environment"
        #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Development.ps1 -DisableReboots

        if(-Not ($DisableJava))
        {
            Write-BoxstarterMessage "Installing Java stack tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Java.ps1 -DisableReboots
        }
        if(-Not ($DisableMEAN))
        {
            Write-BoxstarterMessage "Installing MEAN stack tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/MEAN.ps1 -DisableReboots
        }
        if(-Not ($DisableLAMP))
        {
            Write-BoxstarterMessage "Installing LAMP stack tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/LAMP.ps1 -DisableReboots
        }
        if(-Not ($DisableWINS))
        {
            Write-BoxstarterMessage "Installing WINS stack tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/WINS.ps1 -DisableReboots
        }
        if(-Not ($DisableMobile))
        {
            Write-BoxstarterMessage "Installing mobile tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Mobile.ps1 -DisableReboots
        }
        if(-Not ($DisableArchitect))
        {
            Write-BoxstarterMessage "Installing architect tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Architect.ps1 -DisableReboots
        }
        if(-Not ($DisableDesigner))
        {
            Write-BoxstarterMessage "Installing Designer tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Designer.ps1 -DisableReboots
        }
        if(-Not ($DisableArduino))
        {
            Write-BoxstarterMessage "Installing Arduino tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Arduino.ps1 -DisableReboots
        }
        if(-Not ($DisableOperations))
        {
            Write-BoxstarterMessage "Installing Operations tools"
            #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Operations.ps1 -DisableReboots
        }
    }
    if(-Not ($Professional)) # skip all personal scripts
    {
        Write-BoxstarterMessage "Installing play environment"
        #install personal
        #Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Personal.ps1 -DisableReboots
    }
    
    #--- Restore Temporary Settings ---
    Enable-UAC

    # Install Windows Updates
    Write-BoxstarterMessage "Running Windows Update"
    #Enable-MicrosoftUpdate
    #Install-WindowsUpdate -Full -AcceptEula 

    Write-BoxstarterMessage "Machine is complete!"

    ##--- Rename the Computer ---
    ## Requires restart, or add the -Restart flag
    Write-BoxstarterMessage "Renaming PC to " $NewMachineName
    #if ($env:computername -ne $NewMachineName) {
    #    Rename-Computer -NewName $NewMachineName
    #}
} catch {
    Write-ChocolateyFailure 'Boxstarter Error: ' $($_.Exception.Message)
    throw
}