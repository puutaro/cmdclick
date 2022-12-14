#!/bin/bash

MAKE_INI_CONTENTS_LIB_DIR_PATH="${EDIT_INI_FILE_LIB_DIR_PATH}/make_ini_contents_lib"

. "${COMMON_LIB_DIR_PATH}/echo_section_bitween_start_and_end.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_con_when_two_over_roop.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_by_replace_blank_with_hyphen_and_equal_with_tab.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_replace_cmd_section_with_default_value.sh"
. "${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_btn_parameters.sh"


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
  BTN_PARAMETERS=$(\
    echo_btn_parameters \
      "${ini_contents_moto}" \
      "${exec_default_parameter}" \
  )
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
        source_con=$(\
          awk \
            -v EXEC_DISPLAY_DESCRIPTION_PATH="${EXEC_DISPLAY_DESCRIPTION_PATH}" \
            -v EDIT_FILE_PATH="${EDIT_FILE_PATH}" \
            -v source_con="${source_con}" \
            -v WINDOW_TITLE="${WINDOW_TITLE}" \
            -v WINDOW_ICON_PATH="${WINDOW_ICON_PATH}" \
            -v EDIT_WINDOW_LOCATION="--center --width=${CENTER_SCALE_DISPLAY_WIDTH} --height=${CENTER_SCALE_DISPLAY_HEIGHT}" \
            'BEGIN {
              if(!source_con) exit
              source_con=source_con"\ndisplayDescription:FBTN=bash \x27"EXEC_DISPLAY_DESCRIPTION_PATH"\x27 \x27"EDIT_FILE_PATH"\x27 \x27"WINDOW_TITLE"\x27 \x27"WINDOW_ICON_PATH"\x27 \x27"EDIT_WINDOW_LOCATION"\x27"
              print source_con
            }'\
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
  source_con=$(\
      awk \
        -v source_con="${source_con}"\
        'BEGIN {
          source_con_list_length = split(\
            source_con, \
            source_con_list, \
            "\n"\
          )
          if(source_con_list_length > 2) print source_con
        }'
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
  set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list \
    "${ini_contents_moto}" \
    "${source_con}" \
    "${get_valiable}"
}
