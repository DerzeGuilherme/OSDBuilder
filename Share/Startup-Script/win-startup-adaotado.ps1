function Request-PrivilegesElevation() {
    # Used from https://stackoverflow.com/a/31602095 because it preserves the working directory!
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
}

function Use-Scripts() {

    $DoneTitle = "Done"
    $DoneMessage = "Process Completed!"

    Push-Location -Path "C:\Windows\Temp\scripts\"

    Get-ChildItem -Recurse *.ps*1 | Unblock-File

    Clear-Host
    $Scripts = @(
        # [Recommended order]
        "optimize-windows-update.ps1",
        "disable-windows-defender.ps1",
        "block-telemetry.ps1",
        "disable-scheduled-tasks.ps1",
        "fix-privacy-settings.ps1",
        "disable-prefetch-prelaunch.ps1",
        "disable-services.ps1",
        "ssd-tune.ps1",
        "enable-god-mode.ps1",
        "enable-winrm.ps1",
        "optimize-user-interface.ps1",
        "remove-default-apps.ps1",
        "optimize-performance.ps1",
        "optimize-privacy.ps1",
        "personal-tweaks.ps1"
    )

    ForEach ($FileName in $Scripts) {
        Write-TitleCounter -Text "$FileName" -MaxNum $Scripts.Length
        PowerShell -NoProfile -ExecutionPolicy Bypass -file "C:\Windows\Temp\scripts\$FileName"
    }
    Pop-Location

    Show-Message -Title "$DoneTitle" -Message "$DoneMessage"

}

function Main() {

    Request-PrivilegesElevation # Check admin rights
    $Root = "C:\Windows\Temp"

    Write-Host "Your Current Folder $pwd"
    Write-Host "Script Root Folder $PSScriptRoot"
    Get-ChildItem -Recurse $PSScriptRoot\*.ps*1 | Unblock-File
    
    Import-Module -DisableNameChecking "$Root\lib\set-console-style.psm1"
    Set-ConsoleStyle            # Makes the console look cooler
    Import-Module -DisableNameChecking "$Root\lib\set-script-policy.psm1"
    Import-Module -DisableNameChecking "$Root\lib\show-message-box.psm1"
    Import-Module -DisableNameChecking "$Root\lib\title-templates.psm1"

    Set-UnrestrictedPermissions # Unlock script usage
    Use-Scripts                 # Run all scripts inside 'scripts' folder
    #Set-RestrictedPermissions   # Lock script usage
    Write-ASCIIScriptName       # Thanks Figlet
    #Request-PcRestart           # Prompt options to Restart the PC

}

Main