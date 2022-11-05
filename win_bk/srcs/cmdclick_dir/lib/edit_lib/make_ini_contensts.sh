#!/bin/bash

make_ini_contensts(){
  source_cmd=""
  local ini_contents_moto="${1}"
  ini_contents="${ini_contents_moto}"
  # lecho "${ini_contents}"
  case "${roop_num}" in 
    "1")
        case "${EXEC_IN_EXE_DFLT_VL}" in 
          "") local source_con=$(echo "${ini_contents_moto}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | grep "^[a-zA-Z0-9_-]\{1,100\}=")
            ;;
          *)
            local source_con=$(eval "echo \"\${ini_contents_moto}\" ${EXEC_IN_EXE_DFLT_VL}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | grep "^[a-zA-Z0-9_-]\{1,100\}=")
            ;;
        esac
        all_key_con=$(echo "${source_con}" | cut -d= -f1)
        local get_valiable=$(cat  <(echo "${source_con}") <(echo "${FULL_EDIT_BOOL}=0") | sed -e '/^$/d' -e 's/\=$/=-/' | nl | sed -e 's/\=/\t/' -re "s/\ *([0-9]{1,5})\t([a-zA-Z0-9_-]{1,100})\t(.*)/\2\t\1\t1\t\3\t\1\t${SCHEME_CHAR_NUME}\t${EDIT_CHAR_NUM}\t0/g" | tr '\n' '\t')
        ;; esac

  local check_only_full_edit_bool_field=$(echo "${source_con}" | grep -v "${FULL_EDIT_BOOL}" | sed '/^$/d' | wc -l)
  if [ -z "${get_valiable}" ] || [ ${check_only_full_edit_bool_field} -eq 0 ];then
    roop_num=2
  fi

  if [ ${roop_num} -ge 2 ];then
    local source_con=$(cat <(echo "${ini_contents_moto}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed -e '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' -e '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | grep "^[a-zA-Z0-9_-]\{1,100\}=") <(echo "${ini_contents_moto}" | sed -n '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/,/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/p' | sed -e '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/d' -e '/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/d' | grep "^[a-zA-Z0-9_-]\{1,100\}=") | sed '/^$/d')
    if [ ${roop_num} -eq 2 ];then 
      source_con=$(echo "${source_con}" | sed 's/^'${INI_CMD_FILE_NAME}'\=.*/'${INI_CMD_FILE_NAME}'='${EXECUTE_FILE_NAME}'/' ) 
    fi

    all_key_con=$(echo "${source_con}" | cut -d= -f1)
    local get_valiable=$(echo "${source_con}" | sed 's/\=$/=-/' | nl | sed -e 's/\=/\t/' -re "s/\ *([0-9]{1,5})\t([a-zA-Z0-9_-]{1,100})\t(.*)/\2\t\1\t1\t\3\t\1\t${SCHEME_CHAR_NUME}\t${EDIT_CHAR_NUM}\t0/g" | tr '\n' '\t')
  fi
  # lecho "check_only_full_edit_bool_field: ${check_only_full_edit_bool_field}"
  # lecho "source_con: ${source_con}"
  source_cmd=$(echo "${ini_contents_moto}" | grep -v "^#" | grep -v "^[a-zA-Z0-9_-]\{1,100\}=" | sed '/^$/d')

  # lecho all_key_con
  # lecho "${all_key_con}"
  # lecho get_valiable
  # lecho "${get_valiable}"
  local IFS=$'\t'; get_cmd_valiable_list=($(echo "${get_valiable}"))
  # lecho "get_cmd_valiable_list"
  # lecho ${get_cmd_valiable_list[@]}
  # lecho ${#get_cmd_valiable_list[@]}
  local IFS=$' \t\n'
  # valudate 
  local status_code=0
  # lecho "status_code1: ${status_code}"
  local get_valiable_nr=$(echo "${get_valiable}" | tr '\t' '\n')
  echo "${get_valiable_nr}" |  awk 'NR%8==3 || NR%8==6 || NR%8==7 || NR%8==0' | sort | uniq | wc -l  | [ ! $(cat) -eq 4 ] && status_code=1;
  # lecho "status_code5: ${status_code}"
  # lecho "get_valiable: ##${get_valiable}--"  | sed 's/\t//g' | sed 's/\ //g'
  case ${status_code} in 
    "1")
      local check_get_valiable=$(echo "${get_valiable}" | sed -e 's/\t//g' -e 's/\ //g')
      case "${check_get_valiable}" in 
        "")
          echo "${CMDCLICK_EDITOR_CMD} ${EDIT_FILE_PATH}" | xclip -selection c &
          dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "no exest editable val\n\n  ${EDIT_FILE_PATH}" "${INFO_BOX_DEFAULT_SIZE[@]}"
            SIGNAL_CODE=${EXIT_CODE} ;;
        *)
          echo "${CMDCLICK_EDITOR_CMD} ${EDIT_FILE_PATH}" | xclip -selection c &
          local validate_err_message="manual repaire shell file: total err"
          dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "${validate_err_message}\n\n  ${EDIT_FILE_PATH}" "${INFO_BOX_DEFAULT_SIZE[@]}"
            SIGNAL_CODE=${EXIT_CODE} ;; esac
      ;; esac
}









