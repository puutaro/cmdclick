#!/bin/bash


echo_replace_cmd_section_with_default_value(){
	local ini_contents_moto="${1}"
	local exec_default_parameter="${2}"
	local COUNT_EXEC_INPUT_EXECUTE="${3}"
	echo "${exec_default_parameter}" \
	| awk \
	-v ini_contents_moto="${ini_contents_moto}" \
	-v COUNT_EXEC_INPUT_EXECUTE="${COUNT_EXEC_INPUT_EXECUTE}" \
	'
	BEGIN {
		checkbox_num=1
		num_inc_dec=2
		extramation_use_gtk_edit_type_of["CB"]=checkbox_num
		extramation_use_gtk_edit_type_of["CBE"]=checkbox_num
		extramation_use_gtk_edit_type_of["NUM"]=num_inc_dec
		end_buffer_order = 1000
	}
	function update_replace_record_by_count_exec_input_execute(\
		target_record \
	){
		if(\
			COUNT_EXEC_INPUT_EXECUTE == 1 \
		){
			return
		}
		target_value = substr(\
			target_record, \
			index(target_record, "=")+1, \
			length(target_record)-1 \
		)
		sub("\n", "", target_value)
		replace_key = substr(\
			replace_record, \
			0, \
			index(replace_record, "=")-1 \
		)
		replace_value = substr(\
			replace_record, \
			index(replace_record, "=")+1, \
			length(replace_record) \
		)
		if(\
			extramation_use_gtk_edit_type_of[gtk_edit_type] != checkbox_num \
			&& extramation_use_gtk_edit_type_of[gtk_edit_type] != num_inc_dec \
		){
			replace_record=replace_key"="target_value
			return
		}
		if(\
			extramation_use_gtk_edit_type_of[gtk_edit_type] == checkbox_num \
		){
			sub(\
				"!"target_value"!", \
				"!^"target_value"!", \
				replace_value \
			)
			sub(\
				"!"target_value"$", \
				"!^"target_value, \
				replace_value \
			)
		}
		if(\
			extramation_use_gtk_edit_type_of[gtk_edit_type] == num_inc_dec \
		){
			sub(\
				/^[1-9.]*/, \
				target_value, \
				replace_value \
			)
		}
		replace_record=replace_key"="replace_value
	}
	function replace_yad_gtk_edit_option(){
		colon_index = index(grep_str, ":")
		if(colon_index == 0) {
			return
		}
		gtk_edit_type = substr(\
			grep_str, \
			colon_index+1, \
			length(grep_str) - colon_index \
		)
		sub(\
			/:[A-Z]*$/, \
			"", \
			grep_str \
		)
	}
	{ 
		gtk_edit_type=""
		replace_record = $0
		grep_str = substr(\
			replace_record, \
			0, \
			index(replace_record, "=") - 1 \
		)
		replace_yad_gtk_edit_option()
		if(\
			ini_contents_moto !~ "\n"grep_str"=" \
		) next
		grep_str_order = index(ini_contents_moto, "\n"grep_str) + 1
		rest_str = substr(\
			ini_contents_moto, \
			grep_str_order, \
			end_buffer_order \
		)
		target_record = substr(\
			ini_contents_moto, \
			grep_str_order, \
			index(rest_str, "\n") \
		)
		update_replace_record_by_count_exec_input_execute(\
			target_record \
		)
		sub(\
			target_record, \
			replace_record"\n", \
			ini_contents_moto \
		)
	}
	END {
		print ini_contents_moto
	}
	'
}