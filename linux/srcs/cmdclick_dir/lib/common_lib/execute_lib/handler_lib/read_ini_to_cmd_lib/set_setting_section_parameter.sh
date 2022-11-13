#!/bin/bash


set_setting_section_parameter(){
	local execute_file_name="${1}"
	cat "${execute_file_name}" \
	| awk \
	-v INI_SETTING_DEFAULT_GAIN_CON="${INI_SETTING_DEFAULT_GAIN_CON}" \
	-v INI_SETTING_SECTION_START_NAME="^${INI_SETTING_SECTION_START_NAME}$" \
	-v INI_SETTING_SECTION_END_NAME="^${INI_SETTING_SECTION_END_NAME}$" \
	\
	'
	BEGIN {
		count_ini_setting_section_start_name = 0
		count_ini_setting_section_end_name = 0
		ini_setting_default_value_cons_of["'${INI_TERMINAL_ON}'"]="ON"
		ini_setting_default_value_cons_of["'${INI_OPEN_WHERE}'"]="CW"
		ini_setting_default_value_cons_of["'${INI_TERMINAL_FOCUS}'"]="ON"
		ini_setting_default_value_cons_of["'${INI_EDIT_EXECUTE}'"]="'${NO_EDIT_EXECUTE}'"
	}
	{	match_INI_SETTING_SECTION_START_NAME = match($0, INI_SETTING_SECTION_START_NAME)
		if(match_INI_SETTING_SECTION_START_NAME) {
			count_ini_setting_section_start_name++
			next
		}
		if(\
			count_ini_setting_section_start_name == 0 \
			|| count_ini_setting_section_start_name >=2 \
		) next
		if($0 ~ INI_SETTING_SECTION_END_NAME) {
			count_ini_setting_section_end_name++ 
			next
		}
		if(count_ini_setting_section_end_name) next
		set_value=substr(\
			$0, \
			index($0, "=")+1, \
			length($0) \
		)
		cur_key=substr(\
			$0, \
			0, \
			index($0, "=")-1 \
		)
		cur_default_value = ini_setting_default_value_cons_of[cur_key]
		cur_key_row_all = cur_key"=[^=]*\n" 
		cur_key_row_all_end = cur_key"=$" 
		cur_key_equal=cur_key"="
		if (set_value != ""){
			sub(cur_key_row_all, cur_key_equal""set_value"\n", INI_SETTING_DEFAULT_GAIN_CON) 
			sub(cur_key_row_all_end, cur_key_equal""set_value, INI_SETTING_DEFAULT_GAIN_CON) 
			next
		}
		if (\
			cur_default_value != "" \
		) {
			sub(cur_key_row_all, cur_key_equal""cur_default_value"\n", INI_SETTING_DEFAULT_GAIN_CON) 
			sub(cur_key_row_all_end, cur_key_equal""cur_default_value"\n", INI_SETTING_DEFAULT_GAIN_CON) 
		}
		sub(cur_key_row_all, cur_key_equal"-\n", INI_SETTING_DEFAULT_GAIN_CON)
		sub(cur_key_row_all_end, cur_key_equal"-", INI_SETTING_DEFAULT_GAIN_CON) 
	}
	END {
		gsub(/=\n/, "=-\n", INI_SETTING_DEFAULT_GAIN_CON)
		gsub(/\n[a-zA-Z0-9_-]*=/, "\n", INI_SETTING_DEFAULT_GAIN_CON)
		sub(/[a-zA-Z0-9_-]*=/, "", INI_SETTING_DEFAULT_GAIN_CON)
		print INI_SETTING_DEFAULT_GAIN_CON
	}
	'
}