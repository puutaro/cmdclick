#!/bin/bash


echo_ch_dir_path_parameter_if_chdir_first_roop(){
	local chdir_signal_code="${1}"
	local roop_num="${2}"
	local ini_contents_moto="${3}"
	local ch_dir_path_parameter_before="${4}"
	if [ ! ${chdir_signal_code} -eq ${EDIT_CODE} ] \
      || [ ! ${roop_num} -eq 1 ]; then 
      	echo "${ch_dir_path_parameter_before}"
      	return 
    fi
	fetch_parameter \
		"${ini_contents_moto}" \
		"${CH_DIR_PATH}" \
	| echo_removed_double_quote_both_ends_from_pip
}