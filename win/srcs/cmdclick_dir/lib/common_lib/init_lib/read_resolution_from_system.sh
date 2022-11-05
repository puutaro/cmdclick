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
	export DISPLAY_RSOLUTION_WIDTH=$(( ${DISPLAY_INFO_LIST[2]} + ${PANAL_WIDTH} ))
	export DISPLAY_RSOLUTION_HEIGHT=$(( ${DISPLAY_INFO_LIST[3]} + ${PANAL_HEIGHT} ))
	export CENTER_SCALE_DISPLAY_HEIGHT="$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.1" | bc)"
	export CENTER_SCALE_DISPLAY_WIDTH="$(echo "scale=0; ${DISPLAY_RSOLUTION_WIDTH} / 1.9" | bc)"
}