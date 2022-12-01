#!/bin/bash


echo_section_bitween_setting_cmd_section(){
	local ini_contents="${1}"
	echo "${ini_contents}" \
    | awk \
    -F '=' \
    -v INI_SETTING_DEFAULT_VALUE_CONS="${INI_SETTING_DEFAULT_VALUE_CONS}" \
    -v SEARCH_INI_SETTING_SECTION_START_NAME="${SEARCH_INI_SETTING_SECTION_START_NAME}" \
    -v SEARCH_INI_SETTING_SECTION_END_NAME="${SEARCH_INI_SETTING_SECTION_END_NAME}" \
    -v SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME="${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
    -v SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME="${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}" \
    '
	BEGIN {
		count_ini_setting_section_start_name = 0
		count_ini_setting_section_end_name = 0
		count_ini_cmd_variable_section_start_name = 0
		count_ini_cmd_variable_section_end_name = 0
	}
	{
		current_first_field_value=$1
		if(current_first_field_value=="") next
		if(match(current_first_field_value, SEARCH_INI_SETTING_SECTION_START_NAME)) count_ini_setting_section_start_name++
		if(match(current_first_field_value, SEARCH_INI_SETTING_SECTION_END_NAME)) count_ini_setting_section_end_name++
		if(match(current_first_field_value, SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME)) count_ini_cmd_variable_section_start_name++
		if(match(current_first_field_value, SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME)) count_ini_cmd_variable_section_end_name++

		if( \
			count_ini_cmd_variable_section_start_name == 0 \
			&& count_ini_cmd_variable_section_end_name == 0 \
			&& count_ini_setting_section_start_name == 0 \
			&& count_ini_cmd_variable_section_end_name == 0 \
		) next

		if( \
			count_ini_cmd_variable_section_start_name == 1 \
			&& count_ini_cmd_variable_section_end_name == 1 \
			&& count_ini_setting_section_start_name == 1 \
			&& count_ini_cmd_variable_section_end_name == 1 \
		) next
		if(current_first_field_value ~ "[^a-zA-Z0-9:_-]") next
		match_num = match(INI_SETTING_DEFAULT_VALUE_CONS, current_first_field_value)
		if( \
			count_ini_setting_section_start_name == 1 \
			&& count_ini_setting_section_end_name == 0 \
		) match_num=1
		if( \
			count_ini_cmd_variable_section_start_name == 1 \
			&& count_ini_cmd_variable_section_end_name == 0 \
		) match_num=1
		if(match_num <= 0) next
		gsub( /:[a-zA-Z]*$/, "", $1)
		print current_first_field_value
	}'
}