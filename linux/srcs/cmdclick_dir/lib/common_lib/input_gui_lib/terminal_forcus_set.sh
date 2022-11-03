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
			sleep 1 && wmctrl -r "${WINDOW_TITLE}" -b toggle,hidden &
			return
			;;
		*) return
	;; esac
	local ccerminal_window_list=$(\
		get_by_window_title \
			"${CC_TERMINAL_NAME}" \
	)
	if [ -z "${ccerminal_window_list}" ]; then
		ccerminal_window_list=$(\
			get_by_window_title \
				"terminal"\
		)
	fi
	test -z "${ccerminal_window_list}" && return
	sleep 0.5 && wmctrl -i -a "${ccerminal_window_list}" &
}

