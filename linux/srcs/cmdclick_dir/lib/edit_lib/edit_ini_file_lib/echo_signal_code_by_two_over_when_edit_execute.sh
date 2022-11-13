#!/bin/bash


echo_signal_code_by_two_over_when_edit_execute(){
	local exec_edit_execute="${1}"
	local roop_num="${2}"
	local two_edit_roop_num=2
	if [ ${roop_num} -ge ${two_edit_roop_num} ] \
		&& [ "${exec_edit_execute}" == "${ALWAYS_EDIT_EXECUTE}" ];then
			echo "${EDIT_CODE}"
			return
	fi
	echo "${OK_CODE}"
}