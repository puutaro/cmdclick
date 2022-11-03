#!/bin/bash


uninstall_cmdclick(){
	local usrlocalbin="${1}"
	local usrshareapp_dir_path="/usr/share/applications"

	sudo rm -rf \
		"${usrlocalbin}/cmdclick_dir" \
		"${usrlocalbin}/cmdclick" \
		"${usrlocalbin}/c" \
		"${usrshareapp_dir_path}/cmdclick.desktop"
}