#!/bin/bash


ADD_CHDIR_CMD_INI_FILE_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/add_chdir_cmd_ini_file_lib"

. "${ADD_CHDIR_CMD_INI_FILE_LIB_DIR_PATH}/echo_ini_file_name.sh"
. "${ADD_CHDIR_CMD_INI_FILE_LIB_DIR_PATH}/echo_main_contents.sh"
. "${ADD_CHDIR_CMD_INI_FILE_LIB_DIR_PATH}/echo_make_ini_file_source.sh"
unset -v ADD_CHDIR_CMD_INI_FILE_LIB_DIR_PATH


add_chdir_cmd_ini_file(){
	local create_chdir_path="${1}"
	case "${create_chdir_path}" in 
		"") return
	;; esac
	local LANG="ja_JP.UTF-8"
	eval "mkdir -p \"${create_chdir_path}\""
	local ini_file_name=$(\
		echo_ini_file_name \
			"${create_chdir_path}" \
	)
	local main_contents=$(\
		echo_main_contents
	)
	local ini_file_source=$(\
		echo_make_ini_file_source \
			"${ini_file_name}" \
			"${main_contents}"
	)
	local ini_file_path="${CMDCLICK_APP_DIR_PATH}/${ini_file_name}"
	echo  "${ini_file_source}" > "${ini_file_path}" &
}
