#!/bin/bash


install_requirement_package_for_cmdclick(){
	sudo apt update -y \
	&& sudo apt upgrade -y && \
	sudo apt install -y lxterminal yad xdotool xclip
	git clone https://github.com/junegunn/fzf.git "$HOME/.fzf" \
	&& yes \
	| "$HOME/.fzf/install"
}