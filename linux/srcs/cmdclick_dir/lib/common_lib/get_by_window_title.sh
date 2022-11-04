#!/bin/bash


get_by_window_title(){
	local target_terminal_name="${1}"
	wmctrl -lx \
	| awk \
	-v target_terminal_name="${target_terminal_name}" \
	-v PASTE_TARGET_TERMINAL_NAME="${PASTE_TARGET_TERMINAL_NAME}" \
	'{
		if($0 !~ target_terminal_name) next
		if($3 !~ PASTE_TARGET_TERMINAL_NAME) next
		print $1
		exit
	}' 
}