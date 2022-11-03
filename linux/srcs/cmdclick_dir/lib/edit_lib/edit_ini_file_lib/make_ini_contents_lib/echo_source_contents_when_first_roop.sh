#!/bin/bash

echo_source_contents_when_first_roop_dir_path="${MAKE_INI_CONTENTS_LIB_DIR_PATH}/echo_source_contents_when_first_roop_lib"
. "${echo_source_contents_when_first_roop_dir_path}/echo_replace_cmd_section_with_default_value.sh"


echo_source_contents_when_first_roop(){
  local ini_contents_moto="${1}"
  local ini_input_execute="${2}"
  local exec_default_parameter="${3}"
  case "${ini_input_execute}" in 
    "C");;
    *) 
      echo_section_bitween_start_and_end \
        "${ini_contents_moto}" \
        "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
        "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
      return
  ;; esac
  local ini_contents_set_default_value_in_parameter=$(\
    echo_replace_cmd_section_with_default_value \
      "${ini_contents_moto}" \
      "${exec_default_parameter}" \
  )
  echo_section_bitween_start_and_end \
    "${ini_contents_set_default_value_in_parameter}" \
    "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
    "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
}
