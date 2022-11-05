#!/bin/bash


echo_by_remove_pre_or_suffix_single_quote(){
	local target_path_str="${1}"
	echo ${target_path_str} \
		| sed  -e "s/^'//g" \
			-e "s/'$//g" \
			-e "s/'\\\\'//g"
}
