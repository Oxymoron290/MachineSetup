# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-GIST>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots

try{
    #---- TEMPORARY ---
    Disable-UAC
    
    Install-BoxstarterPackage -PackageName ./WindowsSettings.ps1 -DisableReboots
    Install-BoxstarterPackage -PackageName ./Bloatware.ps1 -DisableReboots
    Install-BoxstarterPackage -PackageName ./Common.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing work environment"
    Install-BoxstarterPackage -PackageName ./Development.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing Java stack tools"
    Install-BoxstarterPackage -PackageName ./Java.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing MEAN stack tools"
    Install-BoxstarterPackage -PackageName ./MEAN.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing LAMP stack tools"
    Install-BoxstarterPackage -PackageName ./LAMP.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing WINS stack tools"
    Install-BoxstarterPackage -PackageName ./WINS.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing mobile tools"
    Install-BoxstarterPackage -PackageName ./Mobile.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing architect tools"
    Install-BoxstarterPackage -PackageName ./Architect.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing Designer tools"
    Install-BoxstarterPackage -PackageName ./Designer.ps1 -DisableReboots
    
    Write-BoxstarterMessage "Installing Arduino tools"
    Install-BoxstarterPackage -PackageName ./Arduino.ps1 -DisableReboots

    Write-BoxstarterMessage "Installing Operations tools"
    Install-BoxstarterPackage -PackageName ./Operations.ps1 -DisableReboots

    #Write-BoxstarterMessage "Installing play environment"
    #Install-BoxstarterPackage -PackageName ./Personal.ps1 -DisableReboots

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
} catch {
    Write-ChocolateyFailure 'Boxstarter Error: ' $($_.Exception.Message)
    throw
}