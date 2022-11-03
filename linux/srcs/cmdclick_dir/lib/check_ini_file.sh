#!/bin/bash

CHECK_INI_FILE_LIB_PATH="${LIB_DIR_PATH}/check_ini_file_lib"

. "${CHECK_INI_FILE_LIB_PATH}/ini_file_section_check.sh"
. "${CHECK_INI_FILE_LIB_PATH}/check_validate_err_dialog.sh"
unset -v CHECK_INI_FILE_LIB_PATH

check_ini_file(){
	local check_ini_file_path="${1}"
	local validate_err_message_head="\tvalidation err: "
	local validate_err_message_body=""
	if [ ! -e "${check_ini_file_path}" ]; then
		validate_err_message_body+="file locate or name err ("${check_ini_file_path}")"
	fi
	case "${validate_err_message_body}" in 
		"") local ini_contents=$(cat "${check_ini_file_path}")
	;; esac
	#セクションネームをチェック
	validate_err_message_body+="$(\
		ini_file_section_check \
			"${validate_err_message_body}" \
			"${ini_contents}" \
	)"
	case "${validate_err_message_body}" in 
		"") return;;
		*) ;; esac		

	set +e
	check_validate_err_dialog \
		"${check_ini_file_path}" \
		"${validate_err_message_body}"
	set -e
}
