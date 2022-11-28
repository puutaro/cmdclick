#!/bin/bash


display_continue_wait_dialog(){
	local ctrl_cmd_pid="${1}"
	local display_wait_dialog_cmd="yad \
	--form \
    --title=\"\${WINDOW_TITLE}\" \
    --window-icon=\"\${WINDOW_ICON_PATH}\" \
    --item-separator='!'\
    --center \
    --scroll \
    \${WAIT_WINDOW_LOCATION} \
    --field=\"\n \${wait_message} \n\n\":LBL &"

	eval "${display_wait_dialog_cmd}"
	local wait_display_pid=$!
	while :
	do
		sleep 0.1
		local wait_display_pid=$(\
			ps aux \
			| grep "${WINDOW_TITLE}" \
			| grep -v grep \
			| head -1 \
			| awk '{print $2}'
		)
		case "${wait_display_pid}" in
			"")
				eval "${display_wait_dialog_cmd}"
		;;esac
		local exist_ctrl_cmd_pid=$(\
			ps aux \
				| grep -E "\s${ctrl_cmd_pid}\s" \
				| grep -v grep \
		)
		case "${exist_ctrl_cmd_pid}" in
			"")
				kill "${wait_display_pid}"
				break
		;;esac
	done
}
