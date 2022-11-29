#!/bin/bash

LANG=C
LINUX_EXECUTE_LIB_DIR_PATH="${LIB_DIR_PATH}/execute_lib"
EXECUTE_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/execute_lib"
. "${LINUX_EXECUTE_LIB_DIR_PATH}/get_ccerminal_window.sh"
. "${LINUX_EXECUTE_LIB_DIR_PATH}/open_new_tab_terminal.sh"
. "${LINUX_EXECUTE_LIB_DIR_PATH}/execute_before_command.sh"
. "${LINUX_EXECUTE_LIB_DIR_PATH}/execute_after_command.sh"
. "${EXECUTE_LIB_DIR_PATH}/execute_ctrl_cmd.sh"
. "${EXECUTE_LIB_DIR_PATH}/handler.sh"
. "${EXECUTE_LIB_DIR_PATH}/echo_signal_code_by_input_exec_condition.sh"
unset -v EXECUTE_LIB_DIR_PATH
unset -v LINUX_EXECUTE_LIB_DIR_PATH


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
	# echo "EXEC_BEFORE_CTRL_CMD: ${EXEC_BEFORE_CTRL_CMD}"
	# echo "EXEC_AFTER_CTRL_CMD: ${EXEC_AFTER_CTRL_CMD}"
	# echo "EXECUTE_FILE_PATH: ${EXECUTE_FILE_PATH}"
	# echo "EXEC_SHELL_ARGS ${EXEC_SHELL_ARGS}"
	#ターミナル起動コマンド格納
	if [ "${EXEC_TERMINAL_ON}" = "ON" ]; then
		terminal_exec_command="LANG=\"ja_JP.UTF-8\"; . \"${HOME}/profile\"; x-terminal-emulator -T \"${CC_TERMINAL_NAME}\" &"
	else 
		terminal_exec_command=""
	fi

	#ターミナル使用時（デフォルト）
	case "${EXEC_TERMINAL_ON}" in 
		"ON")
			#コマンド実行前の準備-------------------------------------
			#実行可能なCCerminalを取得、なければ、ターミナルで代用
			ccerminal_window_list=""
			get_ccerminal_window
			wmctrl -i -a ${ccerminal_window_list}

			#新しいタブで開く場合	
			open_new_tab_terminal
			#-----------------------------------------------------------------

			#以後、コマンド系----------------------------------------------------
			execute_ctrl_cmd \
				"${EXEC_BEFORE_CTRL_CMD}"
			execute_before_command \
				"${EXEC_BEFORE_COMMAND}" \
				"${ccerminal_window_list}"
			execute_cmd_by_xdotool \
				"${EXECUTE_COMMAND}" \
				"${ccerminal_window_list}"
			execute_after_command \
				"${EXEC_AFTER_COMMAND}" \
				"${ccerminal_window_list}"
			execute_ctrl_cmd \
				"${EXEC_AFTER_CTRL_CMD}"
			;;
		"OFF")
			bash -c "${EXECUTE_COMMAND}" ${EXEC_SHELL_ARGS} &
			;;
	esac
	unset -v ccerminal_window_list
	unset -v terminal_exec_command
	SIGNAL_CODE=$(\
		echo_signal_code_by_input_exec_condition \
			"${EXEC_EDIT_EXECUTE}" \
			"${EXEC_SET_VARIABLE_TYPE}" \
	)
}

command_execute
