#!/bin/bash


resize_max(){
	local scale_display_width=$(echo "scale=0; ${TRUE_DISPLAY_RESOLUTION_LIST[0]} / 3" | bc)
	local scale_display_height=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.2" |bc)
	local x_position=$(\
		echo "scale=0; \
		${DISPLAY_RSOLUTION_WIDTH} - ${scale_display_width}" | bc\
	)
	local y_position=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} - ${scale_display_height} -${WIN_DEPTH}" | bc)
	scale_display_height=$(expr ${scale_display_height} - ${PANAL_HEIGHT})
	y_position=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} - ${scale_display_height} - ${WIN_DEPTH} - ${PANAL_HEIGHT}" | bc)
	echo "${x_position},${y_position},${scale_display_width},${scale_display_height}"
}

