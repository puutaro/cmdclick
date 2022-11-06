#!/bin/bash


upgrade_app_dir_list_order(){
	local ini_file_dir_path="${1}"
	case ${ini_file_dir_path} in 
		""|"${CMDCLICK_APP_DIR_PATH}") 
			return;;
	esac
	local hit_app_dir_file=$(\
			get_hit_app_dir_file \
				"${ini_file_dir_path}" \
		)
	if [ ! -e "${hit_app_dir_file}" ]; then return; fi
	touch "${hit_app_dir_file}"
	echo "${GREP_INC_NUM}=1" > "${CMDCLICK_CONF_INC_CMD_PATH}"
}


get_hit_app_dir_file(){
	local ini_file_dir_path="${1}"
	local sed_home_path=$(\
		echo "${HOME}" \
		| sed 's/\//\\\//g' \
	)
	local hit_app_dir_file=$(\
		grep "${ini_file_dir_path}" -rl "${CMDCLICK_APP_DIR_PATH}" \
		| head -n 1 \
		|| e=$? \
	)
	case "${hit_app_dir_file}" in 
 		"");;
		*)  echo "${hit_app_dir_file}"
			return ;; esac	
	local grep_path1=$(\
		echo "${ini_file_dir_path}" \
		| sed 's/'${sed_home_path}'/\\$\\{HOME\\}/' \
	)
	hit_app_dir_file=$(\
		grep "${grep_path1}" -rl "${CMDCLICK_APP_DIR_PATH}" \
		| head -n 1 \
		|| e=$? \
	)
	case "${hit_app_dir_file}" in
		"");;  
		*)  echo "${hit_app_dir_file}"
			return ;; esac
	local grep_path2=$(\
		echo "${ini_file_dir_path}"  \
		| sed 's/'${sed_home_path}'/\\$HOME/' \
	)
	hit_app_dir_file=$(
		grep "${grep_path2}" -rl "${CMDCLICK_APP_DIR_PATH}" \
		| head -n 1 \
		|| e=$? \
	)
	echo "${hit_app_dir_file}"
}
