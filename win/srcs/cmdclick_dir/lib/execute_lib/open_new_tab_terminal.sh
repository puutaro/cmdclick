#!/bin/bash

open_new_tab_terminal(){
	case "${EXEC_OPEN_WHERE}" in 
			"NT");; *) return;; esac
	local open_where_ntab_command="nircmd.exe elevate cmd /c \"wmctrl -a WindowsTerminal & nircmd.exe sendkeypress ctrl+shift+t\""
	bash -c "${open_where_ntab_command}"
	sleep 1
}
