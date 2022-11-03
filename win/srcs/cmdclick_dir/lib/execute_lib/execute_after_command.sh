#!/bin/bash

execute_after_command(){
	local exec_after_command="${1}"
	local ccerminal_acctive_state="${2}"
	if [ "${exec_after_command}" == "-" ] || [ -z "${exec_after_command}" ]; then
		return
	fi
	execute_cmd_by_xdotool \
		"${exec_after_command}" \
		"${ccerminal_acctive_state}"
}
