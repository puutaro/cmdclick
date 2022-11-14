#!/bin/bash


echo_signal_code_by_input_exec_condition(){
	local exec_edit_execute="${1}"
	case "${exec_edit_execute}" in
		"${ALWAYS_EDIT_EXECUTE}")
			echo ${OK_CODE}
			return
	;; esac
	echo ${INDEX_CODE}
}