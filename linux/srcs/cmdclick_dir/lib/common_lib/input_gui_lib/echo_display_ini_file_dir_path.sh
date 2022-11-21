#!/bin/bash


echo_display_ini_file_dir_path(){
	local normal_signal_code=${1}
	case "${normal_signal_code}" in 
		"${CHDIR_CODE}")
			echo_longpath_by_summraizing \
				"${CMDCLICK_APP_DIR_PATH}"
			;;
		*)
			echo_longpath_by_summraizing \
				"${INI_FILE_DIR_PATH}"
			;;
	esac
}