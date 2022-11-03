

$pc_setting_lib_path = "$PSScriptRoot\pc_setting_lib"
$relative_install_dir_path = "\os_goods\cmdclick\win\install"
$absolule_install_dir_path = "$HOME$relative_install_dir_path"


Import-Module -Name "$pc_setting_lib_path\sysmain_disable.ps1" -Verbose
Import-Module -Name "$pc_setting_lib_path\win_update.ps1" -Verbose
Import-Module -Name "$pc_setting_lib_path\install_use_package_in_cmdclick.ps1" -Verbose
Import-Module -Name "$pc_setting_lib_path\add_path_for_packages.ps1"
Import-Module -Name "$pc_setting_lib_path\set_shortcut_for_cmdclick.ps1"
Import-Module -Name "$pc_setting_lib_path\set_no_dialog_elevate.ps1"
Import-Module -Name "$pc_setting_lib_path\install_wsl.ps1"
Import-Module -Name "$pc_setting_lib_path\exec_wsl_setting_bat.ps1"


cd $HOME
sysmainDisable
winUpdate

$env:Path = `
    [System.Environment]::GetEnvironmentVariable('Path','Machine') `
    + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Set-ExecutionPolicy Bypass -Scope Process -Force

installUsePackageInCmdclick
addPathForPackages
setShortcutForCmdclick
setNoDialogElevate
start-sleep 3;
installWsl
execWslSettingBat