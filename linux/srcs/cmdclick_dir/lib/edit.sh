#!/bin/bash

LANG="ja_JP.UTF-8"
LOOP=0
check_ini_file \
	"${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
case "${SIGNAL_CODE}" in 
	"${CHECK_ERR_CODE}") SIGNAL_CODE=${INDEX_CODE};;
	*) 
		EDIT_WINDOW_LOCATION="--center --width=${CENTER_SCALE_DISPLAY_WIDTH} --height=${CENTER_SCALE_DISPLAY_HEIGHT}"
		edit_ini_gui \
			"${EXECUTE_FILE_NAME}" \
			"" \
			"${EXEC_SET_VARIABLE_TYPE}"
		;;
esac
SIGNAL_CODE=${INDEX_CODE}
