#!/bin/bash

LANG=C

WIN_EXECUTE_LIB_DIR_PATH="${WIN_LIB_DIR_PATH}/execute_lib"
. "${WIN_EXECUTE_LIB_DIR_PATH}/open_new_tab_terminal.sh"
. "${WIN_EXECUTE_LIB_DIR_PATH}/nw_ready_before_open_terminal.sh"
. "${WIN_EXECUTE_LIB_DIR_PATH}/execute_before_command.sh"
. "${WIN_EXECUTE_LIB_DIR_PATH}/execute_after_command.sh"
EXECUTE_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/execute_lib"
. "${EXECUTE_LIB_DIR_PATH}/echo_signal_code_by_input_exec_condition.sh"
. "${EXECUTE_LIB_DIR_PATH}/handler.sh"
unset -v WIN_EXECUTE_LIB_DIR_PATH
unset -v EXECUTE_LIB_DIR_PATH


command_execute(){
	LOOP=0
	EXECUTE_FILE_PATH="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
	#設定ファイルチェック
	check_ini_file "${EXECUTE_FILE_PATH}"
	EDIT_WINDOW_LOCATION=""
	exec_handler
	case "${SIGNAL_CODE}" in
		"${OK_CODE}") 
			;;
		"${EDIT_CODE}")
			SIGNAL_CODE="${OK_CODE}"
			return
			;;
		*) 
			SIGNAL_CODE="${INDEX_CODE}"
			return
			;;
	esac 
	# echo "BEFORE_EXECUTE setting_variable "
	# echo "EXECUTE_COMMAND: ${EXECUTE_COMMAND}"
	# echo "EXEC_TERMINAL_ON: ${EXEC_TERMINAL_ON}"
	# echo "EXEC_OPEN_WHERE: ${EXEC_OPEN_WHERE}"
	# echo "EXEC_TERMINAL_FOCUS: ${EXEC_TERMINAL_FOCUS}"
	# echo "EXEC_EDIT_EXECUTE: ${EXEC_EDIT_EXECUTE}"
	# echo "EXEC_SET_VARIABLE_TYPE: ${EXEC_SET_VARIABLE_TYPE}"
	# echo "EXEC_BEFORE_COMMAND: ${EXEC_BEFORE_COMMAND}"
	# echo "EXEC_AFTER_COMMAND: ${EXEC_AFTER_COMMAND}"
	# echo "EXECUTE_FILE_PATH: ${EXECUTE_FILE_PATH}"
	#ターミナル起動コマンド格納
	if [ "${EXEC_TERMINAL_ON}" = "ON" ]; then
		terminal_exec_command="nircmd.exe elevate cmd /c \"start ${START_EXE_NAME}.exe\""
	else 
		terminal_exec_command=""
	fi

	#ターミナル使用時（デフォルト）
	case "${EXEC_TERMINAL_ON}" in 
		"ON")
			ccerminal_acctive_state=$(\
				wmctrl.exe -l \
				| grep -o "${PASTE_TARGET_TERMINAL_NAME}" \
				|| e=$? \
			)
			#コマンド実行前の準備-------------------------------------
			ccerminal_acctive_state=$(\
				nw_ready_before_open_terminal \
					"${terminal_exec_command}" \
					"${ccerminal_acctive_state}" \
			)
			unset -v current_term_active_cmd
			#新しいタブで開く場合
			open_new_tab_terminal
			#-----------------------------------------------------------------

			#以後、コマンド系----------------------------------------------------
			execute_before_command \
				"${EXEC_BEFORE_COMMAND}" \
				"${ccerminal_acctive_state}"
			execute_cmd_by_xdotool \
				"${EXECUTE_COMMAND}" \
				"${ccerminal_acctive_state}"
			execute_after_command \
				"${EXEC_AFTER_COMMAND}" \
				"${ccerminal_acctive_state}"
			unset -v ccerminal_acctive_state
			;;
		"OFF")
			bash -c "${EXECUTE_COMMAND} &"
			;;
	esac
	unset -v terminal_exec_command
	SIGNAL_CODE=${INDEX_CODE}
	SIGNAL_CODE=$(\
		echo_signal_code_by_input_exec_condition \
			"${EXEC_EDIT_EXECUTE}" \
	)
}

command_execute