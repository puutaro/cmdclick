#!/bin/bash

edit_ini_gui(){
  roop_num=0
  ini_contents=""
  EDIT_FILE_NAME="$1"
  EDIT_FILE_PATH="${INI_FILE_DIR_PATH}/$1"
  while :
  do
    roop_num=$((${roop_num} + 1))
    if [ ${roop_num} -eq 1 ];then 
      local ini_contents_moto=$(cat "${EDIT_FILE_PATH}");
      ini_contents_moto=$(echo "${ini_contents_moto}" | sed -r 's/('${INI_CMD_FILE_NAME}')=.*/\1='${EDIT_FILE_NAME}'/')
    elif [ ${roop_num} -ge 2 ];then
      # lecho "edit_ini_gui: ini_contents: ${ini_contents}" 
      local ini_contents_moto=$(echo "${ini_contents}");
    fi
    # lecho  "ini_contents:edit:0.3: ${ini_contents}"
    make_ini_contensts "${ini_contents_moto}"
    if [ ${SIGNAL_CODE} -eq ${EXIT_CODE} ] || [ ${SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ]; then break; fi
    # lecho  "ini_contents:edit:0.5: ${ini_contents}"
    display_edit_contensts
    if [ ${SIGNAL_CODE} -eq ${EXIT_CODE} ] || [ ${SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ]; then break; fi
    # lecho "ini_value: ${ini_value}"
    # lecho  "ini_contents:edit:1: ${ini_contents}"
    if [ ${roop_num} -eq 1 ];then
      # lecho "roop_full_ecit=1"
      local full_edit_on=$(echo "${ini_value}" | tail -n 1) ;
      ini_value=$(echo "${ini_value}" | sed '$d')
      if [ "${full_edit_on}" != "0" ];then SIGNAL_CODE=${EDIT_FULL_CODE}; fi
    fi
    # lecho "ini_value2: ${ini_value}"
    # lecho "SIGNAL_CODE: ${SIGNAL_CODE}"
    convert_input_value "${ini_value}"
    check_ini_file "${ini_contents}" "stdout"
    # lecho "SIGNAL_CODE: ${SIGNAL_CODE}"
    if [ ${SIGNAL_CODE} -eq ${CHECK_ERR_CODE} ];then roop_num=$(( ${roop_num} - 1 )); continue; fi
    if [ ${SIGNAL_CODE} -eq ${EDIT_FULL_CODE} ];then continue; fi
    # lecho  "ini_contents:edit:2: ${ini_contents}"
    # lecho  "ini_contents:edit:3: ${ini_contents}" 
    case "${EXEC_INPUT_EXECUTE}" in
      "") confirm_edit_contensts "${ini_contents}" ;;
      *) CONFIRM=0 ;;
    esac

    # lecho "${ini_contents}" 
    # lecho ${CONFIRM}
    #yad用入力値反映イニファイル内容を作成
    if [ "${CONFIRM}" -eq 1 ]; then
      # lecho "ok, please re-editting" 
      if [ ${roop_num} -le 1 ];then roop_num=0;fi
    elif [ "${CONFIRM}" -eq 0 ]; then
      # lecho "ok, saving edited"
      # lecho "${INI_CMD_FILE_NAME}"
      local ini_rename_file_name=$(echo "${ini_contents}" | grep "${INI_CMD_FILE_NAME}="| cut -d= -f2)
      # lecho ini_rename_file_name
      # lecho "${ini_rename_file_name}"
      # lecho ini_contents_bsla_before
      # lecho "${ini_contents}"
      #backslachを四個を一つに戻す
      ini_contents=$(echo "${ini_contents}")
      # lecho ini_contents_bsla_after
      # lecho "${ini_contents}"
      if [ "${ini_rename_file_name}" != "${EDIT_FILE_NAME}" ]; then
        mv "${EDIT_FILE_PATH}" "${INI_FILE_DIR_PATH}/${ini_rename_file_name}"
        EXECUTE_FILE_PATH="${INI_FILE_DIR_PATH}/${ini_rename_file_name}"
      fi
        echo "${ini_contents}" > "${INI_FILE_DIR_PATH}/${ini_rename_file_name}" &
        touch "${INI_FILE_DIR_PATH}/${ini_rename_file_name}" &
      break
    else
      break
    fi
  done

}