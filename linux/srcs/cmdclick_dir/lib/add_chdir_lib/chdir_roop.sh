#!/bin/bash

ADD_CHDIR_CMD_LIB_DIR_PATH="${CHDIR_LIB_DIR_PATH}/chdir_roop_lib"

. "${ADD_CHDIR_CMD_LIB_DIR_PATH}/create_chdir_command_form.sh"
. "${COMMON_LIB_DIR_PATH}/input_path_check.sh"

CHDIR_LOOP=0
input_chdir_path_source="$(\
	create_chdir_command_form \
	| sed 's/|$//' \
)" 
input_chdir_path=$(\
	echo_removed_double_quote_both_ends \
		"${input_chdir_path_source}" \
)
SIGNAL_CODE=""
input_path_check "${input_chdir_path}"
case "${SIGNAL_CODE}" in 
	"${CHECK_ERR_CODE}") ;;
	*) 
		add_chdir_cmd_ini_file "${input_chdir_path}" 
		;;
esac
unset -v ADD_CHDIR_CMD_LIB_DIR_PATH
SIGNAL_CODE=${INDEX_CODE}
