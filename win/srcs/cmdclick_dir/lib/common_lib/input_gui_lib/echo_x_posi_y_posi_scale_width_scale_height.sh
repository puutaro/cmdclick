#!/bin/bash


echo_x_posi_y_posi_scale_width_scale_height(){
	case "${EXECUTE_COMMAND}" in 
		"")
			echo "${CENTER_X_POSITION},${CENTER_Y_POSITION},${CENTER_SCALE_DISPLAY_WIDTH},${CENTER_SCALE_DISPLAY_HEIGHT}"
			;;
		*)
			echo "${RIGHT_X_POSITION},${RIGHT_Y_POSITION},${RIGHT_SCALE_DISPLAY_HEIGHT},${RIGHT_SCALE_DISPLAY_HEIGHT}"
		;;
	esac
}