#!/bin/bash


make_cmd_variable_field_and_value_list(){
	local get_valiable="${1}"
	local IFS=$'\n'
	CMD_VARIABLE_CONTENSTS_FIELD_LIST=(\
	$(\
		echo "${get_valiable}" \
			| awk -F '\t' '{
			print "--field="$1
			}' \
	)\
	)
	CMD_VARIABLE_CONTENSTS_VALUE_LIST=(\
	$(\
		echo "${get_valiable}" \
		| awk -F '\t' '{
			gsub( /^-/, "\x22-\x22", $2);
			for (i=2; i<=NF; i++) print $i
			}'
		)\
	)
}