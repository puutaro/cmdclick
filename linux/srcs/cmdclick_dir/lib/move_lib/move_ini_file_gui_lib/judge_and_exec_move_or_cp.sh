#!/bin/bash

judge_and_exec_move_or_cp(){
	local LANG="ja_JP.UTF-8"
	local move_source_dir_path="${1}"
	local chosen_app_dir="${2}"
	local move_source_file_name="${3}"
	case "${chosen_app_dir}" in 
		"${move_source_dir_path}") 
			cp "${move_source_dir_path}/${move_source_file_name}" \
				"${move_source_dir_path}/$(( ${RANDOM} % 10000 ))_cp_${move_source_file_name}";;
		*) 
			mv "${move_source_dir_path}/${move_source_file_name}" \
				"${chosen_app_dir}/${move_source_file_name}"
			;;
	esac
}