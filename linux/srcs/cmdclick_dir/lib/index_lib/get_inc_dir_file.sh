#!/bin/bash


get_inc_dir_file(){
	local sed_home="${HOME//\//\\\/}"
	local change_dir_path_con=$(\
		ls -tl "${CMDCLICK_APP_DIR_PATH}" \
		| awk -v CMDCLICK_APP_DIR_PATH="${CMDCLICK_APP_DIR_PATH}" \
		'
		{
			file_name = substr($0, index($0, $9), length($0))
			gsub(/^\x27/, "", file_name)
			gsub(/\x27$/, "", file_name)
			if(!match(file_name, /\.sh$/)) next
			print "cat \x22"CMDCLICK_APP_DIR_PATH"/"file_name"\x22"
		}'
	)
	local change_dir_path=$(\
		bash -c "${change_dir_path_con}" \
		| fetch_parameter_from_pip "${CH_DIR_PATH}" \
		| sed -e 's/$HOME/'${sed_home}'/' \
			-e 's/${HOME}/'${sed_home}'/' \
			-e 's/^"//' \
			-e 's/"$//' \
	)
	echo "${change_dir_path}"  > "${CMDCLICK_APP_LIST_PATH}"
	}
