#!/bin/bash


echo_err_message_by_forbidden_string_exist(){
	local create_chdir_path="${1}"
	echo "${create_chdir_path}" \
		| awk -v HOME="${HOME}" '
		function output_forbidden_str_err(\
			target_str, \
			err_message \
		){
			forbidden_str="\x5C\x74\x5C\x74- forbidden "
			if($0 ~ target_str){
				printf forbidden_str" "err_message"\x5C\x6E"
			}
		}
		function replace_path_and_discover_home_dir_path(\
			home_dir_name \
		){
			discover_count = 0
			if($0 ~ home_dir_name) {
				discover_count++
			}
			return discover_count
		}
		BEGIN{
			count_home_dir_in_path = 0
		}
		{
			hat_user_dir_path="^"HOME
			count_home_dir_in_path += replace_path_and_discover_home_dir_path(hat_user_dir_path)
			gsub(hat_user_dir_path, "", $0)
			hat_home_dir_path_curly_brackets="^\${HOME}"
			count_home_dir_in_path += replace_path_and_discover_home_dir_path(hat_home_dir_path_curly_brackets)
			gsub(hat_home_dir_path_curly_brackets, "", $0)
			hat_home_dir_path="^\$HOME"
			count_home_dir_in_path += replace_path_and_discover_home_dir_path(hat_home_dir_path)
			gsub(hat_home_dir_path, "", $0)
			if (!count_home_dir_in_path){ 
				printf "\t\t- not "HOME" bellow path""\x5C\x6E"
			}
			output_forbidden_str_err("\x60", "back_quote")
			output_forbidden_str_err("\x22", "double_quote")
			output_forbidden_str_err("\x2F\x27", "prefix_single_quote")
			output_forbidden_str_err("\x27\x24", "suffix_single_quote")
			output_forbidden_str_err("\x21", "exclamation_mark")
			output_forbidden_str_err("\x7E", "tilde")
			output_forbidden_str_err("\x2C", "comma")
			output_forbidden_str_err("\x5C\x5C", "back_slash")
			output_forbidden_str_err("\x5C\x24", "dollar")
			output_forbidden_str_err("\x2F\x20", "prefix_space")
			output_forbidden_str_err("\x20\x24", "suffix_space")
			output_forbidden_str_err("\x2F　", "prefix_zenkaku_space")
			output_forbidden_str_err("　\x24", "suffix_zenkauk_space")
			output_forbidden_str_err("\x5B\x7C\x5D", "vertical_ver")
			output_forbidden_str_err("\x5E\x5B\x5E/\x2F\x5D", "path prefix other than slash")
		}'
}