#!/bin/bash


WINDOWS_HOME_PATH="${1}"
CURRENT_DIR_NAME="$(dirname $0)"
EXEC_UNINSTALL_LIB="${CURRENT_DIR_NAME}/exec_uninstall_lib"

. "${EXEC_UNINSTALL_LIB}/cmdclick_uninstall.sh"

cd "${HOME}"

cmdclick_uninstall
