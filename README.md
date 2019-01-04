# MachineSetup
These are scripts I use to setup new machines. They are intended to be idempotent.

# Instructions
1. Open a PowerShell window with elevated permissions
2. Run `Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Oxymoron290/MachineSetup/master/Start.ps1'))` in this shell.