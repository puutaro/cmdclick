#!/bin/bash


switch_cmdclick_or_app_mode(){
	local LANG="ja_JP.UTF-8"
	local app_file_path_source="${1:-}"
	if [ -e "${app_file_path_source}" ];then
		local app_file_path="${app_file_path_source}"
	else
		local app_file_path=""
	fi
	case "${app_file_path}" in
		"") 
			readonly WINDOW_TITLE="${CMDCLICK_WINDOW_TITLE}"
			readonly WINDOW_ICON_PATH="${CMDCLICK_WINDOW_ICON_PATH}"
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
			local window_icon_path_source=$(\
				cat "${app_file_path}" \
				| fetch_parameter_from_pip \
					"${INI_APP_ICON_PATH}" \
				| echo_removed_double_quote_both_ends_from_pip \
			)
			window_icon_path_source=$(eval "echo ${window_icon_path_source}")
			if [ -n "${window_icon_path_source}" ] \
				&& [ -e "${window_icon_path_source}" ];then
				readonly WINDOW_ICON_PATH="${window_icon_path_source}"
			else
				readonly WINDOW_ICON_PATH="${CMDCLICK_WINDOW_ICON_PATH}"
			fi
	;; esac
}
