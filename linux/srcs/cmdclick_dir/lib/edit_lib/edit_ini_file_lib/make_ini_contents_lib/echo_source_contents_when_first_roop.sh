#!/bin/bash


echo_source_contents_when_first_roop(){
  local ini_contents_moto="${1}"
  local exec_default_parameter="${2}"
  local ini_contents_set_default_value_in_parameter=$(\
    echo_replace_cmd_section_with_default_value \
      "${ini_contents_moto}" \
      "${exec_default_parameter}" \
      "${COUNT_EXEC_EDIT_EXECUTE}" \
  )
  echo_section_bitween_start_and_end \
    "${ini_contents_set_default_value_in_parameter}" \
    "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" \
    "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
}
