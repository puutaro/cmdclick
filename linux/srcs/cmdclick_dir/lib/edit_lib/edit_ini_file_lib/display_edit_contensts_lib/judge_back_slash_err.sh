#!bin/bash


judge_back_slash_err(){
	local ini_value_source="${1}"
	case "${SIGNAL_CODE}" in
		"${EXIT_CODE}")
			return
			;;
	esac
	local exist_backslash=$(\
	echo "${ini_value_source}" \
		| grep '\\' \
		|| e=$? \
	)
	case "${exist_backslash}" in
		"") return 
			;;
	esac
	set +e
	yad \
		--form \
		--title="${WINDOW_TITLE}" \
		--window-icon="${WINDOW_ICON_PATH}" \
		--text="\nback slash is forbidden  \n" \
		--borders=${CMDCLICK_BORDER_NUM} \
		--center \
		--borders=${CMDCLICK_BORDER_NUM} \
	    --height=${CENTER_SCALE_DISPLAY_HEIGHT} \
	    --width=${CENTER_SCALE_DISPLAY_WIDTH} \
		--button  gtk-ok:${OK_CODE}
	echo $?
	set -e
	ROOP_NUM=2
	SIGNAL_CODE=${EXIT_CODE}
}