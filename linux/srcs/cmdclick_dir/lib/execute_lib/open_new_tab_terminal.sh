#!/bin/bash

open_new_tab_terminal(){
	case "${EXEC_OPEN_WHERE}" in 
			"NT");; *) return;; esac
	local open_where_ntab_command="xdotool key ctrl+shift+t"
	bash -c "${open_where_ntab_command}"
}
