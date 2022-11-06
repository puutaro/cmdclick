#!/bin/bash

reactive_when_aleady_exist_cmdclick(){
	case "${ACTIVE_CHECK_VARIABLE}" in 
		"0");; *) return ;; esac
			ACTIVE_CHECK_VARIABLE=1
	local reacctive_check=$(wmctrl -l | rga "${WINDOW_TITLE}")
	case "${reacctive_check}" in 
		"") return ;; esac 
	wmctrl -a "${WINDOW_TITLE}"
	exit 0
}