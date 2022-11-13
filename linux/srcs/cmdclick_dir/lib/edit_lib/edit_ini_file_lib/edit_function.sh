#!/bin/bash

display_edit_contensts(){
  local LANG="ja_JP.UTF-8"
  local display_source_cmd=$(\
    echo_by_convert_xml_escape_sequence \
      "${SOURCE_CMD::400}" \
  )
  case "${EDIT_DESCRIPTION}" in 
    "")
      local edit_label="$(\
        cat <(echo "\n  please edit bellow command") \
            <(echo "") \
            <(echo "      ${display_source_cmd}\n")\
      )" ;;
    *)
      local edit_label="$(\
        cat <(echo "\n  please edit bellow command") \
            <(echo "") \
            <(echo "    ${EDIT_DESCRIPTION}") \
            <(echo "") \
            <(echo "      ${display_source_cmd}\n")\
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
  INI_VALUE=$(LANG="ja_JP.UTF-8" yad --form \
    --title="${WINDOW_TITLE}" \
    --window-icon="${WINDOW_ICON_PATH}" \
    --text="${edit_label}" \
    --separator=$'\t' --item-separator="!" \
    ${EDIT_WINDOW_LOCATION} \
    --scroll \
    ${button_list[@]} \
    ${VARIABLE_CONTENSTS_FIELD_LIST[@]} \
    "${VARIABLE_CONTENSTS_VALUE_LIST[@]}"
  )
  SIGNAL_CODE=$?
  set -e
}
