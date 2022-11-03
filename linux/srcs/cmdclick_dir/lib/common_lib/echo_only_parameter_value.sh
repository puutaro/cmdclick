#!/bin/bash


echo_only_parameter_value(){
	local contents="${1}"
	echo "${contents}" \
	| awk '
		{
			if($0 ~ "^[a-zA-Z0-9_-]*=$"){
				print "-"
				next
			}
			print substr($0, index($0, "=")+1, length($0))
		}'
}


echo_only_parameter_value_from_pip(){
	echo_only_parameter_value \
		"$(cat "/dev/stdin")"
}