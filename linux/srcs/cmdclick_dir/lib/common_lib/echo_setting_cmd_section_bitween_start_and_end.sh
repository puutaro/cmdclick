#!/bin/bash


echo_setting_cmd_section_bitween_start_and_end(){
	local ini_contents="${1}"
	echo "${ini_contents}" |\
	    awk \
	    	-v start_setting_section_name="${SEARCH_INI_SETTING_SECTION_START_NAME}" \
			-v end_setting_section_name="${SEARCH_INI_SETTING_SECTION_END_NAME}" \
			-v start_cmd_section_name="${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
			-v end_cmd_section_name="${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}" \
			'
	        BEGIN {
				count_setting_section_start = 0
				count_setting_section_end = 0
				count_cmd_section_start = 0
				count_cmd_section_end = 0
	          }
	          {
				match_search_setting_section_start=match($0, start_setting_section_name)
				if (match_search_setting_section_start){
					count_setting_section_start += 1
				}
				match_search_setting_section_end=match($0, end_setting_section_name)
	            if (match_search_setting_section_end){
					count_setting_section_end += 1
				}
				match_search_cmd_section_start=match($0, start_cmd_section_name)
				if (match_search_cmd_section_start){
					count_cmd_section_start += 1
				}
				match_search_cmd_section_end=match($0, end_cmd_section_name)
	            if (match_search_cmd_section_end){
					count_cmd_section_end += 1
				}
				if(\
					count_setting_section_end == 0 \
					&& count_setting_section_start>=1 \
					&& match_search_setting_section_start == 0 \
					&& match_search_setting_section_end == 0 \
					&& $0 ~ "^[a-zA-Z0-9:_-]*=" \
				){
					print $0
				}
	            if(\
					count_cmd_section_end == 0 \
					&& count_cmd_section_start>=1 \
					&& match_search_cmd_section_start == 0 \
					&& match_search_cmd_section_end == 0 \
					&& $0 ~ "^[a-zA-Z0-9:_-]*=" \
				){
					print $0
				}    
	          }
	      '
}