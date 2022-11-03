#!/bin/bash

delete_app_dir(){
	local confirm_app="${1}"
	local delete_dir_path=$(eval "echo ${delete_dir_path}")
	case "${confirm_app}" in 
		"${OK_CODE}") rm -rf "${delete_dir_path}";;
	esac
}