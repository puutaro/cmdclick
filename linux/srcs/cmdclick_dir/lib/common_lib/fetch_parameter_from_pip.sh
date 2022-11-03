#!/bin/bash


fetch_parameter(){
	local contents="${1}"
	local target_parameter="${2}"
	local hat_target_parameter="^'${target_parameter}'="
	echo "${contents}" \
	| awk '
	{
		hat_target_parameter="^'${target_parameter}'="
		how_gsub_success = gsub(hat_target_parameter, "", $0)
		if(\
			how_gsub_success \
		) print $0
	}'
}

fetch_parameter_from_pip(){
	local target_parameter="${1}"
	local hat_target_parameter="^'${target_parameter}'="
	fetch_parameter \
		"$(cat "/dev/stdin")" \
		"${target_parameter}"
}
