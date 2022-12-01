#!/bin/bash


ini_file_section_check_lib_dir_path="${CHECK_INI_FILE_LIB_PATH}/ini_file_section_check_lib"
. "${ini_file_section_check_lib_dir_path}/echo_valified_about_section_holder.sh"
. "${ini_file_section_check_lib_dir_path}/check_backslash_exist.sh"
. "${COMMON_LIB_DIR_PATH}/fetch_parameter_from_pip.sh"
. "${COMMON_LIB_DIR_PATH}/check_quote_surrounded_when_existing_space_or_single_quote_exist.sh"
. "${COMMON_LIB_DIR_PATH}/echo_setting_cmd_section_bitween_start_and_end.sh"

input_path_check_lib="${COMMON_LIB_DIR_PATH}/input_path_check_lib"
. "${input_path_check_lib}/echo_err_message_by_path_check.sh"

unset -v ini_file_section_check_lib_dir_path
unset -v input_path_check_lib
unset -v echo_err_message_by_path_check_lib_dir_path


ini_file_section_check(){
	local validate_err_message_body="${1}"
	local ini_contents="${2}"
	case "${validate_err_message_body}" in
		"");; *) return;; esac
	local validate_err_message_body+=$(\
		echo_valified_about_section_holder \
			"${ini_contents}" \
	)
	local ini_parameter_contents="$(\
		echo_setting_cmd_section_bitween_start_and_end \
			"${ini_contents}" \
	)"
	local validate_err_message_body+=$(\
		check_quote_surrounded_when_existing_space_or_single_quote_exist \
			"${ini_parameter_contents}" \
	)
	local validate_err_message_body+=$(\
		check_backslash_exist \
			"${ini_parameter_contents}" \
	)
	local ini_file_name_parameter=$(\
		fetch_parameter \
			"${ini_parameter_contents}" \
			"${INI_CMD_FILE_NAME}" \
	)
	local ini_file_name_removed_double_quote_both_ends=$(\
		echo_removed_double_quote_both_ends \
			"${ini_file_name_parameter}" \
	)
	local validate_err_message_body+="$(\
		echo_err_message_by_path_check \
			"${INI_FILE_DIR_PATH}/${ini_file_name_removed_double_quote_both_ends}" \
	)"
	unset -v ini_file_name_removed_double_quote_both_ends
	local ch_dir_path_parameter=$(\
		fetch_parameter \
			"${ini_parameter_contents}" \
			"${CH_DIR_PATH}" \
	)
	case "${ch_dir_path_parameter}" in "");;
		*) 
			local ch_dir_path_removed_double_quote_both_ends=$(\
				echo_removed_double_quote_both_ends \
					"${ch_dir_path_parameter}" \
			)
			local validate_err_message_body+="$(\
				echo_err_message_by_path_check \
					"${ch_dir_path_removed_double_quote_both_ends}" \
			)"
			unset -v ch_dir_path_removed_double_quote_both_ends
	;; esac
	unset -v ch_dir_path_parameter
	echo "${validate_err_message_body}"
}
