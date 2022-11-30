#!/bin/bash

check_validate_err_dialog(){
	local LANG="ja_JP.UTF-8"
	local validate_entry_file_path="${1}"
	local check_message="${2}"
	local xml_escape_check_message=$(\
		echo_by_convert_xml_escape_sequence \
			"${check_message}" \
	)
	if [ -e "${validate_entry_file_path}" ]; then
		xml_escape_validate_target_file_path="$(\
			echo_by_convert_xml_escape_sequence \
				"${validate_entry_file_path}" \
		)"
	else
		xml_escape_validate_target_file_path="-";
	fi
	yad --form \
		--title="${WINDOW_TITLE}" \
		--window-icon="${WINDOW_ICON_PATH}" \
		--center \
		--scroll \
		--height=${CENTER_SCALE_DISPLAY_HEIGHT} \
			--width=${CENTER_SCALE_DISPLAY_WIDTH} \
		--item-separator='!'\
		--borders=${CMDCLICK_BORDER_NUM} \
		--field="\n bellow err, please ini file manual repair or delete \n (FILEPATH: "${xml_escape_validate_target_file_path}")":LBL   "" \
		--field="${xml_escape_check_message}":LBL \
		--button=gtk-ok:${OK_CODE} 
	SIGNAL_CODE=${CHECK_ERR_CODE}	
}