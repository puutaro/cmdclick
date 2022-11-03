#!/bin/bash

add_cmd_confirm(){
    local LANG="ja_JP.UTF-8"
	local temp_file_path="${1}"
    local converted_xml_escape_sequence=$(\
        echo_by_convert_xml_escape_sequence \
            "${temp_file_path}" \
    )
	local add_confirm="Do you really want to add shell file ?"
	yad --form \
      --title="${WINDOW_TITLE}" \
      --window-icon="${WINDOW_ICON_PATH}" \
      --item-separator='!'\
      --center \
      --scroll \
      --height=${CENTER_SCALE_DISPLAY_HEIGHT} \
      --width=${CENTER_SCALE_DISPLAY_WIDTH} \
      --field="\n ${add_confirm} ? \n  ${converted_xml_escape_sequence} \n\n":LBL ""
	local confirm=$?
	return "${confirm}"
}