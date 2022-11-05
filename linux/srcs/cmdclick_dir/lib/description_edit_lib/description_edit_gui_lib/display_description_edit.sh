#!/bin/bash


display_description_edit(){
	local desctiption_before_edit="${1}"
	local guid_sentence="\n please edit bellow description\n"
	local through_signal=1
	set +e
	local desctiption_after_edit=$(\
		yad \
			--form \
		    --title="${WINDOW_TITLE}" \
		    --window-icon="${WINDOW_ICON_PATH}" \
		    --item-separator=''\
		    --center \
		    --scroll \
		    --height=${CENTER_SCALE_DISPLAY_HEIGHT} \
		    --width=${CENTER_SCALE_DISPLAY_WIDTH} \
		    --field="${guid_sentence}":TXT "${desctiption_before_edit}" \
		|| echo ${through_signal}
	)
	set -e
	case "${desctiption_after_edit}" in 
		"1") 
			echo ${desctiption_after_edit} 
			return
	;;esac
	echo "${desctiption_after_edit}" \
		| sed -e 's/\\n/\n/g' \
			-e 's/|//g' \
			-e 's/^\s*/\n/g' \
			-e 's/\n\s*/\n/g'  \
			-e 's/\n\s*$/\n/g'
}