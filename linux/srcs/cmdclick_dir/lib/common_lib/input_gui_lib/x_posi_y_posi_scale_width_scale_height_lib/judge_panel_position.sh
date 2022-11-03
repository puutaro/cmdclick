#!/bin/bash

judge_panel_position(){
	local xwin_info="${1}"
	local panel_width="${2}"
	local panel_height="${3}"
	local IFS="${ifs_old}"
	local IFS=$'\n' 
	local panel_absolute_upper_left=($(echo "${xwin_info}" | rga -e 'Absolute upper-left X' -e 'Absolute upper-left Y' | sed "s|[^0-9]||g"))
	local IFS="${ifs_old}"
	if [ ${panel_width} -ge ${panel_height} ] && [ ${panel_absolute_upper_left[1]} -eq 0 ]; then
		echo "t"
	elif [ ${panel_width} -le ${panel_height} ] && [ ${panel_absolute_upper_left[0]} -eq 0 ] && [ ${panel_absolute_upper_left[1]} -eq 0 ]; then
		echo "l"
	elif [ ${panel_width} -ge ${panel_height} ] && [ ${panel_absolute_upper_left[0]} -ge 0 ]  && [ ${panel_absolute_upper_left[1]} -ge  100 ]; then
		echo "b"
	fi
}