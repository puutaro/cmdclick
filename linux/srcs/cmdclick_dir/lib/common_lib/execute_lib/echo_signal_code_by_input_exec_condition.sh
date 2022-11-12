#!/bin/bash


echo_signal_code_by_input_exec_condition(){
	if [ "${EXEC_INPUT_EXECUTE}" == "C" ] \
	 && [ "${EXEC_INPUT_EXEC_ROOP_DO}" == "ON" ];then
		echo ${OK_CODE}
		return
	fi
	echo ${INDEX_CODE}
}