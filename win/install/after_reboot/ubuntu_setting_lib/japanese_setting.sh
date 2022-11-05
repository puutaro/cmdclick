#!/bin/bash


japanese_setting(){
	#Ubuntu側から、Windows側にあるフォントを扱えるようにする
	read -ep "Do you want to set Japanese to wsl ? (y/n)" confirm
	case "${confirm}" in 
		"y") ;; 
		*) return
	;; esac
	cat <<- 'EOS' | sudo tee /etc/fonts/local.conf
	<?xml version="1.0"?>
	<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
	<fontconfig>
	    <dir>/mnt/c/Windows/Fonts</dir>
	</fontconfig>
	<!-- Created by bash script from https://astherier.com/blog/2021/07/windows11-wsl2-wslg-japanese/ -->
	EOS

	#日本語パックを入れて、ロケールをja_jpにする
	#これ以降、コマンドラインのエラー表示なども日本語になります。
	sudo apt -y install language-pack-ja
	sudo update-locale LANG=ja_JP.UTF8

	#FcitxとMozcをインストールし、関連の設定をします。
	sudo apt install -y fcitx-mozc dbus-x11
	sudo sh -c "dbus-uuidgen > /var/lib/dbus/machine-id"

	local profile_file_path="$HOME/.profile"
	local exist_gui_set="$(\
		cat "${profile_file_path}" \
		| grep -i "Added by bash script from"\
	)"
	case "${exist_gui_set}" in 
		"") 
	cat <<- 'EOS' | tee -a "${profile_file_path}"
	#Added by bash script from https://astherier.com/blog/2021/07/windows11-wsl2-wslg-japanese/
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	export DefaultIMModule=fcitx
	if [ $SHLVL = 1 ] ; then
	  (fcitx-autostart > /dev/null 2>&1 &)
	  xset -r 49  > /dev/null 2>&1
	fi
	#Added by bash script: end
	EOS
		;; esac

	local exist_display_envcat="$(\
		cat "${profile_file_path}" \
		| grep -i "export DISPLAY=\$(cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'):0.0"\
	)"
	case "${exist_display_envcat}" in 
		"") echo "export DISPLAY=\$(cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'):0.0" \
				>> "${profile_file_path}"
	;; esac

	im-config -n fcitx
	sed -i "/EnabledIMList/s/mozc:False/mozc:True/g" ~/.config/fcitx/profile
	fcitx-configtool mozc
	wsl.exe -t Ubuntu-20.04
}
