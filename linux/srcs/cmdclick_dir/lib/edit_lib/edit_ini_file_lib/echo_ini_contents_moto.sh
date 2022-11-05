#!/bin/bash

echo_ini_contents_moto(){
	local roop_num="${1}"
	local ini_contents="${2}"
	local edit_file_name="${3}"
	case "${roop_num}" in  
		"1") 
			local sed_edit_file_name=$(\
					echo "${edit_file_name}" \
						| sed -r 's/([^a-zA-Z0-9_-])/\\\1/g' \
				)
			cat "${EDIT_FILE_PATH}" \
				| sed "s/^${INI_CMD_FILE_NAME}=.*/${INI_CMD_FILE_NAME}=${sed_edit_file_name}/"
			return
	;; esac
    echo "${ini_contents}" | sed 's/\\\\/\\/g'
}