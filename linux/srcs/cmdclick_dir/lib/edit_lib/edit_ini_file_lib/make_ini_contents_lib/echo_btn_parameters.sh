#!/bin/bash


echo_btn_parameters(){
	local ini_contents_moto="${1}"
    local exec_default_parameter="${2}"
    echo "${ini_contents_moto}" |\
	   awk \
	    -v start_section_name="${INI_CMD_VARIABLE_SECTION_START_NAME}" \
	    -v end_section_name="${INI_CMD_VARIABLE_SECTION_END_NAME}" \
	    -v exec_default_parameter="${exec_default_parameter}" \
		'
		BEGIN {
			count_setting_section_start = 0
			count_setting_section_end = 0
			exec_default_parameter="\n"exec_default_parameter"\n"
			# print "exec_default_parameter"
			# print exec_default_parameter
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
				count_setting_section_end > 0 \
				|| count_setting_section_start < 1 \
				|| $0 !~ "^[a-zA-Z0-9:_-]*=" \
			){
				next
			}
			if(\
				$0 !~ /^[a-zA-Z0-9_-]*=/ \
			) next
			parameter_key = $0
			sub("=.*", "", parameter_key)
			# print "parameter_key "parameter_key
			if(\
				exec_default_parameter !~ "\n"parameter_key":BTN=\n" \
				&& exec_default_parameter !~ "\n"parameter_key":FBTN=\n" \
				&& exec_default_parameter !~ "\n"parameter_key":LBL=\n" \
			) next
			# sub(parameter_key"=", "", $0)
			# if(!$0) $0 = "-"
			print $0
		  }
		'
}