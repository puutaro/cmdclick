#!/bin/bash


cmdclick_install(){
	local windows_home_path="${1}"
	local usrlocalbin_dir_path="/usr/local/bin"
	local cmdclick_section_path="${windows_home_path}/cmdclick"

	local cmdclick_files_path="${cmdclick_section_path}/win/install/files"
	local config_lxterminal_dir_path="${HOME}/.config/lxterminal"
	mkdir -p "${config_lxterminal_dir_path}"
	sudo cp -arvf \
		"${cmdclick_files_path}/lxterminal"/* \
		"${config_lxterminal_dir_path}/"

	local config_gtk30_dir_path="${HOME}/.config/gtk-3.0"
	mkdir -p "${config_gtk30_dir_path}"
	sudo cp -arvf \
		"${cmdclick_files_path}/gtk30"/* \
		"${config_gtk30_dir_path}/"

	sudo cp -arvf \
		"${cmdclick_section_path}/linux" \
		"${usrlocalbin_dir_path}/"
	sudo cp -arvf \
		"${cmdclick_section_path}/win" \
		"${usrlocalbin_dir_path}/"

	local usrlocalbin_cmdclick="${usrlocalbin_dir_path}/cmdclick"
	sudo cp -arvf \
		"${cmdclick_section_path}/win/srcs/cmdclick" \
		"${usrlocalbin_cmdclick}"

	sudo chmod +x "${usrlocalbin_cmdclick}"

	sudo ln -s \
		"${usrlocalbin_cmdclick}" \
		"${usrlocalbin_dir_path}/c"
}
