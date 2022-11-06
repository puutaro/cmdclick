#!/bin/bash


choose_app_dir_list_for_move(){
	local LANG="ja_JP.UTF-8"
	local ifs_local="${IFS}"
	local IFS=$'\n'
	local ini_file_list=($(cat "${CMDCLICK_APP_LIST_PATH}"))
	local IFS="${ifs_local}"
	local title_message="\n please click app dir you want to move"
	title_message+="\n\t(current app dir: ${ini_file_list[0]}) \n"
	set +e
	yad \
	--list \
    --mouse \
    --scroll \
    --window-icon="${WINDOW_ICON_PATH}" \
    --title="${WINDOW_TITLE}" \
    --text="${title_message}" \
    --text-align=left \
    --height=${CENTER_SCALE_DISPLAY_HEIGHT} \
    --width=${CENTER_SCALE_DISPLAY_WIDTH} \
    --column="APP DIR PATH" \
    --center \
    --separator="" \
    "${ini_file_list[@]}" \
    --button  gtk-ok:${OK_CODE} \
    --button  gtk-close:${EXIT_CODE}
	set -e
}