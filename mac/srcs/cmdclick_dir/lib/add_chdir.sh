#!/bin/bash



#コマンドをユーザー入力フォームで取得
create_chdir_command_form(){
	center_box &
	local temp_file_name="$(($RANDOM % 1000))${COMMAND_CLICK_EXTENSION}"
	local temp_file_path="${INI_FILE_DIR_PATH}/${temp_file_name}"
	# open fd
	exec 3>&1
	# Store data to $VALUES variable
	CREATE_CHDIR_PATH=$(dialog  \
	    --backtitle "Linux User Managment" \
	    --title "${WINDOW_TITLE}" \
	    --form "please type setting dir_path\n" \
		"${box_size[@]}" \
	  "dir_path:" 1 1 "" 1 15 ${EDIT_CHAR_NUM} 0 \
	2>&1 1>&3)

	# close fd
	exec 3>&-
	#clear
	if [ -z "${CREATE_CHDIR_PATH}" ];then
		SIGNAL_CODE=${CHECK_ERR_CODE}
	elif [ -z "$(eval "echo \"${CREATE_CHDIR_PATH}\"" | rga "^/[a-zA-Z][a-zA-Z/._ -]*$")" ];then 
		local path_err_message=$(echo -e "type path is illegular \n\n  ${CREATE_CHDIR_PATH}")
		dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "${path_err_message}" "${INFO_BOX_DEFAULT_SIZE[@]}"
		CREATE_CHDIR_PATH=""
		SIGNAL_CODE=${CHECK_ERR_CODE}
	else 
		SIGNAL_CODE=${OK_CODE}
	fi
	# lecho "AFTER_CRANGING CREATE_CHDIR_PATH: ${CREATE_CHDIR_PATH}"
	# lecho "AFTER_CRANGING SIGNAL_CODE: ${SIGNAL_CODE}"
}


add_chdir_cmd_ini_file(){
	if [ -n "${1}" ]; then
		eval "mkdir -p \"${1}\""
		local ini_file_name=$(echo "${1}" | gsed -e 's/[^a-zA-Z0-9_./-]//g' -e 's/\//\_/g' -e 's/^\_//' -e 's/^/cd\_/' -e 's/$/'${COMMAND_CLICK_EXTENSION}'/')
		# lecho "ini_file_name: ${ini_file_name}"
		local add_contents=$(cat <(echo "${add_contents}") <(echo "SED_TARGET_PATH=\"${CMDCLICK_APP_LIST_PATH}\"") <(echo "sed_ch_dir_path=\$(echo \$${CH_DIR_PATH} | gsed -e 's/\\//\\\\\//g' -e 's/\./\\\\\./g')" | sed '/^$/d'))
		# gsed -e '/'${sed_ch_dir_path}'/d' -e "1i${sed_ch_dir_path}" -i "${SED_TARGET_PATH}"
		add_contents=$(cat <(echo "${add_contents}") <(echo "gsed -e '/'\${sed_ch_dir_path}'/d' -e \"1i\${sed_ch_dir_path}\" -i \"\${SED_TARGET_PATH}\""))
		local ini_file_source=$(cat <(echo "${CMDCLICK_USE_SHELL}") <(echo -e "") <(echo "${INI_SETTING_SECTION_START_NAME}")  <(echo "${INI_SETTING_DEFAULT_GAIN_CON}" | gsed -e 's/'${INI_TERMINAL_ON}'=.*/'${INI_TERMINAL_ON}'=OFF/' -re "s/(${INI_CMD_FILE_NAME}=)/\1${ini_file_name}/") <(echo "${INI_SETTING_SECTION_END_NAME}") <(echo -e "\n") <(echo "${INI_CMD_VARIABLE_SECTION_DEFAULT}" | gsed "2iCH_DIR_PATH=${1}") <(echo -e "\n") <(echo "${SEARCH_INI_CMD_SECTION_START_NAME}") <(echo "${add_contents}"))
		
		# lecho "ini_file_source: ${ini_file_source}"
		#iniファイル名策定のためコマンド文字列結合
		# lecho  "add_chdir_cmd_ini_file::AFTER ini_file_source: ${ini_file_source}"
		local ini_file_path="${CMDCLICK_CONF_DIR_PATH}/${ini_file_name}"
		echo  "${ini_file_source}" > "${ini_file_path}" &
	fi
}
