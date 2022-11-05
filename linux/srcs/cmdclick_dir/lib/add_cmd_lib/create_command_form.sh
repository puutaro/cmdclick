#!/bin/bash

create_dommand_form_lib_dir_path="${ADD_CMD_LIB_DIR_PATH}/create_command_form_lib"

. "${create_dommand_form_lib_dir_path}/echo_default_cmdclick_bash_file_con.sh"
. "${create_dommand_form_lib_dir_path}/add_cmd_confirm.sh"
. "${create_dommand_form_lib_dir_path}/replace_ini_cmd_file_name_by_double_quote_one.sh"
. "${COMMON_LIB_DIR_PATH}/input_path_check.sh"
. "${COMMON_LIB_DIR_PATH}/surround_single_double_quote_when_existing_space.sh"
. "${COMMON_LIB_DIR_PATH}/echo_removed_double_quote_both_ends.sh"

unset -v create_dommand_form_lib_dir_path


#コマンドをユーザー入力フォームで取得
create_command_form(){
	local ini_file_dir_path="${1}"
	local temp_file_name="$(($RANDOM % 1000))${COMMAND_CLICK_EXTENSION}"
	local temp_file_path="${ini_file_dir_path}/${temp_file_name}"
	local default_cmdclick_bash_file_con=$(\
		echo_default_cmdclick_bash_file_con \
			"${temp_file_name}" \
	)
	echo "${default_cmdclick_bash_file_con}" > "${temp_file_path}"
	unset -v default_cmdclick_bash_file_con
	sleep 0.3 && open_editor "${temp_file_path}" &
	set +e
	add_cmd_confirm "${temp_file_path}"
    local confirm=$?
    set -e
	case "${confirm}" in 
		"${EXIT_CODE_SOURCE}"|"${EXIT_CODE}")
			test -f "${temp_file_path}" \
				&& rm -f "${temp_file_path}"
			return
	;; esac
	unset -v confirm
	local ini_rename_file_name=$(\
		cat "${temp_file_path}" \
			| fetch_parameter_from_pip "${INI_CMD_FILE_NAME}" \
	)
	case "${ini_rename_file_name}" in 
		"${temp_file_name}") return 
	;; esac
	unset -v temp_file_name
	SIGNAL_CODE=""
	input_path_check "${ini_file_dir_path}/${ini_rename_file_name}"
	case "${SIGNAL_CODE}" in 
		"${CHECK_ERR_CODE}")
			return
	;; esac
	local surrounded_ini_rename_file_name=$(\
		surround_single_double_quote_when_existing_space \
			"${ini_rename_file_name}" \
	)
	unset -v ini_rename_file_name
	replace_ini_cmd_file_name_by_double_quote_one \
		"${surrounded_ini_rename_file_name}" \
		"${temp_file_path}"
	local removed_double_quote_both_ends=$(\
		echo_removed_double_quote_both_ends \
			"${surrounded_ini_rename_file_name}" \
	)
	unset -v surrounded_ini_rename_file_name
	mv "${temp_file_path}" "${ini_file_dir_path}/${removed_double_quote_both_ends}"
}