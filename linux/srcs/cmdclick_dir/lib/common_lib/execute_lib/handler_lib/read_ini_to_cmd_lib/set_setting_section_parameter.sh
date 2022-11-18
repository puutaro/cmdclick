#!/bin/bash


set_setting_section_parameter(){
	local execute_file_name="${1}"
	cat "${execute_file_name}" \
	| awk \
	-v INI_EXECUTE_SETTING_DEFAULT_GAIN_CON="${INI_EXECUTE_SETTING_DEFAULT_GAIN_CON}" \
	-v INI_SETTING_SECTION_START_NAME="^${INI_SETTING_SECTION_START_NAME}$" \
	-v INI_CMD_VARIABLE_SECTION_START_NAME="^${INI_CMD_VARIABLE_SECTION_START_NAME}$" \
	-v INI_CMD_VARIABLE_SECTION_END_NAME="^${INI_CMD_VARIABLE_SECTION_END_NAME}$" \
	-v INI_SETTING_SECTION_END_NAME="^${INI_SETTING_SECTION_END_NAME}$" \
	\
	'
	BEGIN {
		count_ini_setting_section_start_name = 0
		count_ini_setting_section_end_name = 0
		count_ini_cmd_section_start_name = 0
		count_ini_cmd_section_end_name = 0
		ini_setting_default_value_cons_of["'${INI_TERMINAL_ON}'"]="ON"
		ini_setting_default_value_cons_of["'${INI_OPEN_WHERE}'"]="CW"
		ini_setting_default_value_cons_of["'${INI_TERMINAL_FOCUS}'"]="ON"
		ini_setting_default_value_cons_of["'${INI_EDIT_EXECUTE}'"]="'${NO_EDIT_EXECUTE}'"
		multiple_ok_key_of["'${INI_SHELL_ARGS}'"] = 1
	}
	{
		match_ini_setting_section_start_name = match($0, INI_SETTING_SECTION_START_NAME)
		if(match_ini_setting_section_start_name) {
			count_ini_setting_section_start_name++
			next
		}
		if(\
			count_ini_setting_section_start_name == 0 \
		) next
		if($0 ~ INI_SETTING_SECTION_END_NAME) {
			count_ini_setting_section_end_name++ 
			next
		}
		if($0 ~ INI_CMD_VARIABLE_SECTION_START_NAME) {
			count_ini_cmd_section_start_name++
			next
		}
		if(\
			count_ini_setting_section_end_name \
			&& !count_ini_cmd_section_start_name\
		) next
		if($0 ~ INI_CMD_VARIABLE_SECTION_END_NAME) {
			count_ini_cmd_section_end_name++ 
			next
		}
		if(\
			count_ini_cmd_section_end_name \
		) next
		if( $0 ~ /^[^a-zA-Z:_-]*=/ ) next
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
		if(\
			count_key_of[cur_key] > 0\
			&& multiple_ok_key_of[cur_key] <= 0\
		) next
		count_key_of[cur_key]++
		
		if (\
			set_value != "" \
			&& count_plane_replace_of[cur_key] <= 0\
		){
			sub(cur_key_row_all, cur_key_equal""set_value"\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON) 
			sub(cur_key_row_all_end, cur_key_equal""set_value, INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
			count_plane_replace_of[cur_key]++
			next
		}
		if (\
			set_value != "" \
			&& multiple_ok_key_of[cur_key] > 0\
			&& count_plane_replace_of[cur_key] > 0\
		){
			str_start_from_cur_key = substr(\
				INI_EXECUTE_SETTING_DEFAULT_GAIN_CON, \
				index(\
					INI_EXECUTE_SETTING_DEFAULT_GAIN_CON, \
					cur_key\
				), \
				length(INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)\
			)
			cur_val = substr(\
					str_start_from_cur_key, \
					index(\
						str_start_from_cur_key, \
						"=" \
					)+1, \
					index(\
						str_start_from_cur_key, \
						"\n"\
					)-1 \
				)
			if(!cur_val){
				cur_val = substr(\
					str_start_from_cur_key, \
					index(\
						str_start_from_cur_key, \
						"="\
					)+1, \
					length(str_start_from_cur_key)\
				)
			}

			sub_success_code = sub(\
				cur_key"=[^=]*\n" , \
				cur_key"="cur_val" "set_value"\n", \
				INI_EXECUTE_SETTING_DEFAULT_GAIN_CON \
			)
			if(!sub_success_code){
				sub(\
					cur_key"=[^=]*" , \
					cur_key"="cur_val" "set_value, \
					INI_EXECUTE_SETTING_DEFAULT_GAIN_CON \
				)
			}
			next
		}
		if (\
			cur_default_value != "" \
		) {
			sub(cur_key_row_all, cur_key_equal""cur_default_value"\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON) 
			sub(cur_key_row_all_end, cur_key_equal""cur_default_value"\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON) 
		}
		sub(cur_key_row_all, cur_key_equal"-\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
		sub(cur_key_row_all_end, cur_key_equal"-", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON) 
	}
	END {
		gsub(/=\n/, "=-\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
		sub(/=$/, "=-", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
		gsub(/\n[a-zA-Z0-9_-]*=/, "\n", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
		sub(/[a-zA-Z0-9_-]*=/, "", INI_EXECUTE_SETTING_DEFAULT_GAIN_CON)
		print INI_EXECUTE_SETTING_DEFAULT_GAIN_CON
	}
	'
}