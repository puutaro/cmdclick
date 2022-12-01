#!/bin/bash


check_backslash_exist(){
	local ini_parameter_contents="${1}"
	echo "${ini_parameter_contents}" \
		| awk '{
			if($0 ~ "\\\\") {
				key = substr($0, 1, index($0, "="))
				print "back slash forbidden: "key 
			}
		}'
}