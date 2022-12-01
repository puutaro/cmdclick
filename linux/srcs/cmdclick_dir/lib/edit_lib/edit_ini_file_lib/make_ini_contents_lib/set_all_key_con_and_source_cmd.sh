#!/bin/bash


set_all_key_con_and_source_cmd(){
  local ini_contents_moto="${1}"
  local source_con="${2}"
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
  EDIT_DESCRIPTION=$(\
    echo_labeling_section_bitween_start_and_end \
      "${ini_contents_moto}" \
      "print"
  )
  case "${EDIT_DESCRIPTION}" in
    "") EDIT_DESCRIPTION="${SOURCE_CMD}"
      ;;
  esac
  EDIT_DESCRIPTION="$(\
    echo_by_convert_xml_escape_sequence_new_line \
      "${EDIT_DESCRIPTION}"\
  )"
}
