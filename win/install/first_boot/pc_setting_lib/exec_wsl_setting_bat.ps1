

Function execWslSettingBat(){
    $relative_install_dir_path = "\os_goods\cmdclick\win\install"
    $absolule_install_dir_path = "$HOME$relative_install_dir_path"
    cmd `
        /c "$absolule_install_dir_path\first_boot\set_after_pc_setting.bat"
}
