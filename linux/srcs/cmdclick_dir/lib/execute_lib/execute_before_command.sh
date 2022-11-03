#!/bin/bash

execute_before_command(){
	local exec_before_command="${1}"
	local ccerminal_window_list="${2}"
	if [ "${exec_before_command}" == "-" ] || [ -z "${exec_before_command}" ]; then
		return
	fi
	execute_cmd_by_xdotool "${exec_before_command}" "${ccerminal_window_list}" 
}
