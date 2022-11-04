

Function setShortcutForCmdclick(){
    $relative_install_dir_path = "\cmdclick\win\install"
    $absolule_install_dir_path = "$HOME$relative_install_dir_path"
    $desti_program_dir_path = "c:\Program Files"
    Copy-Item `
        -Path "$absolule_install_dir_path\files\cmdclick"  `
        -Destination "$desti_program_dir_path" -Recurse -Force
    $realative_source_shortcut_path="\files\shortcut"
    $absolute_source_shortcut_path="$absolule_install_dir_path$realative_source_shortcut_path"
    $desti_startmenu_program_path = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

    Copy-Item `
        -Path "$absolute_source_shortcut_path\cmdclick.lnk"  `
        -Destination "$desti_startmenu_program_path" -Force
    $desti_relative_desktop_dir_path = "\Desktop"
    $desti_absolute_desktop_dir_path = "$HOME$desti_relative_desktop_dir_path"
    Copy-Item `
        -Path "$absolute_source_shortcut_path\*"  `
        -Destination "$desti_absolute_desktop_dir_path" -Recurse -Force
}
