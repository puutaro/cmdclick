#!/bin/bash


app_dir_setting_index(){
    local LANG="ja_JP.UTF-8"
	local ini_file_list="${1}"
	local scale_display_width="${2}"
	local parrent_dir_name="$(dirname $0)"
	local two_parrent_dir_name="$(dirname ${parrent_dir_name})"
	local import_path_input_gui="${two_parrent_dir_name}/input_gui.sh"
	local one_string_width=13
	local preview_string_width=$((${scale_display_width} / ${one_string_width}))
	export preview_string_width=${preview_string_width}
    echo "${ini_file_list}" | \
        fzf --delimiter $'\t' \
            --layout=reverse \
            --border  \
            --with-nth 1 \
            --cycle \
            --header-lines=1 \
            --bind "Alt-w:execute(open_editor {2}/{1})" \
            --bind "Alt-e:execute(echo \"${EDIT_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
            --bind "Alt-E:execute(echo \"${DESCRIPTION_EDIT_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
            --bind "Alt-a:execute(echo \"${ADD_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
            --bind "Alt-d:execute(echo \"${DELETE_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
            --preview 'LANG="ja_JP.UTF-8" echo $(head -100 {2}/{1} | grep -E "^CH_DIR_PATH") | fold -b'${preview_string_width}' ' \
            --color 'fg:#000000,fg+:#ddeeff,bg:#f2f2f2,preview-bg:#e6ffe6,border:#ffffff'\
            --color 'info:#00b386,hl+:#02ebc7,hl:#0750fa,header:#000000,gutter:#000000' \
            --color 'marker:#0750fa,spinner:#0750fa,pointer:#4382f7,prompt:#000000' \
            --preview-window top:2
}