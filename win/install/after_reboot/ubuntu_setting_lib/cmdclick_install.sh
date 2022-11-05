#!/bin/bash


cmdclick_install(){
	local windows_home_path="${1}"
	local usrlocalbin_dir_path="/usr/local/bin"
	local cmdclick_section_path="${windows_home_path}/cmdclick"
	local config_lxterminal_dir_path="${HOME}/.config/lxterminal"

	mkdir -p "${config_lxterminal_dir_path}"
	sudo cp -arvf \
	"${cmdclick_section_path}/win/install/files/lxterminal"/* \
	"${config_lxterminal_dir_path}/"

	sudo cp -arvf \
	"${cmdclick_section_path}/linux" \
	"${usrlocalbin_dir_path}/"
	sudo cp -arvf \
	"${cmdclick_section_path}/win" \
	"${usrlocalbin_dir_path}/"

	local temp_file_path="$HOME/temp_file"
	local usrlocalbin_cmdclick="${usrlocalbin_dir_path}/cmdclick"
	sudo cat <<- 'EOF' > "${temp_file_path}"
	#!/bin/bash

	bash "$(dirname $0)/win/srcs/cmdclick_dir/exec_cmdclick.sh"
	EOF
	sudo cp -arvf \
		"${temp_file_path}" \
		"${usrlocalbin_cmdclick}"
	sudo chmod +x "${usrlocalbin_cmdclick}"

	sudo ln -s \
		"${usrlocalbin_cmdclick}" \
		"${usrlocalbin_dir_path}/c"
}

