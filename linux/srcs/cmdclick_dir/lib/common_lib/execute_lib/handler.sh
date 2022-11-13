#!/bin/bash

HANDLER_LIB_DIR_PATH="${EXECUTE_LIB_DIR_PATH}/handler_lib"
. "${HANDLER_LIB_DIR_PATH}/read_ini_to_cmd.sh"
. "${HANDLER_LIB_DIR_PATH}/echo_window_localtion.sh"

unset -v HANDLER_LIB_DIR_PATH


exec_handler(){
	case "${SIGNAL_CODE}" in
	"${OK_CODE}") ;;
	*) return ;; esac
	#設定ファイルからコマンドを製造
	touch "${EXECUTE_FILE_PATH}" &
	EXEC_INPUT_EXECUTE="$(cat "${EXECUTE_FILE_PATH}" | fetch_parameter_from_pip "${INI_EDIT_EXECUTE}")"
	case "${EXEC_INPUT_EXECUTE}" in 
		"C")
			EDIT_WINDOW_LOCATION="$(\
				echo_window_localtion \
					"${COUNT_EXEC_INPUT_EXECUTE}" \
			)"
			COUNT_EXEC_INPUT_EXECUTE=$(( ${COUNT_EXEC_INPUT_EXECUTE} + 1))
			edit_ini_gui \
				"${EXECUTE_FILE_NAME}" \
				"${EXEC_INPUT_EXECUTE}"
			wait 
			check_ini_file "${EXECUTE_FILE_PATH}"
			;;
	esac
	case "${SIGNAL_CODE}" in
		"${OK_CODE}")
			read_ini_to_execute_command "${EXECUTE_FILE_PATH}" 
			return
		;;
	esac 
}