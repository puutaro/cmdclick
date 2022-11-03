#!/bin/bash


read_ini_to_execute_command(){
	# lecho "---"
	#通常記号からcmdclick特殊文字へ変換(sedのため)
	local source_con=$(cat "${1}" | sed -n '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/,/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/d' | grep "^[a-zA-Z0-9_-]\{1,100\}=")
	# lecho "source_con: ${source_con}"
    local all_key_con=$(echo "${source_con}" | cut -d= -f1)
    local ini_value=$(echo "${source_con}" | sed -r "s/^([a-zA-Z0-9_-]{1,100})=$/\1=-/" | cut -d= -f2)
 	# lecho "convert_input_value: ${ini_value}"
	local set_key_value=$(paste -d '=' <(echo "${all_key_con}") <(echo "${ini_value}" | sed -r 's/([^a-zA-Z0-9_])/\\\1/g'))
	local sed_set_key_value_con=$(echo "${set_key_value}" | sed -r "s/(^[a-zA-Z0-9_-]{1,100})\=(.*)/| sed 's\/^\1\=.*\/\1=\2\/'/" | tr -d '\n')
	local exec_key_value_con=$(eval "echo \"\${INI_SETTING_DEFAULT_GAIN_CON}\" ${sed_set_key_value_con}" | sed -r "s/(^[a-zA-Z0-9_-]{1,100})=$/\1=-/"  | cut -d= -f2 | tr '\n' '\t')
	# lecho "exec_key_value_con: ${exec_key_value_con}"

	local IFS=$'\t'; local variabl_contensts_setting_value_list=($(echo "${exec_key_value_con}"))
	# lecho "variabl_contensts_setting_value_list: ${variabl_contensts_setting_value_list[@]}"
	# lecho "${#variabl_contensts_setting_value_list[@]}"
	# lecho "variabl_contensts_setting_value_list_length: ${#variabl_contensts_setting_value_list[@]}"
	local IFS=$' \n'
	 #セッティングセクションのデータを取り込む
	EXECUTE_COMMAND="bash ${1}"
 	EXEC_TERMINAL_ON=${variabl_contensts_setting_value_list[0]}
	EXEC_OPEN_WHERE=${variabl_contensts_setting_value_list[1]}
	EXEC_TERMINAL_SIZE=${variabl_contensts_setting_value_list[2]}
	EXEC_TERMINAL_FOCUS=${variabl_contensts_setting_value_list[3]}
	EXEC_INPUT_EXECUTE=${variabl_contensts_setting_value_list[4]}
	EXEC_IN_EXE_DFLT_VL=${variabl_contensts_setting_value_list[5]}
	EXEC_BEFORE_COMMAND="${variabl_contensts_setting_value_list[6]}"
	EXEC_AFTER_COMMAND="${variabl_contensts_setting_value_list[7]}"
}

