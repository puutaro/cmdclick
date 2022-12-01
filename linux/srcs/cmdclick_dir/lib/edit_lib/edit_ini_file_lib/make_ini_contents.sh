#!/bin/bash

MAKE_INI_CONTENTS_LIB_DIR_PATH="${EDIT_INI_FILE_LIB_DIR_PATH}/make_ini_contents_lib"

. "${COMMON_LIB_DIR_PATH}/echo_section_bitween_start_and_end.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_con_when_two_over_roop.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_by_replace_blank_with_hyphen_and_equal_with_tab.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_replace_cmd_section_with_default_value.sh"

unset -v MAKE_INI_CONTENTS_LIB_DIR_PATH


make_ini_contents(){
  local LANG=C
  local ini_contents_moto="${1}"
  local KEY_BOUND_DESC_BITWEEN_CMD_AND_SETTING="--------------------"
  local KEY_ADD_TYPE_BOUND_DESC_BITWEEN_CMD_AND_SETTING="${KEY_BOUND_DESC_BITWEEN_CMD_AND_SETTING}:RO"
  local STR_BOUND_DESC_BITWEEN_CMD_AND_SETTING="  bellow is command variable"
  local exec_default_parameter="$(\
    fetch_parameter \
      "${ini_contents_moto}" \
      "${INI_SET_VARIABLE_TYPE}" \
      | echo_removed_double_quote_both_ends_from_pip \
      | sed  -e 's/,[ ]*/\n/g' \
  )"
  local ini_contents_set_default_value_in_parameter=$(\
    echo_replace_cmd_section_with_default_value \
      "${ini_contents_moto}" \
      "${exec_default_parameter}" \
      "${COUNT_EXEC_EDIT_EXECUTE}" \
  )
  case "${ROOP_NUM}" in 
    "1")
        local source_con=$(\
          echo_section_bitween_start_and_end \
            "${ini_contents_set_default_value_in_parameter}" \
            "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
            "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}" \
        )
  ;; esac
  case "${ROOP_NUM}" in 
    "1")
        local get_valiable=$(\
                echo_by_replace_blank_with_hyphen_and_equal_with_tab \
                  "${source_con}" \
              )
        if [ -z "${get_valiable}" ];then 
          HOW_EXIST_CMD_SECTION=${cmd_section_absence}
          ROOP_NUM=2 ; 
      fi
  ;; esac
  case "${ROOP_NUM}" in 
    "0"|"1") 
      ALL_KEY_CON=""
      SOURCE_CMD=""
      VARIABLE_CONTENSTS_FIELD_LIST=""
      VARIABLE_CONTENSTS_VALUE_LIST=""
      EDIT_DESCRIPTION=""
      set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list \
        "${ini_contents_moto}" \
        "${source_con}" \
        "${get_valiable}"
      return
  ;;esac
  local source_con=$(\
    echo_source_con_when_two_over_roop \
      "${ini_contents_set_default_value_in_parameter}" \
  )
  case "${source_con}" in 
    "") SIGNAL_CODE=${EXIT_CODE}
        return 
  ;; esac
  local get_valiable=$(\
    echo_by_replace_blank_with_hyphen_and_equal_with_tab \
      "${source_con}" \
  )
  ALL_KEY_CON=""
  SOURCE_CMD=""
  VARIABLE_CONTENSTS_FIELD_LIST=""
  VARIABLE_CONTENSTS_VALUE_LIST=""
  EDIT_DESCRIPTION=""
  set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list \
    "${ini_contents_moto}" \
    "${source_con}" \
    "${get_valiable}"
}
