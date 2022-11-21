#!/bin/bash


echo_longpath_by_summraizing(){
	local path="${1}"
	local display_path_hierarchy_limit_num=4
	echo "${path}" \
		| awk \
		-v HOME="${HOME}" \
		-v display_path_hierarchy_limit_num=${display_path_hierarchy_limit_num} \
		'{
			target_path = $0
			gsub(HOME, "~", target_path)
			target_path_list_length = split(\
				target_path, \
				target_path_list, \
				"/" \
			)
			if(target_path_list_length <= display_path_hierarchy_limit_num){
				print target_path
				exit
			}
			print target_path_list[1]"/../"target_path_list[target_path_list_length-1]"/"target_path_list[target_path_list_length]
		}'
}
