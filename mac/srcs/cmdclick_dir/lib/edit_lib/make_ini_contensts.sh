#!/bin/bash

make_ini_contensts(){
  source_cmd=""
  #backslach一つを四個に
  #("${variabl_contensts_field_list[${i}]}"  ${scheme_num} "1" "${variabl_contensts_value_list[${i}]}" ${scheme_num} ${SCHEME_CHAR_NUME} ${EDIT_CHAR_NUM}  "0")
  local ini_contents_moto="${1}"
  ini_contents="${ini_contents_moto}"
  # lecho "${ini_contents}"
  if [ ${roop_num} -ge 2 ];then
    local source_con=$(cat <(echo "${ini_contents_moto}" | gsed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | gsed -e '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' -e '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=") <(echo "${ini_contents_moto}" | gsed -n '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/,/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/p' | gsed -e '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/d' -e '/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=") | sed '/^$/d')
    if [ ${roop_num} -eq 2 ];then 
      source_con=$(echo "${source_con}" | sed 's/^'${INI_CMD_FILE_NAME}'\=.*/'${INI_CMD_FILE_NAME}'='${EXECUTE_FILE_NAME}'/' ) 
    fi

    all_key_con=$(echo "${source_con}" | cut -d= -f1)
    local get_valiable=$(echo "${source_con}" | sed 's/\=$/=-/' | nl | gsed -e 's/\=/\t/' -re "s/\ *([0-9]{1,5})\t([a-zA-Z0-9_-]{1,100})\t(.*)/\2\t\1\t1\t\3\t\1\t${SCHEME_CHAR_NUME}\t${EDIT_CHAR_NUM}\t0/g" | tr '\n' '\t')
  else
    case "${EXEC_IN_EXE_DFLT_VL}" in 
      "") local source_con=$(echo "${ini_contents_moto}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=")
        ;;
      *)
        local source_con=$(eval "echo \"\${ini_contents_moto}\" ${EXEC_IN_EXE_DFLT_VL}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=")
        ;;
    esac
        
    all_key_con=$(echo "${source_con}" | cut -d= -f1)
    local get_valiable=$(cat  <(echo "${source_con}") <(echo "${FULL_EDIT_BOOL}=0") | gsed -e '/^$/d' -e 's/\=$/=-/' | nl | gsed -e 's/\=/\t/' -re "s/\ *([0-9]{1,5})\t([a-zA-Z0-9_-]{1,100})\t(.*)/\2\t\1\t1\t\3\t\1\t${SCHEME_CHAR_NUME}\t${EDIT_CHAR_NUM}\t0/g" | tr '\n' '\t')
    # lecho "get_valiable:1: ${get_valiable}"
  fi
  local check_only_full_edit_bool_field=$(echo "${source_con}" | rga -v "${FULL_EDIT_BOOL}" | sed '/^$/d' | wc -l | sed 's/\ //g' )
  if [ -z "${get_valiable}" ] || [ ${check_only_full_edit_bool_field} -eq 0 ];then
    EDIT_EDITOR_ON=ON
  fi
  # lecho "check_only_full_edit_bool_field: ${check_only_full_edit_bool_field}"
  # lecho "source_con: ${source_con}"
  source_cmd=$(echo "${ini_contents_moto}" | rga -v "^#" | rga -v "^[a-zA-Z0-9_-]{1,100}=" | sed '/^$/d')

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
  echo "${get_valiable_nr}" |  awk 'NR%8==3 || NR%8==6 || NR%8==7 || NR%8==0' | sort | uniq | wc -l | sed 's/\ //g'  | [ ! $(cat) -eq 4 ] && status_code=1;
  # lecho "status_code5: ${status_code}"
  if [ -z "${get_valiable}" ];then lecho "get_valiable: nasi" ;
  else lecho "get_valiable: ari" ;fi
  # lecho "get_valiable: ##${get_valiable}--"  | sed 's/\t//g' | sed 's/\ //g'
  if [ ${status_code} -eq 1  ];then
    local check_get_valiable=$(echo "${get_valiable}" | gsed -e 's/\t//g' -e 's/\ //g')
    if [ -z "${check_get_valiable}" ];then
      echo "${CMDCLICK_EDITOR_CMD} ${EDIT_FILE_PATH}" | pbcopy &
      dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "no exest editable val\n\n  ${EDIT_FILE_PATH}" "${INFO_BOX_DEFAULT_SIZE[@]}"
        SIGNAL_CODE=${EXIT_CODE}
    else
      echo "${CMDCLICK_EDITOR_CMD} ${EDIT_FILE_PATH}" | pbcopy &
      local validate_err_message="manual repaire shell file: total err"
      dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "${validate_err_message}\n\n  ${EDIT_FILE_PATH}" "${INFO_BOX_DEFAULT_SIZE[@]}"
        SIGNAL_CODE=${EXIT_CODE}
    fi
  fi
}









