# MachineSetup
These are scripts I use to setup new machines

# Instructions
1. Open a PowerShell window with elevated permissions
2. Run `Set-ExecutionPolicy Unrestricted` in this shell.
3. Type 'A' to accept the changes
4. execute `. { Invoke-WebRequest -useb https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Start.ps1 } | iex` in this shell

# TODO & Notes

`Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Start.ps1 -DisableReboots`

`http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Start.ps1`