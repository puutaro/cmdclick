#!/bin/bash


echo_window_localtion(){
	local count_exec_input_execute="${1}"
	case "${count_exec_input_execute}" in 
		"0") 
			echo "--center --width=${CENTER_SCALE_DISPLAY_WIDTH} --height=${CENTER_SCALE_DISPLAY_HEIGHT}"
			;;
		*) echo "--geometry ${RIGHT_SCALE_DISPLAY_WIDTH}x${RIGHT_SCALE_DISPLAY_HEIGHT}+${RIGHT_X_POSITION}+${RIGHT_Y_POSITION}"
			;;
	esac
}