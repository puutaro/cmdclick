#!/bin/bash

DELETE_LIB_DIR_PATH="${LIB_DIR_PATH}/delete_lib"
. "${DELETE_LIB_DIR_PATH}/delete_cmd_gui.sh"
unset -v DELETE_LIB_DIR_PATH

LOOP=0
DELETE_FILE_PATH="${INI_FILE_DIR_PATH}/${EXECUTE_FILE_NAME}"
delete_cmd
SIGNAL_CODE=${INDEX_CODE}