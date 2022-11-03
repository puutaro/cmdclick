#!/bin/bash

exec_handler(){
	case "${SIGNAL_CODE}" in
	"${OK_CODE}") ;;
	*) return ;; esac
	#設定ファイルからコマンドを製造
	touch "${EXECUTE_FILE_PATH}" &
	EXEC_INPUT_EXECUTE="$(cat "${EXECUTE_FILE_PATH}" | rga "${INI_INPUT_EXECUTE}=" | sed 's/'${INI_INPUT_EXECUTE}'\=//')"
	case "${EXEC_INPUT_EXECUTE}" in 
		"C")
			cat "${EXECUTE_FILE_PATH}" | rga "${INI_IN_EXE_DFLT_VL}="
			echo --
			EXEC_IN_EXE_DFLT_VL="$(cat "${EXECUTE_FILE_PATH}" | rga "${INI_IN_EXE_DFLT_VL}=" | sed  -e 's/'${INI_INPUT_EXECUTE}'\=//'  | sed  -re "s/([a-zA-Z0-9_-]{1,100})=(.*)/\2/" | sed -e 's/"$//' -e 's/^"//' | tr ',' '\n'  | sed -e 's/\\$//' -e 's/^\s*//' | sed  -r "s/(^[a-zA-Z0-9_-]{0,100})(\:CB)=(.*)/ \| sed 's\/^\1=.*\/\1\2=\3\/'/" | sed  -r "s/(^[a-zA-Z0-9_-]{0,100})=(.*)/ \| sed 's\/^\1=.*\/\1=\2\/'/"  | tr -d '\n' | sed '/^$/d'  | sed 's/ | sed /\n | sed /g' | rga "[' ]$" | tr -d '\n')"
			echo EXEC_IN_EXE_DFLT_VL ${EXEC_IN_EXE_DFLT_VL}
			# ref:edit_lib/make_ini_contents.sh
			edit_ini_gui "${EXECUTE_FILE_NAME}" "${CMDCLICK_INPUT_EXEC_ON}" ;wait 
			check_ini_file "${EXECUTE_FILE_PATH}"
			;;
		"E")
			EDIT_EDITOR_ON="ON"
			edit_ini_gui "${EXECUTE_FILE_NAME}"; wait 
			check_ini_file "${EXECUTE_FILE_PATH}"
			echo SIGNAL_CODE ${SIGNAL_CODE}
			# EXEC_INPUT_EXECUTE_SIGNAL 
			# ref:cmdclick_dir/lib/edit_lib/edit_function.sh
			SIGNAL_CODE=${EXEC_INPUT_EXECUTE_SIGNAL}
			;;
	esac
	case "${SIGNAL_CODE}" in
		"${OK_CODE}")
			read_ini_to_execute_command "${EXECUTE_FILE_PATH}" ;;
	esac 
}