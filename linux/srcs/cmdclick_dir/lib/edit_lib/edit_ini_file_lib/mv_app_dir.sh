#!/bin/bash

mv_app_dir(){
	local chdir_signal_code="${1}"
	local ini_contents_moto="${2}"
	local ch_dir_path_parameter_before="${3}"
	if [ ! ${chdir_signal_code} -eq ${EDIT_CODE} ] ; then 
      	echo ""
      	return 
    fi
	local ch_dir_path_parameter_after="$(\
		fetch_parameter \
			"${ini_contents_moto}" \
			"${CH_DIR_PATH}" \
		| echo_removed_double_quote_both_ends_from_pip \
	)"
	case "${ch_dir_path_parameter_after}" in 
		"${ch_dir_path_parameter_before}")
			return ;; esac
	mv "${ch_dir_path_parameter_before}" \
		"${ch_dir_path_parameter_after}" 
}