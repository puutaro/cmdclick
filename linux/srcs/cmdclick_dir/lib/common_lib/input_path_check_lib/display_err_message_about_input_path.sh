#!/bin/bash

display_err_message_about_input_path(){
	local LANG="ja_JP.UTF-8"
	local input_chdir_path=${1}
	local add_cmd_base="${2}"
	local err_message_about_create_chdir_path=$(echo "${3}")
	local display_create_chdir_path=$(\
		echo "${input_chdir_path}" \
			| sed -re 's/([^a-zA-Z0-9_])/\\\1/g' \
				-e 's/\&/\&amp;/g' \
				-e 's/</\&lt;/g' \
				-e 's/>/\&gt;/g' \
				-e 's/"/\&quot;/g' \
				-e "s/'/\&apos;/g"\
	)
	eval "${add_cmd_base} \
		--field=\"\n type path is illegular \n\tpath: "${display_create_chdir_path}" \n\t[err factor]\n${err_message_about_create_chdir_path} \n\n\":LBL"	
}