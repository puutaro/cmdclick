#!/bin/bash

#コマンドをユーザー入力フォームで取得
create_command_form(){
	center_box &
	local temp_file_name="$(($RANDOM % 1000))${COMMAND_CLICK_EXTENSION}"
	local temp_file_path="${INI_FILE_DIR_PATH}/${temp_file_name}"
	local default_sh_con=$(cat <(echo "${CMDCLICK_USE_SHELL}") <(echo -e "") <(echo "${INI_SETTING_SECTION_START_NAME}")  <(echo "${INI_SETTING_DEFAULT_GAIN_CON}" | sed -r "s/(${INI_CMD_FILE_NAME}=)/\1${temp_file_name}/") <(echo "${INI_SETTING_SECTION_END_NAME}") <(echo -e "\n") <(echo "${INI_CMD_VARIABLE_SECTION_DEFAULT}")   <(echo -e "\n") <(echo "${SEARCH_INI_CMD_SECTION_START_NAME}") <(echo -e "\n "))
	echo "${default_sh_con}" > "${temp_file_path}"
	wait
	sleep 0.8 && open_editor "${temp_file_path}"
	local add_confirm="Do you really want to add shell file ?"
	exec 3>&1
	local VALUES=$(dialog --title "${WINDOW_TITLE}"  --no-shadow --menu "${add_confirm}" ${box_size[@]} \
	select "y or n" \
	2>&1 1>&3)
	# close fd
	exec 3>&-
	clear
	case "${VALUES}" in 
		"")
			if [ -e "${temp_file_path}" ];then rm -f "${temp_file_path}";fi
			local seed_code=${OK_CODE}
			;;
		*) local seed_code=${EXIT_CODE}
			;;
	esac

	# lecho "seed_code: ${seed_code}"
	if [ ${seed_code} -eq ${EXIT_CODE} ] || [ ${seed_code} -ge ${FORCE_EXIT_CODE} ]; then
		SIGNAL_CODE=${EXIT_CODE}
	elif [ ${seed_code} -eq ${OK_CODE} ]; then
		SIGNAL_CODE=${OK_CODE}
	fi
	# lecho "SIGNAL_CODE: ${SIGNAL_CODE}"
	# lecho "BEFORE_CRANGING CREATE_SOURCE_CMD: ${CREATE_SOURCE_CMD}"
	if [ -e "${temp_file_path}" ];then 
		local ini_rename_file_name=$(cat "${temp_file_path}" | grep "${INI_CMD_FILE_NAME}="| cut -d= -f2)
		if [ "${ini_rename_file_name}" != "${temp_file_name}" ]; then
	        mv "${temp_file_path}" "${INI_FILE_DIR_PATH}/${ini_rename_file_name}"
	    fi
	fi
	# lecho "AFTER_CRANGING CREATE_SOURCE_CMD: ${CREATE_SOURCE_CMD}"
	# lecho "AFTER_CRANGING SIGNAL_CODE: ${SIGNAL_CODE}"
}