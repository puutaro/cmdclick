#!/bin/bash

mv_ini_file_when_rename(){
	local ini_rename_file_name="${1}"
	local edit_file_name="${2}"
	local edit_file_dir_path="${3}"
	case "${ini_rename_file_name}" in 
		"${edit_file_name}") return;; esac
	case "${ini_rename_file_name}" in 
		"") return;; esac
	echo "${edit_file_dir_path}/${ini_rename_file_name}"
	mv "${edit_file_dir_path}/${edit_file_name}" \
		"${edit_file_dir_path}/${ini_rename_file_name}"
}