#!/bin/bash

echo_ini_file_name(){
	local create_chdir_path="${1}"
	echo "${create_chdir_path}" \
		| sed -e 's/["`${},~$\|]//g' \
			-e 's/\//\_/g' \
			-e 's/^\_//' \
			-e 's/^/cd\_/' \
			-e 's/$/'${COMMAND_CLICK_EXTENSION}'/'
}