

Function installWsl(){
    $wsl_list_source `
        = wsl `
        --list `
        --online 
    $wsl_list_grep_and_clean `
        = $wsl_list_source `
            -replace [char]0x00,'' `
            | sls "^Ubuntu"
    $wsl_list = `
        $wsl_list_grep_and_clean `
            -replace "  .*", ""
    do {
        $selected_distri = echo $wsl_list `
            | fzf `
                --prompt="type you wont to install distri from above> "
    } while ( 
        !$selected_distri 
    )
    $selected_distri_txt_path = "$HOME\distri.txt"
    echo $selected_distri `
        | Out-File -FilePath "$selected_distri_txt_path" `
                    -Encoding default `
                    -Force
    wsl.exe `
        --install `
        -d "$selected_distri"
}

