

Function installUsePackageInCmdclick(){
    choco install -y sublimetext4
    start-sleep 5
    $vclib_package_name = "Microsoft.VCLibs.x64.14.00.Desktop.appx"
    wget `
        "https://aka.ms/$vclib_package_name" `
        -OutFile "$vclib_package_name"
    Add-AppxPackage "$HOME\$vclib_package_name"
    $wt_package_name = "Microsoft.WindowsTerminal_Win10_1.15.2874.0_8wekyb3d8bbwe.msixbundle"
    wget `
        "https://github.com/microsoft/terminal/releases/download/v1.15.2874.0/$wt_package_name" `
        -OutFile "$wt_package_name";  
    Add-AppxPackage "$HOME\$wt_package_name"
    choco install -y microsoft-windows-terminal; 
    start-sleep 5; 
    choco install -y vcxsrv
    choco install -y fzf
}
