#!/bin/bash


switch_cmdclick_or_app_mode(){
	local app_file_path_source="${1:-}"
	if [ -e "${app_file_path_source}" ];then
		local app_file_path="${app_file_path_source}"
	else
		local app_file_path=""
	fi
	case "${app_file_path}" in
		"") 
			readonly WINDOW_TITLE="${CMDCLICK_WINDOW_TITLE}"
			SIGNAL_CODE=${INDEX_CODE}
			NORMAL_SIGNAL_CODE=${INDEX_CODE}
			;;
		*)
			local cur_file_name=$(basename "${app_file_path}")
			local cur_dir_name=$(dirname "${app_file_path}")
			readonly WINDOW_TITLE="$(basename "${cur_file_name%${COMMAND_CLICK_EXTENSION}}")"
			EXEC_EDIT_EXECUTE="${ALWAYS_EDIT_EXECUTE}"
			SIGNAL_CODE=${OK_CODE}
			NORMAL_SIGNAL_CODE=${OK_CODE}
			EXECUTE_FILE_NAME="${cur_file_name}"
			INI_FILE_DIR_PATH="${cur_dir_name}"
	;; esac
}