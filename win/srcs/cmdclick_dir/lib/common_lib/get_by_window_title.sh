#!/bin/bash


get_by_window_title(){
	local target_terminal_name="${1}"
	wmctrl.exe -l \
	| awk \
	-v target_terminal_name="${target_terminal_name}" \
	'{
		if($0 !~ target_terminal_name) next
		if($3 !~ "terminal") next
		print $1
		exit
	}' 
}