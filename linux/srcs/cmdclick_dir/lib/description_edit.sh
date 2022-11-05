#!/bin/bash

DESCRIPTION_EDIT_LIB_DIR_PATH="${LIB_DIR_PATH}/description_edit_lib"
. "${DESCRIPTION_EDIT_LIB_DIR_PATH}/description_edit_gui.sh"
unset -v DESCRIPTION_EDIT_LIB_DIR_PATH


LANG="ja_JP.UTF-8"
LOOP=0
description_edit_target_file_path="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
check_ini_file "${description_edit_target_file_path}"
case "${SIGNAL_CODE}" in 
	"${CHECK_ERR_CODE}") SIGNAL_CODE=${INDEX_CODE};;
	*) description_edit_gui \
		"${description_edit_target_file_path}"
		;;
esac
unset -v description_edit_target_file_path
SIGNAL_CODE=${INDEX_CODE}