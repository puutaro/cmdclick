#!/bin/bash


set_all_key_con_and_source_cmd_and_variable_con_field_and_value_list(){
  local ini_contents_moto="${1}"
  local source_con="${2}"
  local get_valiable="${3}"
  ALL_KEY_CON=$(\
    echo "${source_con}" \
    | awk \
      -F '=' \
    '{
      gsub( /:[a-zA-Z]*$/, "", $1)
      print $1
    }'
  )
  SOURCE_CMD=$(\
    echo "${ini_contents_moto}"\
    | awk '{
      if(\
        $0 !~ "^#" \
        && $0 !~ "^[a-zA-Z0-9_-]*=" \
        && $0 != ""\
      )
        print $0
    }')
  local IFS=$'\n'
  VARIABLE_CONTENSTS_FIELD_LIST=(\
    $(\
      echo "${get_valiable}" \
      | awk -F '\t' '{
        print "--field="$1
      }' \
    )\
  )
  VARIABLE_CONTENSTS_VALUE_LIST=(\
    $(\
      echo "${get_valiable}" \
      | awk -F '\t' '{
        gsub( /^-/, "\x22-\x22", $2);
        for (i=2; i<=NF; i++) print $i
      }'
    )\
  )
  EDIT_DESCRIPTION=$(\
    echo_labeling_section_bitween_start_and_end \
      "${ini_contents_moto}"
  )
  EDIT_DESCRIPTION="$(\
    echo_by_convert_xml_escape_sequence \
      "${EDIT_DESCRIPTION}"\
  )"
}
