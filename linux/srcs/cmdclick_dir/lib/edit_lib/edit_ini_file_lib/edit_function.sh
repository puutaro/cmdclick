#!/bin/bash


display_edit_contensts(){
  local LANG="ja_JP.UTF-8"
  local desc_string_quants=$(\
    echo "scale=2; ${EDIT_WINDOW_WIDTH} * (450 / 720)" \
      | bc\
  )
  case "${ROOP_NUM}" in
    "1")
      local edit_prompt="please edit bellow cmd variable"
      ;;
    *)
      local edit_prompt="please edit bellow setting or cmd variable"
      ;;
  esac
  case "${EDIT_DESCRIPTION}" in 
    "")
      local display_source_cmd=$(\
      echo_by_convert_xml_escape_sequence \
        "${SOURCE_CMD::400}" \
      )
      local edit_label="$(\
        cat <(echo "\n${edit_prompt}") \
            <(echo "") \
            <(echo "   ${display_source_cmd}")\
      )" ;;
    *)
      local edit_label="$(\
        cat <(echo "\n${edit_prompt}") \
            <(echo "") \
            <(echo "   ${EDIT_DESCRIPTION}") \
      )"
  ;; esac
  #ウィンドウサイズ策定
  case "${ROOP_NUM}" in 
    "1") local button_list=(\
        "--button  gtk-edit:${EDIT_FULL_CODE}" \
        "--button  gtk-cancel:${EXIT_CODE}" \
        "--button  gtk-ok:${OK_CODE}")
        ;;
    *) local button_list=(\
        "--button  gtk-cancel:${EXIT_CODE}" \
        "--button  gtk-ok:${OK_CODE}")
        ;;
  esac
  set +e
  INI_VALUE=$(\
    LANG="ja_JP.UTF-8" \
    yad \
    --form \
    --title="${WINDOW_TITLE}" \
    --window-icon="${WINDOW_ICON_PATH}" \
    --text="${edit_label::${desc_string_quants%.*}} \n" \
    --separator=$'\t' \
    --date-format="%Y-%m-%d"\
    --borders=${CMDCLICK_BORDER_NUM} \
    --item-separator="!" \
    ${EDIT_WINDOW_LOCATION} \
    --scroll \
    ${button_list[@]} \
    ${VARIABLE_CONTENSTS_FIELD_LIST[@]} \
    "${VARIABLE_CONTENSTS_VALUE_LIST[@]}"
  )
  SIGNAL_CODE=$?
  set -e
}
