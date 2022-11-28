#!/bin/bash


reactive_when_aleady_exist_cmdclick(){
	case "${ACTIVE_CHECK_VARIABLE}" in 
		"0");; *) return ;; esac
			ACTIVE_CHECK_VARIABLE=1
	local reacctive_check=$(\
		ps aux \
			| grep -v " grep " \
			| grep -v "$(date +%H:%M)" \
			| grep "${WINDOW_TITLE}" \
	)
	case "${reacctive_check}" in 
		"") return ;; esac 
	cmd.exe /c start nircmd.exe win activate title "${WINDOW_TITLE}"
	exit 0
}