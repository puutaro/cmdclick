#!/bin/bash

MOVE_LIB_DIR_PATH="${LIB_DIR_PATH}/move_lib"
. "${MOVE_LIB_DIR_PATH}/move_ini_file_gui.sh"
unset -v MOVE_LIB_DIR_PATH

LOOP=0
move_ini_file_gui \
	"${INI_FILE_DIR_PATH}" \
	"${EXECUTE_FILE_NAME}"
SIGNAL_CODE=${INDEX_CODE}