#!/bin/bash


display_edit_contensts_lib_path="${EDIT_INI_FILE_LIB_DIR_PATH}/display_edit_contensts_lib"
. "${display_edit_contensts_lib_path}/echo_ini_value.sh"
. "${display_edit_contensts_lib_path}/judge_back_slash_err.sh"


display_edit_contensts(){
  local LANG="ja_JP.UTF-8"
  case "${ROOP_NUM}" in
    "1")
      local edit_label="please edit bellow cmd variable"
      ;;
    *)
      local edit_label="please edit bellow setting or cmd variable"
      ;;
  esac
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
  ini_value_source=$(\
    LANG="ja_JP.UTF-8" \
    yad \
    --form \
    --title="${WINDOW_TITLE}" \
    --window-icon="${WINDOW_ICON_PATH}" \
    --text="\n${edit_label} \n" \
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
  judge_back_slash_err \
    "${ini_value_source}"
  case "${SIGNAL_CODE}" in
    "${OK_CODE}"|${EDIT_FULL_CODE})
        INI_VALUE=$(\
          echo_ini_value \
            "${ini_value_source}" \
        )
      ;;
  esac
  unset -v ini_value_source
}
