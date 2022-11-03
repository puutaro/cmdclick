

Function setShortcutForCmdclick(){
    $relative_install_dir_path = "\os_goods\cmdclick\win\install"
    $absolule_install_dir_path = "$HOME$relative_install_dir_path"
    $desti_program_dir_path = "c:\Program Files"
    Copy-Item `
        -Path "$absolule_install_dir_path\files\cmdclick"  `
        -Destination "$desti_program_dir_path" -Recurse -Force

    $desti_relative_desktop_dir_path = "\Desktop"
    $desti_absolute_desktop_dir_path = "$HOME$desti_relative_desktop_dir_path"
    Copy-Item `
        -Path "$absolule_install_dir_path\files\shortcut\*"  `
        -Destination "$desti_absolute_desktop_dir_path" -Recurse -Force
}
