#!/bin/bash

echo_ini_contents_moto(){
	local roop_num="${1}"
	local ini_contents="${2}"
	case "${roop_num}" in  
		"1") cat "${EDIT_FILE_PATH}"
			 return
	;; esac
    echo "${ini_contents}" | sed 's/\\\\/\\/g'
}