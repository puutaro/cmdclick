#!/bin/bash


resize_max(){
	local scale_display_width=$(echo "scale=0; ${DISPLAY_RSOLUTION_WIDTH} / 3.0" | bc)
	local scale_display_height=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.3" |bc)
	local x_position=$(\
		echo "scale=0; \
		${DISPLAY_RSOLUTION_WIDTH} - ${scale_display_width}" | bc\
	)
	local y_position=$(echo "scale=0; ( ${DISPLAY_RSOLUTION_HEIGHT} - ${scale_display_height} ) / 2" | bc)
	echo "${x_position},${y_position},${scale_display_width},${scale_display_height}"
}

