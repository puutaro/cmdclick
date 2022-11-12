#!/bin/bash


echo_count_exec_input_execute_by_input_exec_save_val_do(){
	local count_exec_input_execute="${1}"
	EXEC_INPUT_EXEC_DFLT_SAVE_DO="$(\
		cat "${EXECUTE_FILE_PATH}" \
		| fetch_parameter_from_pip "${INI_INPUT_EXEC_DFLT_SAVE_DO}"\
	)"
	case "${EXEC_INPUT_EXEC_DFLT_SAVE_DO}" in 
		"OFF") 
			echo $(( ${count_exec_input_execute} + 1 ))
			return
			;;
	esac
	local do_by_save_val_times=2
	local do_by_input_exec_default_val_times=1
	case "${count_exec_input_execute}" in
		"${do_by_input_exec_default_val_times}")
			echo "${do_by_save_val_times}"
	;;esac
	
}