#!/bin/bash


set -eu
readonly EDIT_FILE_PATH="${1}"
readonly WINDOW_TITLE="${2}"
readonly WINDOW_ICON="${3}"
readonly EDIT_WINDOW_LOCATION="${4}"
readonly exec_path_in_make_ini_contents_lib="$(dirname "${0}")"
readonly make_ini_contents_lib_path=$(dirname "${exec_path_in_make_ini_contents_lib}")
readonly edit_ini_file_lib=$(dirname "${make_ini_contents_lib_path}")
readonly edit_lib=$(dirname "${edit_ini_file_lib}")
readonly cmdclick_lib=$(dirname "${edit_lib}")
readonly common_lib="${cmdclick_lib}/common_lib"
readonly CMDCLICK_DIR=$(dirname "${cmdclick_lib}")
readonly exec_cmdclick_path="${CMDCLICK_DIR}/exec_cmdclick.sh"
readonly IMPORT_CMDCLICK_VAL=1


kill_exist_description(){
	local window_title="${1}"
	local processes=$(\
		ps aux \
		| awk \
		-v window_title="${window_title}" \
		'(\
			$0 ~ window_title \
			&& $0 !~ " grep " \
		){ 
			printf $2"\t"
		}' \
	)
	case "${processes}" in
		"") return
	esac
	kill ${processes}
}


display_discription(){
	local edit_file_path="${1}"
	local window_title_source="${2}"
	local window_icon="${3}"
	local edit_window_location="${4}"
	local LANG="ja_JP.UTF-8"
	. "${exec_cmdclick_path}"
	. "${common_lib}/echo_by_convert_xml_escape_sequence.sh"
	ACTIVE_CHECK_VARIABLE=0
	local window_title="${window_title_source}:description"
	kill_exist_description \
		"${window_title}"
	local EDIT_DESCRIPTION=$(\
		echo_labeling_section_bitween_start_and_end \
			"$(cat "${edit_file_path}")" \
			"print" \
	)
	case "${EDIT_DESCRIPTION}" in
		"") return 
		;;
	esac
	EDIT_DESCRIPTION="$(\
		echo_by_convert_xml_escape_sequence_new_line \
			"${EDIT_DESCRIPTION}"\
	)"
	local LANG="ja_JP.UTF-8"
	echo "${CMDCLICK_WINDOW_ICON_PATH}"
    yad \
	    --form \
	    --title="${window_title}" \
	    --window-icon="${window_icon}" \
	    --text="\n${EDIT_DESCRIPTION} \n" \
	    --borders=${CMDCLICK_BORDER_NUM} \
	    ${edit_window_location} \
	    --button  gtk-cancel:${EXIT_CODE} \
	    --scroll 
}

display_discription \
	"${EDIT_FILE_PATH}" \
	"${WINDOW_TITLE}" \
	"${WINDOW_ICON}" \
	"${EDIT_WINDOW_LOCATION}"