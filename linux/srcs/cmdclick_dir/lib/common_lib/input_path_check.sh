#!/bin/bash

INPUT_PATH_CHECK_LIB_PATH="${COMMON_LIB_DIR_PATH}/input_path_check_lib"

. "${INPUT_PATH_CHECK_LIB_PATH}/echo_err_message_by_path_check.sh"
. "${INPUT_PATH_CHECK_LIB_PATH}/display_err_message_about_input_path.sh"
. "${INPUT_PATH_CHECK_LIB_PATH}/val_add_cmd_base.sh"

unset -v INPUT_PATH_CHECK_LIB_PATH


#コマンドをユーザー入力フォームで取得
input_path_check(){
	local input_chdir_path="${1}"
	test -z "${input_chdir_path}" \
		&& SIGNAL_CODE=${CHECK_ERR_CODE} \
		&& return
	local err_message_about_input_chdir_path=$(\
		echo_err_message_by_path_check \
			"${input_chdir_path}"
	)
	case "${err_message_about_input_chdir_path}" in 
		"") SIGNAL_CODE=${OK_CODE}
				return
	;; esac
	set +e
	display_err_message_about_input_path \
		"${input_chdir_path}" \
		"${add_cmd_base}" \
		"${err_message_about_input_chdir_path}"
	SIGNAL_CODE=${CHECK_ERR_CODE}
	set -e
}
