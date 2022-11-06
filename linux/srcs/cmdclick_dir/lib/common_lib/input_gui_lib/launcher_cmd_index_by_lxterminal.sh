#!/bin/bash



launcher_cmd_index_by_lxterminal(){
	local LANG="ja_JP.UTF-8"
	local ini_file_dir_path=${1}
	local ini_file_list=${2}
	local x_position=${3}
	local y_position=${4}
	local scale_display_width=${5}
	local scale_display_height="${6}"
	local main_list_sh_path=${COMMON_LIB_DIR_PATH}/input_gui_lib/launcher_cmd_index_by_lxterminal_lib/main_list.sh
	[ -f "${HOME}/.fzf.bash" ] && . ${HOME}/.fzf.bash
	lxterminal \
			--title="${WINDOW_TITLE}" \
			-e bash "${main_list_sh_path}" \
						"${ini_file_dir_path}" \
						"${ini_file_list}" \
						"${scale_display_width}" \
			1>/dev/null 2>&1 &
	local lx_terminal_pid=$!
	while true
	do
		sleep 0.05
		local lxwmId=$(\
			wmctrl -lx \
			| grep "lxterminal.Lxterminal" \
			| awk '{print $1}' \
			|| e=$? \
		) 
		case "${lxwmId}" in "");; *) break;; esac 
	done
	wmctrl  -r "${WINDOW_TITLE}" -e 0,${x_position},${y_position},${scale_display_width},${scale_display_height}
	wait "${lx_terminal_pid}"
}

