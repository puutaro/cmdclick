#!/bin/bash


exec_display_edit_contensts_lib_path="${EDIT_INI_FILE_LIB_DIR_PATH}/display_edit_contensts_lib"
. "${exec_display_edit_contensts_lib_path}/exec_edit_display_first_roop.sh"
. "${exec_display_edit_contensts_lib_path}/exec_edit_display_two_roop.sh"
. "${exec_display_edit_contensts_lib_path}/echo_ini_value_by_order_correct.sh"

unset -v exec_display_edit_contensts_lib_path


display_edit_contensts(){
  local LANG="ja_JP.UTF-8"
  local PLUG_KEY=91091
  set +e
  ipcrm -M ${PLUG_KEY} 2>/dev/null
  set -e
  local SETTING_TAB="setting var"
  local CMD_TAB="cmd var"
  local DESC_TAB="desc"
  local PROMPT_SENTENCE="please edit bellow command"
  local display_source_cmd=$(\
    echo_by_convert_xml_escape_sequence \
      "${SOURCE_CMD::400}" \
  )
  case "${EDIT_DESCRIPTION}" in
    "") EDIT_DESCRIPTION="${SOURCE_CMD}"
      ;;
  esac
  local DESC_STRING_QUANTS=$(\
    echo "scale=2; ${EDIT_WINDOW_WIDTH} * (450 / 720)" \
      | bc\
  )
  #ウィンドウサイズ策定
  case "${ROOP_NUM}" in 
    "1") local BUTTON_LIST=(\
        "--button  gtk-edit:${EDIT_FULL_CODE}" \
        "--button  gtk-cancel:${EXIT_CODE}" \
        "--button  gtk-ok:${OK_CODE}")
        ;;
    *) local BUTTON_LIST=(\
        "--button  gtk-cancel:${EXIT_CODE}" \
        "--button  gtk-ok:${OK_CODE}")
        ;;
  esac
  set +e
  case "${ROOP_NUM}" in
    "1")
      SIGNAL_CODE=""
      INI_VALUE=""
      exec_edit_display_first_roop
      ;;
    "2")
      SIGNAL_CODE=""
      INI_VALUE=""
      exec_edit_display_two_roop
  ;;esac
  ipcrm -M ${PLUG_KEY} 2>/dev/null
  set -e
}