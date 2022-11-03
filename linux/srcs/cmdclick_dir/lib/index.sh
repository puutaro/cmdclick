#!/bin/bash

LANG=C
LOOP=0

index_lib_dir_path="${LIB_DIR_PATH}/index_lib"
. "${index_lib_dir_path}/get_inc_dir_file.sh"
unset -v index_lib_dir_path


reactive_when_aleady_exist_cmdclick
get_inc_dir_file &
first_index_num_in_app_dir_list=1
echo "${GREP_INC_NUM}=${first_index_num_in_app_dir_list}" > "${CMDCLICK_CONF_INC_CMD_PATH}" &
wait
INI_FILE_DIR_PATH=$(\
	cat "${CMDCLICK_APP_LIST_PATH}" \
	| sed -n ''${first_index_num_in_app_dir_list}'p'\
)
unset -v first_index_num_in_app_dir_list
if [ ! -e "${INI_FILE_DIR_PATH}" ];then 
	mkdir -p "${INI_FILE_DIR_PATH}";
fi
#index立ち上げ
INDEX_TITLE_TEXT_MESSAGE=${INDEX_SELECT_CMD_MESSAGE}
input_cmd_index
