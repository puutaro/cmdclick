#!/bin/bash


terminal_forcus_set(){
	local execute_cmd="${1}"
	case "${execute_cmd}" in 
		"") return;; *) ;; esac
	exec_terminal_forcus_set
}

exec_terminal_forcus_set(){
	case "${EXEC_TERMINAL_FOCUS}" in
		""|"OFF") return ;; esac
	case "${EXEC_TERMINAL_ON}" in
		"ON") ;; 
		"OFF")
			sleep 1 &&  nircmd.exe win hide  title "${WINDOW_TITLE}"
			return
			;;
		*) return
	;; esac
	sleep 2 && cmd.exe /c start wmctrl.exe -a "${PASTE_TARGET_TERMINAL_NAME}"
}

