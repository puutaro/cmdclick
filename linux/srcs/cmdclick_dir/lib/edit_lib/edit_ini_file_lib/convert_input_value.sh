#!/bin/bash

convert_input_value_lib_dir_path="${EDIT_INI_FILE_LIB_DIR_PATH}/convert_input_value_lib"
. "${convert_input_value_lib_dir_path}/echo_edited_ini_contents.sh"
unset -v convert_input_value_lib_dir_path


convert_input_value(){
  local source_ini_value="${1}"
  local LANG=C
  #入力値を取得
  local ini_value_source=$(\
    echo "${source_ini_value}" \
    | tr '\t' '\n' \
  )
  echo ini_value_source
  echo "${ini_value_source}"
  local ini_value=$(\
    surround_single_double_quote_when_existing_space_or_quote \
      "${ini_value_source}" \
  )
  INI_CONTENTS=$(\
    echo_edited_ini_contents \
      "${INI_CONTENTS}" \
      "${ALL_KEY_CON}" \
      "${ini_value}" \
  )
}
