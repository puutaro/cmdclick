#!/bin/bash


install_ini_file_gui_lib_dir_path="${INSTALL_LIB_DIR_PATH}/install_ini_file_gui_lib"
. "${install_ini_file_gui_lib_dir_path}/display_file_select_manager.sh"
unset -v install_ini_file_gui_lib_dir_path


install_ini_file_gui(){
	local LANG="ja_JP.UTF-8"
	local install_file_path_con=$(\
		display_file_select_manager \
	)
	case "${install_file_path_con}" in
		"") return ;; esac
	local chosen_app_dir_path="$(\
		choose_app_dir_list_for_move \
	)"
	case "${chosen_app_dir_path}" in
		"") return ;; esac
	local install_file_path_cmd="$(\
		echo "${install_file_path_con}" \
		| sed -r 's/(.*)/cp -f "\1" "'${chosen_app_dir_path//\//\\\/}'\/"/' \
	)"
	bash -c "${install_file_path_cmd}"
}