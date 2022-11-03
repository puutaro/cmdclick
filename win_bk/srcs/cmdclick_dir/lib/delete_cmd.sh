#!/bin/bash

delete_cmd(){
  center_box
  local delete_contents=$(cat "${DELETE_FILE_PATH}")
  # lecho "${delete_contents}"
  local delete_contents=$(echo "${delete_contents::1500}")
	# lecho delete_contents1
	# lecho "${delete_contents}"
  local delete_message="Do you really want to delete bellow ini file ?"
  local delete_contents="$(echo "${delete_contents}" | sed -e "s/${CMDCLICK_N_CAHR}/n/g" -e 's/'${CMDCLICK_BACKSLASH_MARK}'/\\/g' -e 's/'${CMDCLICK_ONE_BACKSLASH_MARK}'/\\/g')"
  local delete_message=$(cat <(echo " ") <(echo ${delete_message}) <(echo " ") <(echo ${delete_contents}))
  wait
  exec 3>&1
  local VALUE=$(dialog --title "${WINDOW_TITLE}"  --no-shadow --menu "${delete_message}" ${box_size[@]} \
  select "y or n" \
  2>&1 1>&3)
  # close fd
  exec 3>&-
  clear
  if [ -n "${VALUE}" ];then 
    if [ "${CHDIR_SIGNAL_CODE}" == "${DELETE_CODE}" ];then
        local delete_dir_path=$(cat "${DELETE_FILE_PATH}" | grep "^${CH_DIR_PATH}=" | head -n 1 | sed 's/^'${CH_DIR_PATH}'\=//')
        local cd_delete_message=$(cat <(echo " ") <(echo "Would you like to delete bellow APP dir ?") <(echo " ") <(echo -e "\t${delete_dir_path}"))
        exec 3>&1
        local CD_DEL_VALUE=$(dialog --title "${WINDOW_TITLE}"  --no-shadow --menu "${cd_delete_message}" ${box_size[@]} \
                          select "y or n" 2>&1 1>&3)
        exec 3>&-
        echo "${CD_DEL_VALUE}"
        local delete_dir_path=$(eval "echo ${delete_dir_path}")
        if [ -n "${CD_DEL_VALUE}" ];then 
          rm -rf ${delete_dir_path};
          local sed_ch_dir_path=$(echo ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} | sed 's/\//\\\//g')
          sed -i 's/^'${GREP_SECONDS_INI_FILE_DIR_PATH}'\=.*/'${GREP_SECONDS_INI_FILE_DIR_PATH}'\='${sed_ch_dir_path}'/' "${CMDCLICK_PROPERTY_FILE_PATH}"
        fi
    fi
    rm -f "${DELETE_FILE_PATH}";fi
}
