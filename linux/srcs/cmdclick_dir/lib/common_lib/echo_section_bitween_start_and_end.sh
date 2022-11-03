#!/bin/bash


echo_section_bitween_start_and_end(){
	local ini_contents="${1}"
	local start_section_name="${2}"
	local end_section_name="${3}"
	echo "${ini_contents}" |\
	    awk -v start_section_name="${start_section_name}" \
	      -v  end_section_name="${end_section_name}" \
			'
	        BEGIN {
				count_setting_section_start = 0
				count_setting_section_end = 0
	          }
	          {
				match_search_section_start=match($0, start_section_name)
				match_search_section_end=match($0, end_section_name)
				if (match_search_section_start){
					count_setting_section_start += 1
				}
	            if (match_search_section_end){
					count_setting_section_end += 1
				}
				if(\
					count_setting_section_end == 0 \
					&& count_setting_section_start>=1 \
					&& match_search_section_start == 0 \
					&& match_search_section_end == 0 \
					&& $0 ~ "^[a-zA-Z0-9:_-]*=" \
				){
					print $0
				}
	                  
	          }
	      '
}