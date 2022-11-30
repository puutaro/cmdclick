#!/bin/bash


echo_ini_value_by_order_correct(){
	local ini_value="${1}"
	local LANG="ja_JP.UTF-8"
	echo "" \
	| awk \
		-v ini_value="${ini_value}" \
	'BEGIN {
		sub("^\t*", "", ini_value)
		sub("^\n", "", ini_value)
		newline_index = index(ini_value, "\n")
		double_tab_index = index(ini_value, "\t\t")
		if(newline_index < double_tab_index){
			gsub("\n", "\t", ini_value)
			gsub("\t\t*", "\t", ini_value)
			print ini_value
			exit
		}
		cmd_variable_values = substr(\
			ini_value, \
			1, \
			newline_index-1\
		)
		setting_variable_values = substr(\
			ini_value, \
			newline_index+1, \
			length(ini_value)\
		)
		ini_value=setting_variable_values"\n"cmd_variable_values
		gsub("\n", "\t", ini_value)
		gsub("\t\t*", "\t", ini_value)
		sub("^\t*", "", ini_value)
		print ini_value
	}'
}