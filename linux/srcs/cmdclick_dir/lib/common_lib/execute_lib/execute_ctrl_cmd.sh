#!/bin/bash


execute_ctrl_cmd_lib_path="${EXECUTE_LIB_DIR_PATH}/execute_ctrl_cmd_lib"
. "${execute_ctrl_cmd_lib_path}/display_continue_wait_dialog.sh"
unset -v execute_ctrl_cmd_lib_path


execute_ctrl_cmd(){
	local cmd_source="${1:-}"
	case "${cmd_source}" in
		"") return
	;; esac
	local ctrl_prefix=$(\
		echo "${cmd_source}" \
			| awk \
			-v ALWAYS_EDIT_EXECUTE="${ALWAYS_EDIT_EXECUTE}" \
			-v ONCE_EDIT_EXECUTE="${ONCE_EDIT_EXECUTE}" \
			-v NO_EDIT_EXECUTE="${NO_EDIT_EXECUTE}" \
			'{
				gsub(/^\x22*/, "", $0)
				gsub(/\x22*$/, "", $0)
				if ($0 ~ "^"ALWAYS_EDIT_EXECUTE) print ALWAYS_EDIT_EXECUTE
				else if ($0 ~ "^"ONCE_EDIT_EXECUTE) print ONCE_EDIT_EXECUTE
				else if ($0 ~ "^"NO_EDIT_EXECUTE) print NO_EDIT_EXECUTE
			}'\
	)
	local cmd=$(\
		echo "${cmd_source}" \
			| awk \
			-v ctrl_prefix="${ctrl_prefix}" \
			'{
				gsub(/^\x22*/, "", $0)
				gsub(/\x22*$/, "", $0)
				sub("^"ctrl_prefix, "", $0)
				if($0 !~ /^$/) print $0
			}'\
	)
	case "${ctrl_prefix}" in
		"${EXEC_EDIT_EXECUTE}"|"") ;;
		*) return;;
	esac
	case "${cmd}" in
		""|"-") return
	;; esac
	local ECEC_CTRL_CMD_WAIT_WINDOW_LOCATION="--center --width=${CENTER_SCALE_DISPLAY_WIDTH} --height=${CENTER_SCALE_DISPLAY_HEIGHT}"
	local WAIT_WINDOW_LOCATION="--geometry ${RIGHT_SCALE_DISPLAY_WIDTH}x${RIGHT_SCALE_DISPLAY_HEIGHT}+${RIGHT_X_POSITION}+${RIGHT_Y_POSITION}"
	local wait_message="please wait ctrl cmd finished"
	bash -c "${cmd}" &
	local ctrl_cmd_pid=$!
	display_continue_wait_dialog \
		"${ctrl_cmd_pid}"
}
