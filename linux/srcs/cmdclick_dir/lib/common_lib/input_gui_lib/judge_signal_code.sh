#!/bin/bash


judge_signal_code(){
	local return_status="${1}"
	if ! expr "${return_status}" + 1 : "[0-9]*$" >&/dev/null; then
		echo "${EXIT_CODE}"
		return
	fi 
	case "${return_status}" in 
		"${OK_CODE}") echo ${OK_CODE} ;;
		"${EDIT_CODE}") echo ${EDIT_CODE} ;;
		"${DESCRIPTION_EDIT_CODE}")  echo ${DESCRIPTION_EDIT_CODE} ;;
		"${ADD_CODE}") echo ${ADD_CODE} ;;
		"${CHDIR_CODE}") echo ${CHDIR_CODE} ;;
		"${RESOLUTION_CODE:-}") echo ${RESOLUTION_CODE} ;;
		"${DELETE_CODE}") echo ${DELETE_CODE} ;;
		"${MOVE_CODE}") echo ${MOVE_CODE} ;;
		"${INSTALL_CODE}") echo ${INSTALL_CODE} ;;
		"${SETTING_CODE}") echo ${SETTING_CODE} ;;
	esac
}