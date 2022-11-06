#!/bin/bash

nw_ready_before_open_terminal(){
	local terminal_exec_command="${1}"
	local exist_windows_terminal="${2}"
	case "${exist_windows_terminal}" in 
		"");;
		*)  echo "${exist_windows_terminal}"
			return;; esac
	bash -c "${terminal_exec_command}"
	sleep 1
	nircmd.exe elevate cmd /c "nircmd.exe win setsize process ${PASTE_TARGET_TERMINAL_NAME}.exe ${PANAL_WIDTH} ${PANAL_HEIGHT} ${TRUE_RESORUTION_WIDTH} ${TRUE_RESORUTION_HEIGHT}" &
	wait
	sleep 1
	wmctrl.exe -l \
		|  grep -o "${PASTE_TARGET_TERMINAL_NAME}" \
		|| e=$?
}