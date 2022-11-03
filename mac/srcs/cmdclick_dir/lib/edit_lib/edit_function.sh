#!/bin/bash


display_edit_contensts(){
	# lecho "source_cmd111: ${source_cmd}"
  local edit_label=$(echo "${source_cmd}")
  #コマンド最後に空白改行なければ、追加（cmdclickワンバックスラッシュ変換の前にしないと、なぜかダメ）
  local check_sec_last_char="$(echo "${edit_label}" | tail -n -1 | sed -e "s| ||g")"
  # lecho "check_sec_last_char: ${check_sec_last_char}"
  if [ ${#check_sec_last_char} -ge 1 ]; then
    local edit_label="$(echo "${edit_label}" | gsed -e "$ a \ \n")"
  fi
  # lecho  "edit_label_last_newline: ${edit_label}"
  local source_cmd_display="$(echo "${source_cmd}" | sed 's/^#.*//' | sed "s/^[a-zA-Z0-9_-]\{1,100\}=.*//" | sed '/^$/d')"
  local source_cmd_display=$(echo ${source_cmd_display::400})
  local edit_label=$(echo "${source_cmd_display}" | gsed -e "s/${CMDCLICK_N_CAHR}/n/g" -e 's/'${CMDCLICK_BACKSLASH_MARK}'/\\/g' -e 's/'${CMDCLICK_ONE_BACKSLASH_MARK}'/\\/g')
  local edit_label=$(cat <(echo " ") <(echo "please edit bellow command;") <(echo " ") <(echo "${edit_label}"))
  # lecho  "edit_label: ${edit_label}"
  local edit_label="$(echo "${edit_label}" | gsed '1d' | gsed -e 's/^#.*//' -e "s/^[a-zA-Z0-9_-]\{1,100\}=.*//" | gsed '/^$/d')"
  #ウィンドウサイズ策定 
  # lecho "cmd_click_edit_sheet: ${cmd_click_edit_sheet[@]}"
  # lecho "EDIT_EDITOR_ON: ${EDIT_EDITOR_ON}"
  # EDIT_EDITOR_ON is setting in make_ini_contents.sh
  case "${EDIT_EDITOR_ON}" in 
    "ON") ;;
    *) 
      echo -e "\033];Please Edit Cmd \007"
      exec 3>&1
      # sheets=$(echo "\"$WORD\" 1 1 "-" 1 10 200 0")
      # Store data to $VALUES variable
      if [ ${roop_num} -ge 2 ];then EDIT_FULL_SCHEME=""; fi
      ini_value=$(dialog \
          --backtitle "Linux User Managment" \
          --title "${WINDOW_TITLE}" \
          --no-shadow \
          --form "${edit_label}" \
          "${box_size[@]}" \
        "${get_cmd_valiable_list[@]}" \
      2>&1 1>&3 || echo "")
      # close fd
      exec 3>&-
      # display values just entered
      # lecho "$ini_value"
      local size_err=$(echo "${ini_value}" | grep "Can't make sub-window at")
      case "${size_err}" in 
        "")
          case "${ini_value}" in 
            "") SIGNAL_CODE=${EXIT_CODE};;
            *) SIGNAL_CODE=${OK_CODE};;
          esac
          ;;
        *) EDIT_EDITOR_ON="ON"
          ;;
      esac
      ;; 
  esac
  # close fd
  case "${EDIT_EDITOR_ON}" in 
    "ON")
        ${CMDCLICK_EDITOR_CMD} ${EDIT_FILE_PATH}
        local edit_message=$(cat <(echo "") <(echo "please edit bellow path:") <(echo "") <(echo -e "\t${EDIT_FILE_PATH}") <(echo ""))
        local edit_box_size[0]=$(echo "${box_size[0]}")
        local edit_box_size[1]=$(echo "${box_size[1]}")
        dialog --no-shadow --title "${WINDOW_TITLE}" --msgbox "${edit_message}" "${edit_box_size[@]}"
        local file_name=$(cat "${EDIT_FILE_PATH}" | grep "${INI_CMD_FILE_NAME}=" | sed 's/'${INI_CMD_FILE_NAME}'\=//g')
        case "${EDIT_FILE_PATH}" in 
            "${INI_FILE_DIR_PATH}/${file_name}");;
            *) mv "${EDIT_FILE_PATH}" "${INI_FILE_DIR_PATH}/${file_name}";;
        esac
        SIGNAL_CODE=${EXIT_CODE}
      ;;
  esac
}

#yad用入力値反映イニファイル内容を作成
confirm_edit_contensts(){
  local DELAY=3
	local display_ini_contents=$(echo "${1}" | sed "s/${CMDCLICK_N_CAHR}/n/g")
  # lecho display_ini_contents
  # lecho "${display_ini_contents}"
  save_confirm_message="Do you really want to save bellow ini file ?"
  save_confirm_message=$(cat <(echo " ") <(echo "${save_confirm_message}") <(echo " ") <(echo ${display_ini_contents::1500}))
  # lecho save_confirm_message
  # lecho "${save_confirm_message}"

  #${box_size[@]}
  exec 3>&1
  VALUE=$(dialog --title "${WINDOW_TITLE}"  --no-shadow --menu "${save_confirm_message}" ${box_size[@]} \
  select "y or n" \
  2>&1 1>&3)
  # close fd
  exec 3>&-
  clear
  if [ -n "${VALUE}" ];then CONFIRM=0;
  else CONFIRM=1;fi
}