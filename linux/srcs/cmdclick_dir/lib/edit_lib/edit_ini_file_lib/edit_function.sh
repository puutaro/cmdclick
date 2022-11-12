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


editor_on_display(){
  sleep 0.5 && open_editor "${EDIT_FILE_PATH}" &
  local editor_on_message="\n please edit code by editor \n"
  case "${EXEC_INPUT_EXECUTE}" in 
    "") local button_op="--button gtk-ok:${EXIT_CODE}";;
    "E") local button_op="" ;;
  esac
  set +e
  yad --text="${editor_on_message}" \
      --title="${WINDOW_TITLE}" \
      --window-icon="${WINDOW_ICON_PATH}" \
      --center \
      --scroll \
      --height=${CENTER_SCALE_DISPLAY_HEIGHT} \
      --width=${CENTER_SCALE_DISPLAY_WIDTH} \
      ${button_op}
  EXEC_INPUT_EXECUTE_SIGNAL=$?
  set -e
  local removed_file_name_double_quote_ends=$(\
    cat "${EDIT_FILE_PATH}" \
      | fetch_parameter_from_pip "${INI_CMD_FILE_NAME}" \
      | echo_removed_double_quote_both_ends_from_pip
  )
  mv_ini_file_when_rename \
    "${removed_file_name_double_quote_ends}" \
    "${EDIT_FILE_NAME}" \
    "${INI_FILE_DIR_PATH}"
  SIGNAL_CODE=${EXIT_CODE}
}
