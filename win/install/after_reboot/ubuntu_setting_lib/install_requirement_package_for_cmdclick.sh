#!/bin/bash


install_requirement_package_for_cmdclick(){
	sudo apt update -y \
	&& sudo apt upgrade -y && \
	sudo apt install -y lxterminal yad xdotool xclip
	sudo apt install -y fzf
}