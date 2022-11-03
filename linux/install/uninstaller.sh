#!/bin/bash


CURRENT_DIR_PATH="$(dirname $0)"
INSTALLER_LIB_PATH="${CURRENT_DIR_PATH}/uninstaller_lib"
FILES_LIB_PATH="${CURRENT_DIR_PATH}/files"
CMDCLICK_LINUX_SRCS_DIR_PATH="$(dirname "${CURRENT_DIR_PATH}")/srcs"
USRLOCALBIN="/usr/local/bin"


. "${INSTALLER_LIB_PATH}/uninstall_cmdclick.sh"


uninstall_cmdclick \
	"${USRLOCALBIN}"


