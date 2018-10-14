# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-GIST>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots

try{
    #---- TEMPORARY ---
    Disable-UAC
    
    Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/WindowsSettings.ps1 -DisableReboots
    Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Bloatware.ps1 -DisableReboots
    Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Common.ps1 -DisableReboots
    if(-Not ($Personal)) # skip all professional scripts
    {
        Write-BoxstarterMessage "Installing work environment"
        Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Development.ps1 -DisableReboots

        if(-Not ($DisableJava))
        {
            Write-BoxstarterMessage "Installing Java stack tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Java.ps1 -DisableReboots
        }
        if(-Not ($DisableMEAN))
        {
            Write-BoxstarterMessage "Installing MEAN stack tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/MEAN.ps1 -DisableReboots
        }
        if(-Not ($DisableLAMP))
        {
            Write-BoxstarterMessage "Installing LAMP stack tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/LAMP.ps1 -DisableReboots
        }
        if(-Not ($DisableWINS))
        {
            Write-BoxstarterMessage "Installing WINS stack tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/WINS.ps1 -DisableReboots
        }
        if(-Not ($DisableMobile))
        {
            Write-BoxstarterMessage "Installing mobile tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Mobile.ps1 -DisableReboots
        }
        if(-Not ($DisableArchitect))
        {
            Write-BoxstarterMessage "Installing architect tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Architect.ps1 -DisableReboots
        }
        if(-Not ($DisableDesigner))
        {
            Write-BoxstarterMessage "Installing Designer tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Designer.ps1 -DisableReboots
        }
        if(-Not ($DisableArduino))
        {
            Write-BoxstarterMessage "Installing Arduino tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Arduino.ps1 -DisableReboots
        }
        if(-Not ($DisableOperations))
        {
            Write-BoxstarterMessage "Installing Operations tools"
            Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Operations.ps1 -DisableReboots
        }
    }
    if(-Not ($Professional)) # skip all personal scripts
    {
        Write-BoxstarterMessage "Installing play environment"
        Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Tools/Personal.ps1 -DisableReboots
    }
    
    #--- Restore Temporary Settings ---
    Enable-UAC

    # Install Windows Updates
    Write-BoxstarterMessage "Running Windows Update"
    Enable-MicrosoftUpdate
    Install-WindowsUpdate -Full -AcceptEula 

    Write-BoxstarterMessage "Machine is complete!"

    ##--- Rename the Computer ---
    ## Requires restart, or add the -Restart flag
    $NewMachineName = "tsturm-devbox"
    Write-BoxstarterMessage "Renaming PC to " $NewMachineName
    if ($env:computername -ne $NewMachineName) {
        Rename-Computer -NewName $NewMachineName
    }