#!/bin/bash


display_file_select_manager(){
	set +e
	yad \
	--file \
	--title="${WINDOW_TITLE}" \
	--window-icon="${WINDOW_ICON_PATH}" \
	--filename="${HOME}"\
	--file-filter='sh file | *.sh' \
	--multiple \
	--separator="\n" \
	--maximized \
	--add-preview 
	set -e
}
