#!/bin/bash


exec_edit_display_first_roop(){
	INI_VALUE=$(\
		LANG="ja_JP.UTF-8" \
		yad --plug=${PLUG_KEY} \
			--tabnum=1 \
			--form\
			--text "\n${PROMPT_SENTENCE} \n" \
			--separator=$'\t' \
			--date-format="%Y-%m-%d"\
			--scroll \
			${CMD_VARIABLE_CONTENSTS_FIELD_LIST[@]} \
			"${CMD_VARIABLE_CONTENSTS_VALUE_LIST[@]}" \
			--borders=${CMDCLICK_BORDER_NUM} \
			 & \
		yad \
			--plug=${PLUG_KEY} \
			--tabnum=2 \
			--form \
			--borders=${CMDCLICK_BORDER_NUM} \
			--separator=$'\t\t' \
			--scroll \
			--field="\n${EDIT_DESCRIPTION} \n":LBL \
			& \
		yad \
			--notebook \
			--title="${WINDOW_TITLE}" \
			--window-icon="${WINDOW_ICON_PATH}" \
			--key=${PLUG_KEY} \
			--tab="${CMD_TAB}" \
			--tab="${DESC_TAB}" \
			--scroll \
			${EDIT_WINDOW_LOCATION} \
			${BUTTON_LIST[@]}\
	)
	SIGNAL_CODE=$?
	INI_VALUE=$(\
		echo_ini_value_by_order_correct \
			"${INI_VALUE}"
	)
}