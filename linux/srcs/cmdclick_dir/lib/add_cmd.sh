#!/bin/bash

ADD_CMD_LIB_DIR_PATH="${LIB_DIR_PATH}/add_cmd_lib"
. "${ADD_CMD_LIB_DIR_PATH}/create_command_form.sh"
unset -v ADD_CMD_LIB_DIR_PATH

LOOP=0
CMD_CLICK_ADD_TITLE="${ADD_COMMAND_MESSAGE}"
create_command_form "${INI_FILE_DIR_PATH}"
SIGNAL_CODE=${INDEX_CODE}