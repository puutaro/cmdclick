#!/bin/bash

cmd_click_startup_target_app(){
	local app_name="${1}"
	open -a "${app_name}"
}

cmd_click_startup_source_app(){
	local app_name="${1}"
	local paste_con=$(pbpaste)
	echo "bash ${START_APP_PROCCESS_PATH}" | tr -d '\n' | pbcopy
	open -a "${app_name}"
	local check_cmdclick="$(ps aux | grep "${START_APP_PROCCESS_PATH}" | grep -v grep )"
	if [ -z "${check_cmdclick}" ];then
		osascript -e "
		tell application \"${app_name}\"
	  		tell application \"System Events\" 
	  			keystroke \"v\" using command down
	  			keystroke return
	  		end tell
	  	end tell
	  "
	fi
	echo -n "${paste_con}" | pbcopy
}

maximize_app(){
	local app_name="${1}"
	# if [ -e ${CMDCLICKL_SETTUING_FILE_PATH} ];then
	# 	setting_con=$(cat "${CMDCLICKL_SETTUING_FILE_PATH}")
	# 	width=$(echo "${setting_con}" | grep "${CMDCLICK_SETTING_ITEM_WODTH}=" | sed 's/'${CMDCLICK_SETTING_ITEM_WODTH}'\=//')
	# else 
	# 	width=${STARTUP_SETTING_RESOLUTION}
	# fi
	setting_source=$(system_profiler SPDisplaysDataType  | grep -B 5 -i "Main Display: Yes")
	width=$(echo "${setting_source}" | grep Resolution | awk '{print $2}')
	check_retina=$(echo "${setting_source}" | grep Resolution | grep Retina )
	if [ -n "${check_retina}" ];then width=$(((${width} * 100) / 178)) ;fi
	#width=$(system_profiler SPDisplaysDataType | grep Resolution | tail -n 1 | awk '{print $2}')
	multiple_source=$(echo "${setting_source}" | grep Resolution | tail -n 1)
	#multiple_source=$(system_profiler SPDisplaysDataType | grep Resolution | tail -n 1)
	height=$(echo "${multiple_source}" | awk '{print $4}')
	x_posi=0
	y_posi=0
	x_posi2=${width}
	y_posi2=${height}
	osascript \
	-e "tell application \"${app_name}\" 
	activate
	ignoring application responses
	set bounds of front window to {${x_posi}, ${y_posi}, ${x_posi2}, ${y_posi2}}
	end ignoring
	end tell"
}
