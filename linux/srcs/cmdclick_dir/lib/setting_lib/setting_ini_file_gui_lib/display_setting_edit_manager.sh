#!/bin/bash


display_setting_edit_manager(){
	local setting_con="${1}"
	local setting_edit_message="\n please set value\n\n"
	set +e
	SETTING_VALUE=$(\
		LANG="ja_JP.UTF-8" yad --form \
		--title="${WINDOW_TITLE}" \
		--window-icon="${WINDOW_ICON_PATH}" \
		--text="${setting_edit_message}" \
		--separator=$'\t' --item-separator="!" \
		--center \
		--scroll \
		--height=${CENTER_SCALE_DISPLAY_HEIGHT} \
		--width=${CENTER_SCALE_DISPLAY_WIDTH} \
		--button  gtk-cancel:${EXIT_CODE} \
		--button  gtk-ok:${OK_CODE} \
		${setting_con} \
	)
	SIGNAL_CODE=$?
	echo "display_setting_edit_manager::SIGNAL_CODE ${SIGNAL_CODE}"
	set -e
}