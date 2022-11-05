#!/bin/bash


replace_home_dir_path_by_tilde(){
	local path="${1}"
	echo "${path}" \
		| awk -v HOME="${HOME}" \
			'{
				if(\
					gsub(HOME, "~", $0) \
				) print $0
			}'
}