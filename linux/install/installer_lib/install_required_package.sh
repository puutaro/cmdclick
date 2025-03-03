#!/bin/bash


install_required_package(){
	local usrlocalbin_path="${1}"
	local files_lib_path="${2}"
	local e=""
	sudo apt-get update -y \
	&& sudo apt-get upgrade -y && \
	sudo apt-get install -y lxterminal yad wmctrl x11-xserver-utils
	sudo apt-get install -y gconf2 || e=$?
	gconftool-2 \
		--set /apps/metacity/general/focus_new_windows \
		--type string smart
	sudo apt-get install -y xdotool xclip && \
	readonly fzf_download_dir_path="${files_lib_path}/.fzf"
	git clone https://github.com/junegunn/fzf.git "${fzf_download_dir_path}" \
	&& yes | "${fzf_download_dir_path}/install"
	rm -rf "${fzf_download_dir_path}"
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
