#!/bin/bash


install_sublime(){
	local usrlocalbin_path="${1}"
	local files_lib_path="${2}"
	sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - ;
	sudo echo 'deb https://download.sublimetext.com/ apt/stable/' | sudo tee /etc/apt/sources.list.d/sublime-text.list;
	sudo apt-get update -y;
	sudo apt-get install sublime-text -y ;
	sudo ln -s /opt/sublime_text/sublime_text ${usrlocalbin_path}/subl
	local sublime_preference_file_name="Preferences.sublime-settings"
	local sublime_preference_par_dir_path="${HOME}/.config/sublime-text/Packages/User"
	local sublime_preference_file_path="${sublime_preference_par_dir_path}/${sublime_preference_file_name}"
	sudo apt-get install -y fonts-ricty-diminished
	if [ ! -e "${sublime_preference_file_path}" ]; then
		mkdir -p "${sublime_preference_par_dir_path}"
		cp -avf \
			"${files_lib_path}/${sublime_preference_file_name}" \
			"${sublime_preference_file_path}"
	fi
}
