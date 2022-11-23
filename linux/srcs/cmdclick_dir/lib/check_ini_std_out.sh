#!/bin/bash

CHECK_INI_FILE_LIB_PATH="${LIB_DIR_PATH}/check_ini_file_lib"

. "${CHECK_INI_FILE_LIB_PATH}/ini_file_section_check.sh"
. "${CHECK_INI_FILE_LIB_PATH}/check_validate_err_dialog.sh"

check_ini_std_out(){
	local validate_err_message_head="\tvalidation err: "
	local validate_err_message_body=""
	local ini_contents="${1}" 
	#セクションネームをチェック
	validate_err_message_body+="$(\
		ini_file_section_check \
			"${validate_err_message_body}" \
			"${ini_contents}" \
	)"
	case "${validate_err_message_body}" in 
		"") return;;
		*) ;; esac		
	local check_message=$(\
		cat <(echo "bellow err, please re-edit  \n\n") \
			<(echo "  ${validate_err_message_body}")\
		)
	set +e
	check_validate_err_dialog \
		"${ini_contents}" \
		"${check_message}"
	set -e
}
