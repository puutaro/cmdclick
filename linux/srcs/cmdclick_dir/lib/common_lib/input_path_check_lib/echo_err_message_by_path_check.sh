#!/bin/bash

input_path_check_lib_path="${COMMON_LIB_DIR_PATH}/input_path_check_lib"
echo_err_message_by_path_check_lib_dir_path="${input_path_check_lib_path}/echo_err_message_by_path_check_lib"
. "${echo_err_message_by_path_check_lib_dir_path}/echo_err_message_by_forbidden_string_exist.sh"

unset -v echo_err_message_by_path_check_lib_dir_path
unset -v input_path_check_lib_path

echo_err_message_by_path_check(){
	local input_path="${1}"
	local input_path_replace_by_home="$(\
		eval "echo \"${input_path}\""\
	)"
	test -z "${input_path_replace_by_home}" \
		&& err_message_about_input_path+="\t\t- illegular string used\n"
	err_message_about_input_path+="$(\
			echo_err_message_by_forbidden_string_exist \
				"${input_path}" \
		)"
	echo "${err_message_about_input_path}"
}