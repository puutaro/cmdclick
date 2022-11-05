#!/bin/bash


WINDOWS_HOME_PATH="${1}"
CURRENT_DIR_NAME="$(dirname $0)"
UBUNTU_SETTING_LIB_PATH="${CURRENT_DIR_NAME}/ubuntu_setting_lib"
. "${UBUNTU_SETTING_LIB_PATH}/install_requirement_package_for_cmdclick.sh"
. "${UBUNTU_SETTING_LIB_PATH}/cmdclick_install.sh"
. "${UBUNTU_SETTING_LIB_PATH}/japanese_setting.sh"


cd "${HOME}"
install_requirement_package_for_cmdclick
cmdclick_install "${WINDOWS_HOME_PATH}"
japanese_setting