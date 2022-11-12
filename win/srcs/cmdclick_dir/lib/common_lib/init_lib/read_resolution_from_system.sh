#!/bin/bash



read_resolution_from_system(){
	local ifs_old=${IFS}
	local IFS=$'\n' 
	readonly DISPLAY_INFO_LIST=($(\
		powershell.exe -c "\
		Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Screen]::PrimaryScreen" \
	 	| awk '($0 ~ "WorkingArea"){
		 	gsub(/[{}]/, "", $3)
		 	gsub(",", "\n", $3);
		 	sub("^[^=]*=", "", $3)
		 	gsub("\n[^=]*=", "\n", $3)
		 	gsub(/[^0-9\n]/, "", $3)
		 	print $3
		 }'
	))
	IFS="${ifs_old}"
	PANAL_WIDTH="${DISPLAY_INFO_LIST[0]}"
	PANAL_HEIGHT="${DISPLAY_INFO_LIST[1]}"
	TRUE_RESORUTION_WIDTH=${DISPLAY_INFO_LIST[2]}
	TRUE_RESORUTION_HEIGHT=${DISPLAY_INFO_LIST[3]}
	DISPLAY_RSOLUTION_WIDTH=$(( ${DISPLAY_INFO_LIST[2]} + ${PANAL_WIDTH} ))
	DISPLAY_RSOLUTION_HEIGHT=$(( ${DISPLAY_INFO_LIST[3]} + ${PANAL_HEIGHT} ))
	CENTER_SCALE_DISPLAY_HEIGHT="$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.1" | bc)"
	CENTER_SCALE_DISPLAY_WIDTH="$(echo "scale=0; ${DISPLAY_RSOLUTION_WIDTH} / 1.9" | bc)"
	local true_display_resolution_width="${DISPLAY_RSOLUTION_WIDTH}"
	local true_display_resolution_height=$(\
			expr ${DISPLAY_RSOLUTION_HEIGHT} - ${PANAL_HEIGHT}\
		)
	CENTER_X_POSITION="$(echo "scale=0; (${true_display_resolution_width} - ${CENTER_SCALE_DISPLAY_WIDTH}) / 2" | bc)"
	CENTER_Y_POSITION="$(echo "scale=0; (${DISPLAY_RSOLUTION_HEIGHT} - ${CENTER_SCALE_DISPLAY_HEIGHT}) / 2" | bc)"


	RIGHT_SCALE_DISPLAY_WIDTH=$(echo "scale=0; ${true_display_resolution_width} / 3" | bc)
	RIGHT_SCALE_DISPLAY_HEIGHT=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.2  - ${PANAL_HEIGHT}" |bc)
	
	RIGHT_X_POSITION=$(\
		echo "scale=0; \
		${DISPLAY_RSOLUTION_WIDTH} - ${RIGHT_SCALE_DISPLAY_WIDTH}" | bc\
	)
	RIGHT_Y_POSITION=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} - ${RIGHT_SCALE_DISPLAY_HEIGHT} - ${PANAL_HEIGHT}" | bc)
}