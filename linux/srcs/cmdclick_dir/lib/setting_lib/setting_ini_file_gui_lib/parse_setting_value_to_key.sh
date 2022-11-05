#!/bin/bash


parse_setting_value_to_key(){
	local setting_con_source="${1}"
	local cmdclick_setting_key_con="${2}"
	local setting_value="${3}"
	echo "${setting_con_source}" \
	| awk \
	-v setting_value="${setting_value}" \
	-v cmdclick_setting_key_con="${cmdclick_setting_key_con}" \
	'BEGIN {
		gsub("\t", "\n", setting_value)
	}
	{
		current_key = substr($0, 0, index($0, "=")-1)
		if(\
			cmdclick_setting_key_con !~ "^"current_key \
			&& cmdclick_setting_key_con !~ "\n"current_key"\n" \
			&& cmdclick_setting_key_con !~ current_key"$" \
		){ 
			print $0
			next
		}
		current_value = substr(\
			setting_value, \
			0, \
			index(setting_value, "\n")-1 \
		)
		if(!current_value) {
			current_value=substr(\
				setting_value, \
				0, \
				length(setting_value) \
			)
		}
		sub(current_value"\n", "", setting_value)
		print current_key"="current_value
	}' 

}