#!/bin/bash

LANG=C
EXECUTE_LIB_DIR_PATH="${LIB_DIR_PATH}/execute_lib"
. "${EXECUTE_LIB_DIR_PATH}/handler.sh"
. "${EXECUTE_LIB_DIR_PATH}/nw_ready_before_open_terminal.sh"
. "${EXECUTE_LIB_DIR_PATH}/get_ccerminal_window.sh"
. "${EXECUTE_LIB_DIR_PATH}/open_new_tab_terminal.sh"
. "${EXECUTE_LIB_DIR_PATH}/execute_before_command.sh"
. "${EXECUTE_LIB_DIR_PATH}/execute_after_command.sh"
unset -v EXECUTE_LIB_DIR_PATH

LOOP=0
EXECUTE_FILE_PATH="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
#設定ファイルチェック
check_ini_file "${EXECUTE_FILE_PATH}"
exec_handler
# echo "BEFORE_EXECUTE setting_variable "
# echo "EXECUTE_COMMAND: ${EXECUTE_COMMAND}"
# echo "EXEC_TERMINAL_ON: ${EXEC_TERMINAL_ON}"
# echo "EXEC_OPEN_WHERE: ${EXEC_OPEN_WHERE}"
# echo "EXEC_TERMINAL_FOCUS: ${EXEC_TERMINAL_FOCUS}"
# echo "EXEC_INPUT_EXECUTE: ${EXEC_INPUT_EXECUTE}"
# echo "EXEC_IN_EXE_DFLT_VL: ${EXEC_IN_EXE_DFLT_VL}"
# echo "EXEC_BEFORE_COMMAND: ${EXEC_BEFORE_COMMAND}"
# echo "EXEC_AFTER_COMMAND: ${EXEC_AFTER_COMMAND}"
# echo "EXECUTE_FILE_PATH: ${EXECUTE_FILE_PATH}"
#ターミナル起動コマンド格納
if [ "${EXEC_TERMINAL_ON}" = "ON" ]; then
	terminal_exec_command="x-terminal-emulator -T \"${CC_TERMINAL_NAME}\" &"
else 
	terminal_exec_command=""
fi

#ターミナル使用時（デフォルト）
case "${EXEC_TERMINAL_ON}" in 
	"ON")
		#コマンド実行前の準備-------------------------------------
		#terminalを開く前の準備（サイズ、タブ、アクティブ化）
		nw_ready_before_open_terminal
		#実行可能なCCerminalを取得、なければ、ターミナルで代用
		ccerminal_window_list=$(get_ccerminal_window)
		current_term_active_cmd="wmctrl -i -a ${ccerminal_window_list}"
		bash -c "${current_term_active_cmd}"
		
		#新しいタブで開く場合	
		open_new_tab_terminal
		#-----------------------------------------------------------------

		#以後、コマンド系----------------------------------------------------
		execute_before_command "${EXEC_BEFORE_COMMAND}" "${ccerminal_window_list}"
		execute_cmd_by_xdotool "${EXECUTE_COMMAND}" "${ccerminal_window_list}"
		execute_after_command "${EXEC_AFTER_COMMAND}" "${ccerminal_window_list}"
		;;
	"OFF")
		bash -c "${EXECUTE_COMMAND} &"
		;;
esac
unset -v ccerminal_window_list
unset -v current_term_active_cmd
unset -v terminal_exec_command
SIGNAL_CODE=${INDEX_CODE}