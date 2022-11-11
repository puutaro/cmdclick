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
			!extramation_use_gtk_edit_type_of[gtk_edit_type] \
		){
			replace_record=replace_key"="target_value
			return
		}
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
		replace_record=replace_key"="replace_value
	}
	function replace_yad_gtk_edit_option(\
		gui_edit_option_list \
	){
		if(index(grep_str, ":") == 0) {
			return
		}
		for(\
			i=0; i<length(gui_edit_option_list);i++ \
		){
			success_code = sub(\
				":"gui_edit_option_list[i]"$", \
				"", \
				grep_str \
			)
			if(success_code) {
				gtk_edit_type=gui_edit_option_list[i]
				break
			}
		}
	}
	BEGIN {
		gui_edit_option_list[0]="H"
		gui_edit_option_list[1]="RO"
		gui_edit_option_list[2]="NUM"
		gui_edit_option_list[3]="CHK"
		gui_edit_option_list[4]="CB"
		gui_edit_option_list[5]="CBE"
		gui_edit_option_list[6]="FL"
		gui_edit_option_list[7]="MFL"
		gui_edit_option_list[8]="SFL"
		gui_edit_option_list[9]="DIR"
		gui_edit_option_list[10]="MDIR"
		gui_edit_option_list[11]="CHDIR"
		gui_edit_option_list[12]="FN"
		gui_edit_option_list[13]="DT"
		gui_edit_option_list[14]="SCL"
		gui_edit_option_list[15]="CLR"
		gui_edit_option_list[16]="BTN"
		gui_edit_option_list[17]="FBTN"
		gui_edit_option_list[18]="LBL"
		extramation_use_gtk_edit_type_of["CB"]=1
		extramation_use_gtk_edit_type_of["CBE"]=1
		extramation_use_gtk_edit_type_of["MFL"]=1
		extramation_use_gtk_edit_type_of["MDIR"]=1
		end_buffer_order = 1000
	}
	{ 
		gtk_edit_type=""
		replace_record = $0
		grep_str = substr(\
			replace_record, \
			0, \
			index(replace_record, "=") - 1 \
		)
		replace_yad_gtk_edit_option(\
			gui_edit_option_list \
		)
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