#!/bin/bash


echo_signal_code_by_input_exec_condition(){
	case "${EXEC_EDIT_EXECUTE}" in
		"${ALWAYS_EDIT_EXECUTE}")
			echo ${OK_CODE}
			return
	;; esac
	echo ${INDEX_CODE}
}