#!/bin/bash

nw_ready_before_open_terminal(){
	case "${EXEC_OPEN_WHERE}" in 
		"NW");;
		*) return;; esac
	bash -c "${terminal_exec_command}"
	sleep 0.5
	wait
}