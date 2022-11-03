#!/bin/bash


echo_replace_cmd_section_with_default_value(){
	local ini_contents_moto="${1}"
	local exec_default_parameter="${2}"
	echo "${exec_default_parameter}" \
	| awk \
	-v ini_contents_moto="${ini_contents_moto}" \
	'
	BEGIN {
		end_buffer_order = 1000
	}
	{ 
		replace_record = $0
		grep_str = substr(\
			replace_record, \
			0, \
			index(replace_record, "=") - 1 \
		)
		sub(":CB$", "", grep_str)
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