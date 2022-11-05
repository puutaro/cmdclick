

Function installWsl(){
    $wsl_list = `
        wsl --list --online `
        | % { $_ -replace [char]0x00,"" } `
        | sls Ubuntu | % { $_ -replace '^  ', ''} `
        | % { $_ -replace '^\* ',''} `
        | % { $_ -replace '  .*', '' };
    while ($true) {
        $selected_distri = `
            echo $wsl_list `
                | fzf `
                    --prompt="type you wont to install Ubuntu20.04+ distri from above > "
        $distri_version = `
            $selected_distri -replace 'Ubuntu','' `
                | % { $_ -replace '-','' } `
                | % { $_ -replace '\.','' }
        if(`
            $distri_version -ge 2000 `
        ){ 
            break
        }
        if( `
            $selected_distri `
            -And !$distri_version `
        ){ 
            break 
        }
    }
    $selected_distri_txt_path = "$HOME\distri.txt"
    echo $selected_distri `
        | Out-File -FilePath "$selected_distri_txt_path" `
                    -Encoding default `
                    -Force
    wsl.exe `
        --install `
        -d "$selected_distri"
}
