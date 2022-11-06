#!/bin/bash


read_resolution_from_system(){
	local ifs_old=${IFS}
	local IFS=$' ' 
	readonly DISPLAY_RSOLUTION_LIST=(\
		$(\
			xrandr \
			| grep -E '\*' \
			| awk '{print $1}' \
			| sed -e 's|x| |g' \
			|| e=$? \
		) \
	)
	local IFS="${ifs_old}"
	export DISPLAY_RSOLUTION_WIDTH="${DISPLAY_RSOLUTION_LIST[0]}"
	export DISPLAY_RSOLUTION_HEIGHT="${DISPLAY_RSOLUTION_LIST[1]}"
	export CENTER_SCALE_DISPLAY_HEIGHT="$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.1" | bc)"
	export CENTER_SCALE_DISPLAY_WIDTH="$(echo "scale=0; ${DISPLAY_RSOLUTION_WIDTH} / 1.9" | bc)"
}