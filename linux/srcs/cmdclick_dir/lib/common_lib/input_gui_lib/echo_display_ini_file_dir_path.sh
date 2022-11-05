#!/bin/bash


echo_display_ini_file_dir_path(){
	local normal_signal_code=${1}
	case "${normal_signal_code}" in 
		"${CHDIR_CODE}")
			replace_home_dir_path_by_tilde \
				"${CMDCLICK_APP_DIR_PATH}"
			;;
		*)
			replace_home_dir_path_by_tilde \
				"${INI_FILE_DIR_PATH}"
			;;
	esac
}