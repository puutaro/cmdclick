#!/bin/bash

judge_panel_position(){
	local panel_width="${1}"
	if [ ${PANAL_WIDTH} -gt 0 ]; then
		echo "l"
	else
		echo "b"
	fi
}