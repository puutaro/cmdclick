#!/bin/bash


install_requirement_package_for_cmdclick(){
	sudo apt update -y && sudo apt upgrade -y && \
	sudo apt install -y lxterminal yad
	sudo apt install -y xdotool xclip fd-find colordiff rcs git zip unzip && \
	sudo ln -s $(which fdfind) "/usr/local/bin/fd"
	git clone https://github.com/junegunn/fzf.git "$HOME/.fzf" && yes | "$HOME/.fzf/install"
	sudo apt install ripgrep pandoc poppler-utils ffmpeg -y &&
	wget -O - "https://github.com/phiresky/ripgrep-all/releases/download/v0.9.6/ripgrep_all-v0.9.6-x86_64-unknown-linux-musl.tar.gz" | tar zxvf - && sleep 3 &&  sudo mv ripgrep_all-v0.9.6-x86_64-unknown-linux-musl/rga* "/usr/local/bin"
}