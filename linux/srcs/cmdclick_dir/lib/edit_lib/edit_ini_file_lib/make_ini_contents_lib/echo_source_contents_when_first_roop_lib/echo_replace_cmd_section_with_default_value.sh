#!/bin/bash


echo_replace_cmd_section_with_default_value(){
	local ini_contents_moto="${1}"
	local exec_default_parameter="${2}"
	echo "${exec_default_parameter}" \
	| awk \
	-v ini_contents_moto="${ini_contents_moto}" \
	'
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
		end_buffer_order = 1000
	}
	{ 
		replace_record = $0
		grep_str = substr(\
			replace_record, \
			0, \
			index(replace_record, "=") - 1 \
		)
		for(\
			i=0; i<length(gui_edit_option_list);i++ \
		){
			success_code = sub(\
				":"gui_edit_option_list[i]"$", \
				"", \
				grep_str \
			)
			if(success_code) break
		}
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