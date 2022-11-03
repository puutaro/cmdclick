#!/bin/bash


INSTALL_LIB_DIR_PATH="${LIB_DIR_PATH}/install_lib"
. "${INSTALL_LIB_DIR_PATH}/install_ini_file_gui.sh"
unset -v INSTALL_LIB_DIR_PATH

LOOP=0
install_ini_file_gui
SIGNAL_CODE=${INDEX_CODE}