#!/bin/bash


echo_labeling_section_bitween_start_and_end(){
	local ini_contents="${1}"
	local print_method="${2:-printf}"
	local start_section_name=${SEARCH_INI_LABELING_SECTION_START_NAME}
	local end_section_name=${SEARCH_INI_LABELING_SECTION_END_NAME}
	echo "${ini_contents}" |\
	    awk -v start_section_name="${start_section_name}" \
	      -v end_section_name="${end_section_name}" \
	      -v print_method="${print_method}" \
	      '
	        BEGIN {
	              count_setting_section_start = 0
	              count_setting_section_end = 0
	          }
	          {
				match_search_section_start=match($0, start_section_name)
				match_search_section_end=match($0, end_section_name)
				if (match_search_section_start>0)
				  count_setting_section_start += 1
				if (match_search_section_end>0)
				  count_setting_section_end += 1
				if(count_setting_section_start <= 0) next
				if(count_setting_section_end >= 1) next
				if(match_search_section_start > 0) next
				if(match_search_section_start > 0) next
				gsub( /^#*/, "", $0);
				gsub( /^ */, "", $0);
				gsub( /\n */, "\n", $0);
				if(print_method == "printf") '${print_method}' $0"  "
				else if(print_method == "print") '${print_method}' $0
	          }
	      '
}


echo_labeling_section_bitween_start_and_end_from_pip(){
	echo_labeling_section_bitween_start_and_end \
		"$(cat "/dev/stdin")"
}