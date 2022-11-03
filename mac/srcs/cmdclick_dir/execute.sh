#!/bin/bash

LOOP=0
# lecho "BEFORE_EXECUTE SIGNAL_CODE: ${SIGNAL_CODE}"
#シェルファイルから設定を読み込み
EXECUTE_FILE_PATH="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
check_ini_file "${EXECUTE_FILE_PATH}"
# lecho "${EXECUTE_FILE_PATH}"
case "${SIGNAL_CODE}" in
	"${OK_CODE}") 
		touch "${EXECUTE_FILE_PATH}"
		EXEC_INPUT_EXECUTE="$(cat "${EXECUTE_FILE_PATH}" | rga "${INI_INPUT_EXECUTE}=" | sed 's/'${INI_INPUT_EXECUTE}'\=//')"
		case "${EXEC_INPUT_EXECUTE}" in 
			"C")
				center_box &
				EXEC_IN_EXE_DFLT_VL="$(cat "${EXECUTE_FILE_PATH}" | rga "${INI_IN_EXE_DFLT_VL}=" | gsed  -e 's/'${INI_INPUT_EXECUTE}'\=//'  | gsed  -re "s/([a-zA-Z0-9_-]{1,100})=(.*)/\2/" | gsed -e 's/"$//' -e 's/^"//' | tr ',' '\n'  | gsed -e 's/\\$//' -e 's/^\s*//' | gsed  -r "s/(^[a-zA-Z0-9_-]{0,100})(\:CB)=(.*)/ \| gsed 's\/^\1=.*\/\1\2=\3\/'/" | gsed  -r "s/(^[a-zA-Z0-9_-]{0,100})=(.*)/ \| gsed 's\/^\1=.*\/\1=\2\/'/"  | tr -d '\n' | gsed '/^$/d'  | gsed 's/ | sed /\n | sed /g' | rga "[' ]$" | tr -d '\n')"
				# echo "${EXEC_IN_EXE_DFLT_VL}"
				
				edit_ini_gui "${EXECUTE_FILE_NAME}";wait 
				check_ini_file "${EXECUTE_FILE_PATH}"
				;;
			"E")
				center_box &
				EDIT_EDITOR_ON="ON"
				edit_ini_gui "${EXECUTE_FILE_NAME}"; wait 
				check_ini_file "${EXECUTE_FILE_PATH}"
				;;
		esac
		case "${SIGNAL_CODE}" in
			"${OK_CODE}")
			read_ini_to_execute_command "${EXECUTE_FILE_PATH}" ;;
		esac 
		;;
esac
# echo "BEFORE_EXECUTE setting_variable "
# echo "${EXECUTE_COMMAND}"
# echo "${EXEC_TERMINAL_ON}"
# echo "${EXEC_OPEN_WHERE}"
# echo "${EXEC_TERMINAL_SIZE}"
# echo "${EXEC_TERMINAL_FOCUS}"
# echo "${EXEC_INPUT_EXECUTE}"
# echo "${EXEC_IN_EXE_DFLT_VL}"
# echo "${EXEC_BEFORE_COMMAND}"
# echo "${EXEC_AFTER_COMMAND}"
# echo "${EXECUTE_FILE_PATH}"
#ターミナル起動コマンド格納
case "${EXEC_TERMINAL_ON}" in 
	"ON") 
		terminal_exec_command="cmd_click_startup_app ${CMD_CLICK_TARGET_APP} &"
		;;
	*) terminal_exec_command="" ;;
esac

#ターミナルリサイズコマンド格納
case "${EXEC_TERMINAL_SIZE}" in 
	"MAX")
		exec_terminal_size_command="maximize_app ${CMD_CLICK_TARGET_APP}" ;;
	"RMAX")
		exec_terminal_size_command="right_maximize_box ${CMD_CLICK_TARGET_APP}" ;;
	"LMAX")
		exec_terminal_size_command="left_maximize_box ${CMD_CLICK_TARGET_APP}" ;;
esac

# lecho "BEFORE_EXECUTE exec_terminal_size_command: ${exec_terminal_size_command} "

#ターミナル使用時（デフォルト）
case "${EXEC_TERMINAL_ON}" in 
	"ON")
		# コマンド実行前の準備-------------------------------------
		# terminalを開く前の準備（サイズ、タブ、アクティブ化）
		case "${EXEC_OPEN_WHERE}" in 
			"NW") 
				"${terminal_exec_command}"
				wait;;
		esac

		# mac: 速度向上のためオミット(デフォルトでターミナル起動&リサイズ)
		# 対象のターミナルを起動し、リサイズ
		# current_term_active_cmd="cmd_click_startup_app ${CMD_CLICK_TARGET_APP}"
		# lecho "BEFORE_EXECUTE ccerminal_window_list: ${ccerminal_window_list}"
		# eval "${current_term_active_cmd}; ${exec_terminal_size_command}"  
		# 新しいタブで開く場合
		case "${EXEC_OPEN_WHERE}" in 
			"NT") 
				open_where_ntab_command="open_new_tab_cmc ${CMD_CLICK_TARGET_APP}"
				eval "${open_where_ntab_command}"
				wait;;
		esac
		#-----------------------------------------------------------------

		#以後、コマンド系----------------------------------------------------
		# #ディレクトリ移動
		# if [ -d "${EXEC_WORKING_DIRECTORY}" ]; then
		# 	echo "BEFORE_EXECUTE EXEC_WORKING_DIRECTORY: ${EXEC_WORKING_DIRECTORY}"
		# 	cd_work_dir="cd ${EXEC_WORKING_DIRECTORY}"
		# 	current_dir_path=$(pwd)
		# 	execute_cmd_by_xdotool "${cd_work_dir}" "${ccerminal_window_list}"
		# 	wait
		# fi
		#事前コマンド
		case "${EXEC_BEFORE_COMMAND}" in 
			"-"|"") ;;
			*) 
				EXECUTE_COMMAND="eval ${EXEC_BEFORE_COMMAND}; ${EXECUTE_COMMAND}";;
		esac
		#xdotool type "eval \"${EXECUTE_COMMAND}\""; xdotool key Return; wmctrl -i -a ${ccerminal_window_list}
		#実行後コマンド
		case "${EXEC_AFTER_COMMAND}" in 
			"-"|"") ;;
			*) 
				EXECUTE_COMMAND="${EXECUTE_COMMAND}; eval ${EXEC_AFTER_COMMAND}"
		esac
		#実行コマンド（本体）
		execute_cmd_by_xdotool "${EXECUTE_COMMAND}" 
		;;
	"OFF")
		# lecho "TERMINAL_OFF EXEC_TERMINAL_ON: ${EXEC_TERMINAL_ON}"
		${EXECUTE_COMMAND} >/dev/null 2>&1 &
		;;
esac

SIGNAL_CODE=${INDEX_CODE}
# lecho "AFTER_EXECUTE SIGNAL_CODE: ${SIGNAL_CODE}"
