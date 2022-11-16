#!/bin/bash

read_ini_to_cmd_lib_dir_path="${HANDLER_LIB_DIR_PATH}/read_ini_to_cmd_lib"
. "${read_ini_to_cmd_lib_dir_path}/set_setting_section_parameter.sh"

unset -v read_ini_to_cmd_lib_dir_path


read_ini_to_execute_command(){
	local LANG="ja_JP.UTF-8"
	local execute_file_name="${1}"
	local ifs_old="${IFS}"
	local IFS=$'\n'; 
	local variabl_contensts_setting_value_list=(\
		$(\
			set_setting_section_parameter \
				"${execute_file_name}" \
		)\
	)
	local IFS="${ifs_old}"
	 #セッティングセクションのデータを取り込む
	EXECUTE_COMMAND="bash \"${execute_file_name}\""
 	EXEC_TERMINAL_ON="${variabl_contensts_setting_value_list[0]}"
	EXEC_OPEN_WHERE="${variabl_contensts_setting_value_list[1]}"
	EXEC_TERMINAL_FOCUS="${variabl_contensts_setting_value_list[2]}"
	EXEC_EDIT_EXECUTE="${variabl_contensts_setting_value_list[3]}"
	EXEC_SET_VARIABLE_TYPE="${variabl_contensts_setting_value_list[4]}"
	EXEC_BEFORE_COMMAND="$(echo "${variabl_contensts_setting_value_list[5]}" | sed -e 's/^"//' -e 's/"$//')"
	EXEC_AFTER_COMMAND="$(echo "${variabl_contensts_setting_value_list[6]}" | sed -e 's/^"//' -e 's/"$//')"
}
