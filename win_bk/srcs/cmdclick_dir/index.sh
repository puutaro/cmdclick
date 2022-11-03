#!/bin/bash


get_inc_dir_file(){
	#echo "CMDCLICK_APP_LIST_PATH: ${CMDCLICK_CONF_DIR_PATH}" >> "${CMDCLICK_APP_LIST_PATH}"
	local sed_cmdclick_conf_dir_path=$(echo "${CMDCLICK_CONF_DIR_PATH}" | sed 's/\//\\\//g')
	#echo "sed_cmdclick_conf_dir_path: ${sed_cmdclick_conf_dir_path}" >> "${CMDCLICK_APP_LIST_PATH}"
	local change_dir_path_list=($(ls -t "${CMDCLICK_CONF_DIR_PATH}" | grep "${COMMAND_CLICK_EXTENSION}" | sed -e 's/^/'${sed_cmdclick_conf_dir_path}'\//g' -e '/^$/d'))
	local change_dir_path=$(cat ${change_dir_path_list[@]} | grep "^${CH_DIR_PATH}=" | sed -e 's/^'${CH_DIR_PATH}'\=//' -e '/^$/d')
	eval "echo \"${change_dir_path}\""  > "${CMDCLICK_APP_LIST_PATH}"
	}

get_inc_dir_file &

# lecho "BEFORE INDEX INDEX_CODE: ${INDEX_CODE}"
LOOP=0
cur_inc=1
echo "${GREP_INC_NUM}=${cur_inc}" > "${CMDCLICK_CONF_INC_CMD_PATH}" &
wait
SECONDS_INI_FILE_DIR_PATH=$(cat "${CMDCLICK_APP_LIST_PATH}" | sed -n ''${cur_inc}'p')
if [ ! -e "${SECONDS_INI_FILE_DIR_PATH}" ];then 
	INI_FILE_DIR_PATH="${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}";
else 
	INI_FILE_DIR_PATH="${SECONDS_INI_FILE_DIR_PATH}"; 
fi
# lecho "index:1:cur_inc: ${cur_inc}"
# lecho "SECONDS_INI_FILE_DIR_PATH:-0: ${SECONDS_INI_FILE_DIR_PATH}"
# lecho "index:INI_FILE_DIR_PATH:0:${INI_FILE_DIR_PATH}"
#CMDCLICK_CD_FILE_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_CHANGE_DIR_CMD}"
#CMDCLICK_DELETE_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_DELETE_CMD}"
#CMDCLICK_ADD_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_ADD_CMD}"
# CMDCLICK_EDIT_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_EDIT_CMD}"
#CMDCLICK_RESOLUTION_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_RESOLUTION_CMD}"
#if [ ! -e "${CMDCLICK_CD_FILE_PATH}" ];then touch "${CMDCLICK_CD_FILE_PATH}"; fi
#if [ ! -e "${CMDCLICK_DELETE_CMD_PATH}" ];then touch "${CMDCLICK_DELETE_CMD_PATH}"; fi
#if [ ! -e "${CMDCLICK_ADD_CMD_PATH}" ];then touch "${CMDCLICK_ADD_CMD_PATH}"; fi
#if [ ! -e "${CMDCLICK_EDIT_CMD_PATH}" ];then touch "${CMDCLICK_EDIT_CMD_PATH}"; fi
#if [ ! -e "${CMDCLICK_RESOLUTION_CMD_PATH}" ];then touch "${CMDCLICK_RESOLUTION_CMD_PATH}"; fi


#index立ち上げ
INDEX_TITLE_TEXT_MESSAGE=${INDEX_SELECT_CMD_MESSAGE}
wait
input_cmd_index ${INI_FILE_DIR_PATH}
# lecho "AFTER_INDEX SIGNAL_CODE: ${SIGNAL_CODE}"
