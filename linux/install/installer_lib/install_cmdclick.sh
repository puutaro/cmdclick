#!/bin/bash


install_cmdclick(){
	local usrlocalbin="${1}"
	local cmdclick_linux_srcs_dir_path="${2}"
	local files_lib_path="${3}"

	sudo cp -arvf \
		"${cmdclick_linux_srcs_dir_path}"/* \
		"${usrlocalbin}"/
	sudo chmod -R +x "${usrlocalbin}"/

	sudo ln -s \
		"${usrlocalbin}/cmdclick" \
		"${usrlocalbin}/c"

	local usrshareapp_dir_path="/usr/share/applications"
	sudo cp -arf \
		"${files_lib_path}/cmdclick.desktop" \
		"${usrshareapp_dir_path}"/
	local cmdclick_png_file_name="cmdclick_image.png"
	local cmdclick_png_file_path="/usr/share/icons/${cmdclick_png_file_name}"
	sudo cp -arvf \
		"${cmdclick_linux_srcs_dir_path}/cmdclick_dir/images/${cmdclick_png_file_name}" \
		"${cmdclick_png_file_path}"
}