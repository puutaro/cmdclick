#!/bin/bash


MOVE_INI_FILE_GUI_DIR_PATH="${MOVE_LIB_DIR_PATH}/move_ini_file_gui_lib"
. "${MOVE_INI_FILE_GUI_DIR_PATH}/judge_and_exec_move_or_cp.sh"
unset -v MOVE_INI_FILE_GUI_DIR_PATH


move_ini_file_gui(){
	local LANG="ja_JP.UTF-8"
	local move_source_dir_path="${1}"
	local move_source_file_name="${2}"
	local chosen_app_dir="$(\
		choose_app_dir_list_for_move \
	)"
	case "${chosen_app_dir}" in 
		"") return
	;; esac
	judge_and_exec_move_or_cp \
		"${move_source_dir_path}" \
		"${chosen_app_dir}" \
		"${move_source_file_name}"
	upgrade_app_dir_list_order \
		"${chosen_app_dir}"
}