#!/bin/bash

reload_cmd(){
	local inc_num=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}" | grep -i "^${GREP_INC_NUM}=" | sed -e 's/'${GREP_INC_NUM}'\=//' -e '/^$/d')
	SECONDS_INI_FILE_DIR_PATH=$(cat "${CMDCLICK_APP_LIST_PATH}"  | sed -n ''${inc_num}'p')
	local sed_home_path=$(echo "${HOME}" | sed 's/\//\\\//g')
	local display_sec_ini_path=$(echo "${SECONDS_INI_FILE_DIR_PATH}" | sed 's/'${sed_home_path}'/~/')
	local sed_dir_path=$(echo "${SECONDS_INI_FILE_DIR_PATH}" | sed 's/\//\\\//g')

	case "${SIGNAL_CODE}" in 
		"${DELETE_CODE}"|"${EDIT_CODE}")
				local ini_file_list=$(ls -t  "${SECONDS_INI_FILE_DIR_PATH}/" | sed 's/\*$//g' | grep -i ''${COMMAND_CLICK_EXTENSION}'' | sed -e '1i ['${display_sec_ini_path}']' -e 's/$/\t'${sed_dir_path}'/' | grep -v "${CMDCLICK_EDIT_CMD}" | grep -v "${CMDCLICK_DELETE_CMD}" | grep -v "${CMDCLICK_CHANGE_DIR_CMD}" | grep -v "${CMDCLICK_RESOLUTION_CMD}" | grep -v "${CMDCLICK_ADD_CMD}")
				case "${ini_file_list}" in
					"") 
						local ini_file_list="$(cat <(echo "[${display_sec_ini_path}"]) <(echo "-") | sed 's/$/\t'${sed_dir_path}'/')"
						;;
				esac
				;;
		*)
			local ini_file_list=$(ls -t "${SECONDS_INI_FILE_DIR_PATH}/" | sed 's/\*$//g' | grep -i ''${COMMAND_CLICK_EXTENSION}'' | sed -e 's/$/\t'${sed_dir_path}'/' -e '1i ['${display_sec_ini_path}']' -e 's/$/\t'${sed_dir_path}'/')
			case "${ini_file_list}" in
				"")
					local ini_file_list="$(cat <(echo "[${display_sec_ini_path}"]) <(echo "-") | sed 's/$/\t'${sed_dir_path}'/')"
					;;
			esac
			echo "${ini_file_list}"
	esac
	touch "${SECONDS_INI_FILE_DIR_PATH}" &
}

exec_inc(){
	local inc_con=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}")
	local inc_sup=$(cat "${CMDCLICK_APP_LIST_PATH}" | wc -l)
	local inc_num=$(echo "${inc_con}" | grep -i "^${GREP_INC_NUM}=" | sed -e 's/'${GREP_INC_NUM}'\=//' -e '/^$/d')
	if [ ${inc_num} -ge ${inc_sup} ];then local inc_num_after=1;
	else local inc_num_after=$((${inc_num} + 1));fi
	echo "${GREP_INC_NUM}=${inc_num_after}" > "${CMDCLICK_CONF_INC_CMD_PATH}"
}

exec_dec(){
	local inc_con=$(cat "${CMDCLICK_CONF_INC_CMD_PATH}")
	local inc_sup=$(cat "${CMDCLICK_APP_LIST_PATH}" | wc -l)
	local inc_num=$(echo "${inc_con}" | grep -i "^${GREP_INC_NUM}=" | sed -e 's/'${GREP_INC_NUM}'\=//' -e '/^$/d')
	if [ ${inc_num} -le 1 ];then local inc_num_after=${inc_sup};
	else local inc_num_after=$((${inc_num} - 1));fi
	echo "${GREP_INC_NUM}=${inc_num_after}" > "${CMDCLICK_CONF_INC_CMD_PATH}"
}


