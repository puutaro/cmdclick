#!/bin/bash


echo_window_width(){
	local count_exec_input_execute="${1}"
	case "${count_exec_input_execute}" in 
		"0") 
			echo "${CENTER_SCALE_DISPLAY_WIDTH}"
			;;
		*) echo "${RIGHT_SCALE_DISPLAY_WIDTH}"
			;;
	esac
}