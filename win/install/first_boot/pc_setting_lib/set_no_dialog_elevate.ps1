

Function setNoDialogElevate(){
    Set-ItemProperty `
        -Path 'REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System' `
        -Name ConsentPromptBehaviorAdmin -Value 0
}
