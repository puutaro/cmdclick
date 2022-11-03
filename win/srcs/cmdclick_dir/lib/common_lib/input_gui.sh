#!/bin/bash

. "${COMMON_LIB_DIR_PATH}/add_chdir_cmd_ini_file.sh"
. "${WIN_INPUT_GUI_LIB_DIR_PATH}/echo_ini_file_list.sh"
. "${WIN_INPUT_GUI_LIB_DIR_PATH}/terminal_forcus_set.sh"
. "${WIN_INPUT_GUI_LIB_DIR_PATH}/launcher_cmd_index_by_lxterminal.sh"
. "${WIN_INPUT_GUI_LIB_DIR_PATH}/echo_x_posi_y_posi_scale_width_scale_height.sh"
export -f echo_ini_file_list


reload_cmd(){
	LANG=C
	local inc_num=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}" | fetch_parameter_from_pip "${GREP_INC_NUM}")
	INI_FILE_DIR_PATH=$(cat "${CMDCLICK_APP_LIST_PATH}"  | sed -n ''${inc_num}'p')
	if [ ! -e "${INI_FILE_DIR_PATH}" ];then mkdir -p "${INI_FILE_DIR_PATH}";fi
	local display_ini_file_dir_path=$(\
		replace_home_dir_path_by_tilde \
			"${INI_FILE_DIR_PATH}" \
	)
	echo_ini_file_list \
		"${INI_FILE_DIR_PATH}" \
		"${display_ini_file_dir_path}"
	touch "${INI_FILE_DIR_PATH}"
}

exec_inc(){
	LANG=C
	local inc_con=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}")
	local inc_sup=$(cat "${CMDCLICK_APP_LIST_PATH}" | wc -l | sed 's/\ //g')
	local inc_num=$(echo "${inc_con}"  | fetch_parameter_from_pip "${GREP_INC_NUM}")
	if [ ${inc_num} -ge ${inc_sup} ];then local inc_num_after=1;
	else local inc_num_after=$((${inc_num} + 1));fi
	echo "${GREP_INC_NUM}=${inc_num_after}" > "${CMDCLICK_CONF_INC_CMD_PATH}"
}

exec_dec(){
	LANG=C
	local inc_con=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}")
	local inc_sup=$(cat "${CMDCLICK_APP_LIST_PATH}" | wc -l | sed 's/\ //g')
	local inc_num=$(echo "${inc_con}"  | fetch_parameter_from_pip "${GREP_INC_NUM}")
	if [ ${inc_num} -le 1 ];then local inc_num_after=${inc_sup};
	else local inc_num_after=$((${inc_num} - 1));fi
	echo "${GREP_INC_NUM}=${inc_num_after}" > "${CMDCLICK_CONF_INC_CMD_PATH}"
}

input_cmd_index(){
	#画面大きさ策定
	#まず、解像度取得
	local ifs_old=${IFS}
	local IFS=$',' 
	local x_posi_y_posi_scale_width_scale_height_list=($(echo_x_posi_y_posi_scale_width_scale_height))
	local IFS="${ifs_old}"
	local x_position="${x_posi_y_posi_scale_width_scale_height_list[0]}"
	local y_position="${x_posi_y_posi_scale_width_scale_height_list[1]}"
	local scale_display_width="${x_posi_y_posi_scale_width_scale_height_list[2]}"
	local scale_display_height="${x_posi_y_posi_scale_width_scale_height_list[3]}"
	terminal_forcus_set "${EXECUTE_COMMAND}" &
	local display_ini_file_dir_path=$(\
		echo_display_ini_file_dir_path \
			"${NORMAL_SIGNAL_CODE}" \
		)
	local ini_file_list=$(\
		echo_ini_file_list \
			"${INI_FILE_DIR_PATH}" \
 			"${display_ini_file_dir_path}" \
	)
	launcher_cmd_index_by_lxterminal \
		"${INI_FILE_DIR_PATH}" \
		"${ini_file_list}" \
		"${x_position}" \
		"${y_position}" \
		"${scale_display_width}" \
		"${scale_display_height}"
	local ifs_old=${IFS}
	local IFS=$',' 
	local status_and_ini_file_and_dir_list=($(cat "${CMDCLICK_VALUE_SIGNAL_FILE_PATH}"))
	local IFS="${ifs_old}"
	cat /dev/null > "${CMDCLICK_VALUE_SIGNAL_FILE_PATH}"
	local return_status=${status_and_ini_file_and_dir_list[0]:-}
	EXECUTE_FILE_NAME=$(\
		echo_by_remove_pre_or_suffix_single_quote \
			"${status_and_ini_file_and_dir_list[1]:-}"\
	)
	INI_FILE_DIR_PATH=$(\
		echo_by_remove_pre_or_suffix_single_quote \
			"${status_and_ini_file_and_dir_list[2]:-}"\
	)
	upgrade_app_dir_list_order \
		"${INI_FILE_DIR_PATH}" &
	SIGNAL_CODE=$(judge_signal_code "${return_status}")
	#設定変数初期化
	EXECUTE_COMMAND=""
	EXEC_TERMINAL_ON=""
	EXEC_OPEN_WHERE=""
	EXEC_TERMINAL_SIZE=""
	EXEC_TERMINAL_FOCUS=""
	EXEC_INPUT_EXECUTE=""
	EXEC_IN_EXE_DFLT_VL=""
	EXEC_BEFORE_COMMAND=""
	EXEC_AFTER_COMMAND=""
	EXEC_EXEC_WAKE=""
	EDIT_EDITOR_ON=""
}