#!/bin/bash

MAKE_INI_CONTENTS_LIB_DIR_PATH="${EDIT_INI_FILE_LIB_DIR_PATH}/make_ini_contents_lib"

. "${COMMON_LIB_DIR_PATH}/echo_section_bitween_start_and_end.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_contents_when_first_roop.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_con_when_two_over_roop.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_by_replace_blank_with_hyphen_and_equal_with_tab.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list.sh"
unset -v MAKE_INI_CONTENTS_LIB_DIR_PATH

make_ini_contents(){
  local LANG=C
  local ini_contents_moto="${1}"
  case "${ROOP_NUM}" in 
    "1")
        local exec_default_parameter="$(\
          fetch_parameter \
            "${ini_contents_moto}" \
            "${INI_IN_EXE_DFLT_VL}" \
            | echo_removed_double_quote_both_ends_from_pip \
            | sed  -e 's/,[ ]*/\n/g' \
        )"
        local ini_input_execute="$(\
          fetch_parameter \
            "${ini_contents_moto}" \
            "${INI_INPUT_EXECUTE}" \
            | echo_removed_double_quote_both_ends_from_pip \
        )"
        local source_con=$(\
          echo_source_contents_when_first_roop \
            "${ini_contents_moto}" \
            "${ini_input_execute}" \
            "${exec_default_parameter}" \
        )
  ;; esac
  case "${ROOP_NUM}" in 
    "1")
        local get_valiable=$(\
                echo_by_replace_blank_with_hyphen_and_equal_with_tab \
                  "${source_con}" \
              )
        if [ -z "${get_valiable}" ];then ROOP_NUM=2 ; fi
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
      "${ini_contents_moto}" \
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
