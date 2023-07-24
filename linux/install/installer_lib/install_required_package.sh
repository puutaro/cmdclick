#!/bin/bash


install_required_package(){
	local usrlocalbin_path="${1}"
	local files_lib_path="${2}"
	sudo apt update -y \
	&& sudo apt upgrade -y && \
	sudo apt install -y lxterminal yad wmctrl gconf2 x11-xserver-utils
	gconftool-2 \
		--set /apps/metacity/general/focus_new_windows \
		--type string smart
	sudo apt install -y xdotool xclip && \
	sudo apt install -y fzf
	local lxterminal_conf_file_name="lxterminal.conf"
	local lxterminal_par_dir_path="${HOME}/.config/lxterminal"
	local lxterminal_conf_file_path="${lxterminal_par_dir_path}/${lxterminal_conf_file_name}"
	if [ ! -e "${lxterminal_conf_file_path}" ]; then
		mkdir -p "${lxterminal_par_dir_path}"
		cp -avf \
			"${files_lib_path}/${lxterminal_conf_file_name}" \
			"${lxterminal_conf_file_path}"
	else 
		sed -e 's/disablealt=.*/disablealt=true/' -i "${lxterminal_conf_file_path}"
	fi
}