input_cmd_index(){
	#current dir info
	local sed_home_path=$(echo "${HOME}" | sed 's/\//\\\//g')
	if [ ! ${NORMAL_SIGNAL_CODE} -eq ${CHDIR_CODE} ];then
		local display_sec_ini_path=$(echo "${SECONDS_INI_FILE_DIR_PATH}" | sed 's/'${sed_home_path}'/~/')
	else 
		local display_sec_ini_path=$(echo "${CMDCLICK_CONF_DIR_PATH}" | sed 's/'${sed_home_path}'/~/')
	fi
	# lecho "sed_home_path: ${sed_home_path}"
	# lecho "display_sec_ini_path: ${display_sec_ini_path}"
	local sed_dir_path=$(echo "${1}" | sed 's/\//\\\//g')
	case "${SIGNAL_CODE}" in 
		"${DELETE_CODE}"|"${EDIT_CODE}")
			local ini_file_list="$(ls -t  "${1}/" | sed 's/\*$//g' | grep -i ''${COMMAND_CLICK_EXTENSION}'' | sed '1i ['${display_sec_ini_path}']' | sed 's/$/\t'${sed_dir_path}'/' | grep -v "${CMDCLICK_EDIT_CMD}" | grep -v "${CMDCLICK_DELETE_CMD}" | grep -v "${CMDCLICK_CHANGE_DIR_CMD}" | grep -v "${CMDCLICK_RESOLUTION_CMD}" | grep -v "${CMDCLICK_ADD_CMD}")"
			case "${ini_file_list}" in
				"") 
					local ini_file_list="$(cat <(echo "[${display_sec_ini_path}"]) <(echo "-") | sed 's/$/\t'${sed_dir_path}'/')"
					;;
			esac
			;;
		*)
			local ini_file_list="$(ls -t "${1}" | sed 's/\*$//g' | grep -i ''${COMMAND_CLICK_EXTENSION}'' | sed -e '1i ['${display_sec_ini_path}']' -e 's/$/\t'${sed_dir_path}'/')"
			case "${ini_file_list}" in
				"")
					local ini_file_list="$(cat <(echo "[${display_sec_ini_path}"]) <(echo "-") | sed 's/$/\t'${sed_dir_path}'/')"
					;;
			esac
			;;
	esac
	set +ux
	# lecho "ini_file_list: ${ini_file_list}"
	# lecho "${EXECUTE_COMMAND}"

	# lecho ${EXEC_TERMINAL_SIZE}
	case "${EXECUTE_COMMAND}" in 
		"") center_box & ;;
		*)
			case "${EXEC_TERMINAL_ON}" in 
				"OFF")
					case "${EXEC_TERMINAL_FOCUS}" in 
						"ON") right_box "${CMD_CLICK_SOURCE_APP}" &
								;;
					esac
					;;
				"ON")
					case "${EXEC_TERMINAL_FOCUS}" in 
						"ON") 
							cmd_click_startup_app & #"${CMD_CLICK_TARGET_APP}" &
							;;
						"OFF")
							# if [ "${EXEC_TERMINAL_SIZE}" == "MAX" ]; then right_box "${CMD_CLICK_SOURCE_APP}" ;
							# elif [ "${EXEC_TERMINAL_SIZE}" == "RMAX" ]; then left_maximize_box "${CMD_CLICK_SOURCE_APP}" 
							# elif [ "${EXEC_TERMINAL_SIZE}" == "LMAX" ]; then right_maximize_box "${CMD_CLICK_SOURCE_APP}";
							right_box & #"${CMD_CLICK_SOURCE_APP}" &
							;;
					esac
					;;
			esac 
			;;
	esac
	EXECUTE_COMMAND=""
	EXEC_TERMINAL_FOCUS=""
	case "${1}" in 
		"${CMDCLICK_CONF_DIR_PATH}")
			wait
			echo -e "\033];Please Dir ${WINDOW_TITLE} \007" &
		 	 LANG=ja_JP.utf8 IFS=$'\t' read -r -a VALUE < <(
		        echo "${ini_file_list}" | \
			        fzf --delimiter $'\t' \
			        	--layout=reverse \
			        	--border  \
			        	--with-nth 1 \
			        	--cycle \
			        	--header-lines=1 \
			        	--bind "Alt-w:execute(open_editor '{2}/{1}')" \
			        	--bind "Alt-e:execute(echo \"${EDIT_CODE} {1} {2}\"  > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-a:execute(echo \"${ADD_CODE} {1} {2}\"  > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-d:execute(echo \"${DELETE_CODE} {1} {2}\"  > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--preview 'LANG="ja_JP.UTF-8" echo $(head -100 {2}/{1} | sed '1d' | sed '1,/'CMD_VARIABLE_SECTION'/!d' | sed '/'CMD_VARIABLE_SECTION'/d')' \
			        	--color 'info:#0750fa,hl+:#02ebc7,hl:#0750fa,gutter:#000000' \
			        	--color 'marker:#0750fa,spinner:#0750fa,pointer:#4382f7,prompt:#000000' \
			        	--preview-window top:1 \
			    )
			;;
		*)
			wait
			echo -e "\033];Please ${WINDOW_TITLE} \007" &
			#  | sed "s/[^\x01-\x7E]//g"
			LANG=ja_JP.utf8 IFS=$'\t' read -r -a VALUE < <(
		        echo "${ini_file_list}" | \
			        fzf --delimiter $'\t' \
			        	--layout=reverse \
			        	--border  \
			        	--with-nth 1 \
			        	--cycle \
			        	--header-lines=1 \
			        	--info=inline \
			        	--preview 'LANG="ja_JP.UTF-8" echo $(head -100 {2}/{1} | sed '1d' | sed 's/^#.*//' | sed "s/^[a-zA-Z0-9_-]\{1,100\}=.*//")' \
			        	--bind "Alt-w:execute(open_editor '{2}/{1}')" \
			        	--bind "Alt-e:execute(echo \"${EDIT_CODE} {1} {2}\" > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-a:execute(echo \"${ADD_CODE} {1} {2}\" > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-d:execute(echo \"${DELETE_CODE} {1} {2}\" > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-c:execute(echo \"${CHDIR_CODE} {1} {2}\" > '${CMDCLICK_PASTE_SIGNAL_FILE_PATH}')+abort" \
			        	--bind "Alt-g:execute(open_editor '${CMDCLICKL_SETTUING_FILE_PATH}')" \
			        	--bind "Alt-s:reload(export IMPORT_CMDCLICK_VAL=1 && . \"$(dirname $0)/exec_cmdclick.sh\" && . \"$(dirname $0)/lib/input_gui.sh\" && export SIGNAL_CODE=${SIGNAL_CODE} && exec_inc && reload_cmd)" \
			        	--bind "Alt-S:reload(export IMPORT_CMDCLICK_VAL=1 && . \"$(dirname $0)/exec_cmdclick.sh\" && . \"$(dirname $0)/lib/input_gui.sh\" && export SIGNAL_CODE=${SIGNAL_CODE} && exec_dec && reload_cmd)" \
			        	--bind "Alt-r:reload(export IMPORT_CMDCLICK_VAL=1 && . \"$(dirname $0)/exec_cmdclick.sh\" && . \"$(dirname $0)/lib/input_gui.sh\" && export SIGNAL_CODE=${SIGNAL_CODE} && reload_cmd)" \
			        	--color 'info:#0750fa,hl+:#02ebc7,hl:#0750fa,gutter:#000000' \
			        	--color 'marker:#0750fa,spinner:#0750fa,pointer:#4382f7,prompt:#121212' \
			        	--bind "Alt-v:execute(echo {2}/{1} | tr -d '\n' | wl-copy)" \
			        	--preview-window top:1 \
			    )
			;;
	esac	

	local status_code=$?
 	clear &
 	local hit_app_dir_file=$(grep -r "${VALUE[1]}"  "${CMDCLICK_CONF_DIR_PATH}" | grep "${CH_DIR_PATH}" | sed 's/\:'${CH_DIR_PATH}'.*//')
 	# update app dir list order (recent used)
 	case "${hit_app_dir_file}" in 
 		"")
			local rga_path1=$(echo "${VALUE[1]}" | sed 's/'${sed_home_path}'/\\$\\{HOME\\}/')
			hit_app_dir_file=$(grep -r "${rga_path1}"  "${CMDCLICK_CONF_DIR_PATH}" | grep "${CH_DIR_PATH}" | sed 's/\:'${CH_DIR_PATH}'.*//')
 			case "${hit_app_dir_file}" in
 				"") 
					local rga_path2=$(echo "${VALUE[1]}"  | sed 's/'${sed_home_path}'/\\$HOME/')
					hit_app_dir_file=$(grep -r "${rga_path1}"  "${CMDCLICK_CONF_DIR_PATH}" | grep "${CH_DIR_PATH}" | sed 's/\:'${CH_DIR_PATH}'.*//')
					;;
			esac
			;;
	esac
	if [ -e "${hit_app_dir_file}" ]; then 
		touch "${hit_app_dir_file}" &
	fi
 	# lecho "status_code: ${status_code}"
 	local return_value=${VALUE[0]}
	INI_FILE_DIR_PATH=${VALUE[1]}
 	case "${status_code}" in 
 		"1") 
			local status_list=($(cat "${CMDCLICK_PASTE_SIGNAL_FILE_PATH}"));
			INI_FILE_DIR_PATH=$(echo ${status_list[2]} | sed -e "s/^'//g" -e "s/'$//g")
			cp /dev/null "${CMDCLICK_PASTE_SIGNAL_FILE_PATH}" &
		;;
	esac
	# lecho "status_list: "${status_list}
	# lecho "ini_file_list: ${ini_file_list}"	
	# lecho "${VALUE[@]}"
	# lecho "INI_FILE_DIR_PATH: ${INI_FILE_DIR_PATH}"
	# lecho "return_value ${return_value}"
	# lecho "$(echo "${return_value}" | rga "${CMDCLICK_EDIT_CMD}")"
	# lecho "echo ${return_value} | grep ${CMDCLICK_EDIT_CMD}"
	# lecho "return_value: ${return_value}"	
	# alter SIGNAL_CODE to return_value 
	#on_sign=$(echo "${return_value}" | grep -o -e "${CMDCLICK_ADD_CMD}" -e "${CMDCLICK_DELETE_CMD}" -e "${CMDCLICK_EDIT_CMD}" -e "${CMDCLICK_CHANGE_DIR_CMD}")
	#echo ${on_sign}
	local cd_dir_on=$(echo "${return_value}" | grep -i "${CMDCLICK_CHANGE_DIR_CMD}")
	# local resolution_on=$(echo "${return_value[@]}" | grep "${CMDCLICK_RESOLUTION_CMD}")
	# lecho "${return_value} grep ${CMDCLICK_CHANGE_DIR_CMD}"
	# lecho "cd_dir_on: ${cd_dir_on}"
	# lecho "add: ${add_on}"
	# lecho "edit_on: ${edit_on}"
	case "${return_value}" in
		"") 
			SIGNAL_CODE=${EXIT_CODE}
			;;
		*)
			if  [ -z "${cd_dir_on}" ] ;then SIGNAL_CODE=${OK_CODE};
			elif [ -n "${cd_dir_on}" ];then SIGNAL_CODE=${CHDIR_CODE};
			elif [ -n "${resolution_on}" ];then SIGNAL_CODE=${RESOLUTION_CODE};
			else SIGNAL_CODE=${INDEX_CODE}; fi
		;;
	esac
	if expr "${status_list[0]}" : "-\?[0-9]\+\.\?[0-9]*$" >&/dev/null;then
		case "${status_list[0]}" in 
			"${EDIT_CODE}") SIGNAL_CODE=${EDIT_CODE} ;;
			"${ADD_CODE}") SIGNAL_CODE=${ADD_CODE} ;;
			"${CHDIR_CODE}") SIGNAL_CODE=${CHDIR_CODE} ;;
			"${RESOLUTION_CODE}") SIGNAL_CODE=${RESOLUTION_CODE} ;;
			"${DELETE_CODE}") SIGNAL_CODE=${DELETE_CODE} ;;
		esac
	fi
	# CODE別処理
	local execute_file_code=0
	EXECUTE_FILE_NAME="${return_value}"
	
	case "${status_code}" in 
		"1") EXECUTE_FILE_NAME=$(echo ${status_list[1]} | sed -e "s/^'//g" -e "s/'$//g") ;; 
	esac
	#設定変数初期化
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