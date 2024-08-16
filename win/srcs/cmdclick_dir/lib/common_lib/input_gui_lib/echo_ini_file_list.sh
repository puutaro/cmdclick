#!/bin/bash

echo_ini_file_list(){
	local ini_file_dir_path="${1}"
	local display_ini_file_dir_path="${2}"
	ls -tl "${ini_file_dir_path}" \
	| awk \
		-v ini_file_dir_path="${ini_file_dir_path}" \
		-v display_ini_file_dir_path="${display_ini_file_dir_path}" \
		'
		BEGIN {
			print "["display_ini_file_dir_path"]"
			display_count = 0
		}
		{
			nine_field_later_str=substr($0, index($0, $9), length($0))
			gsub(/\x2A$/, "", nine_field_later_str)
			if(!match(nine_field_later_str, /\.sh$/)) next
			print nine_field_later_str"\t"ini_file_dir_path
			display_count++
		}
		END {
			if(!display_count) print "-\t"ini_file_dir_path
		}'
}