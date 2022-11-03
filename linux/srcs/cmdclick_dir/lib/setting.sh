#!/bin/bash


SETTING_LIB_DIR_PATH="${LIB_DIR_PATH}/setting_lib"
. "${SETTING_LIB_DIR_PATH}/setting_file_edit_gui.sh"
unset -v SETTING_LIB_DIR_PATH

LOOP=0
setting_file_edit_gui
SIGNAL_CODE=${INDEX_CODE}