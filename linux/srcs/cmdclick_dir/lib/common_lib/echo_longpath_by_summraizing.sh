#!/bin/bash


echo_longpath_by_summraizing(){
	local path="${1}"
	echo "${path}" \
		| awk \
		-v HOME="${HOME}" \
		'{
			target_path = $0
			gsub(HOME, "~", target_path)
			target_path_list_length = split(\
				target_path, \
				target_path_list, \
				"/" \
			)
			if(target_path_list_length <= 5){
				print target_path
				exit
			}
			print target_path_list[1]"/"target_path_list[2]"/../"target_path_list[target_path_list_length-1]"/"target_path_list[target_path_list_length]
		}'
}
