#!/bin/bash


replace_ini_cmd_file_name_by_double_quote_one(){
	local surrounded_ini_rename_file_name="${1}"
	local temp_file_path="${2}"
	local sed_ini_rename_file_name=$(\
		echo "${surrounded_ini_rename_file_name}" \
		 | sed -r 's/([^a-zA-Z0-9_-])/\\\1/g' \
	)
	echo "sed -r \"s/(${INI_CMD_FILE_NAME})=.*/\1=${sed_ini_rename_file_name}/\" -i \"${temp_file_path}\""
	sed -r "s/(${INI_CMD_FILE_NAME})=.*/\1=${sed_ini_rename_file_name}/" \
			-i "${temp_file_path}"
}