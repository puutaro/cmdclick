#!/bin/bash

MAKE_INI_CONTENTS_LIB_DIR_PATH="${EDIT_INI_FILE_LIB_DIR_PATH}/make_ini_contents_lib"

. "${COMMON_LIB_DIR_PATH}/echo_section_bitween_start_and_end.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_con_when_two_over_roop.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_by_replace_blank_with_hyphen_and_equal_with_tab.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/set_all_key_con_and_source_cmd.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_replace_cmd_section_with_default_value.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/make_cmd_variable_field_and_value_list.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/make_setting_variable_field_and_value_list.sh"

unset -v MAKE_INI_CONTENTS_LIB_DIR_PATH


make_ini_contents(){
  local LANG=C
  local ini_contents_moto="${1}"
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
  local cmd_section_source_con=$(\
    echo_section_bitween_start_and_end \
      "${ini_contents_set_default_value_in_parameter}" \
      "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
      "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}" \
  )
  local get_cmd_valiable=$(\
    echo_by_replace_blank_with_hyphen_and_equal_with_tab \
      "${cmd_section_source_con}" \
  )
  if [ -z "${get_cmd_valiable}" ];then 
    HOW_EXIST_CMD_SECTION=${cmd_section_absence}
    ROOP_NUM=2 ; 
  fi
  case "${ROOP_NUM}" in 
    "0"|"1") 
      CMD_VARIABLE_CONTENSTS_FIELD_LIST=""
      CMD_VARIABLE_CONTENSTS_VALUE_LIST=""
      make_cmd_variable_field_and_value_list \
        "${get_cmd_valiable}"
      ALL_KEY_CON=""
      SOURCE_CMD=""
      EDIT_DESCRIPTION=""
      set_all_key_con_and_source_cmd \
        "${ini_contents_moto}" \
        "${cmd_section_source_con}"
      return
  ;;esac
  local setting_section_source_con=$(\
    echo_source_con_when_two_over_roop \
      "${ini_contents_set_default_value_in_parameter}" \
  )
  case "${setting_section_source_con}" in 
    "") SIGNAL_CODE=${EXIT_CODE}
        return 
  ;; esac
  local get_setting_valiable=$(\
    echo_by_replace_blank_with_hyphen_and_equal_with_tab \
      "${setting_section_source_con}" \
  )
  local IFS=$'\n'

  CMD_VARIABLE_CONTENSTS_FIELD_LIST=()
  CMD_VARIABLE_CONTENSTS_VALUE_LIST=()
  make_cmd_variable_field_and_value_list \
    "${get_cmd_valiable}"

  SETTING_VARIABLE_CONTENSTS_FIELD_LIST=()
  SETTING_VARIABLE_CONTENSTS_VALUE_LIST=()
  make_setting_variable_field_and_value_list \
    "${get_setting_valiable}"
  ALL_KEY_CON=""
  SOURCE_CMD=""
  EDIT_DESCRIPTION=""
  local source_con="$(\
    echo_section_bitween_setting_cmd_section \
      "${ini_contents_moto}"
  )"
  set_all_key_con_and_source_cmd \
    "${ini_contents_moto}" \
    "${source_con}"
}
