#!/bin/bash


cmdclick_uninstall(){
	local usrlocalbin_dir_path="/usr/local/bin"
	
	sudo rm -rf \
	"${usrlocalbin_dir_path}/linux"

	sudo rm -rf \
	"${usrlocalbin_dir_path}/win"

	sudo rm -rf \
	"${usrlocalbin_dir_path}/cmdclick"

	sudo rm -rf \
	"${usrlocalbin_dir_path}/c"
}

