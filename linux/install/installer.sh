#!/bin/bash


CURRENT_FILE_PATH="$(readlink -f "$0")"
CURRENT_DIR_PATH="$(dirname "${CURRENT_FILE_PATH}")"
INSTALLER_LIB_PATH="${CURRENT_DIR_PATH}/installer_lib"
FILES_LIB_PATH="${CURRENT_DIR_PATH}/files"
CMDCLICK_LINUX_SRCS_DIR_PATH="$(dirname "${CURRENT_DIR_PATH}")/srcs"
USRLOCALBIN="/usr/local/bin"


. "${INSTALLER_LIB_PATH}/install_sublime.sh"
. "${INSTALLER_LIB_PATH}/install_cmdclick.sh"
. "${INSTALLER_LIB_PATH}/install_required_package.sh"


cd "${HOME}"

install_sublime \
	"${USRLOCALBIN}" \
	"${FILES_LIB_PATH}"

install_required_package \
	"${USRLOCALBIN}" \
	"${FILES_LIB_PATH}"

install_cmdclick \
	"${USRLOCALBIN}" \
	"${CMDCLICK_LINUX_SRCS_DIR_PATH}" \
	"${FILES_LIB_PATH}"


