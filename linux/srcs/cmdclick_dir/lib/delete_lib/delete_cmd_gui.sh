#!/bin/bash


delete_cmd_lib_dir_path="${DELETE_LIB_DIR_PATH}/delete_cmd_gui_lib"
. "${delete_cmd_lib_dir_path}/val_delete_confirm_form_cmd.sh"
. "${delete_cmd_lib_dir_path}/delete_app_dir.sh"
unset -v delete_cmd_lib_dir_path


delete_cmd(){
  local LANG="ja_JP.UTF-8"
	local delete_contents=$(cat "${DELETE_FILE_PATH}")
  local delete_contents=$(echo "${delete_contents}" | sed 's/\\/\\\\/g')
  local scale_display_height=$(echo "scale=0; ${DISPLAY_RSOLUTION_HEIGHT} / 1.1" |bc)
  local scale_display_width=$(echo "scale=0; ${DISPLAY_RSOLUTION_WIDTH} / 1.9" |bc)
  delete_contents="$(\
    echo_by_convert_xml_escape_sequence_new_line \
       "${delete_contents}" \
  )"
  set +e
  eval "${delete_confirm_form_cmd} \
    --field=\"\n Do you really want to delete bellow ini file ? \n  \${EXECUTE_FILE_NAME} \n\n\":LBL \
    --field=\"\${delete_contents}\":LBL"
  local confirm=$?
  set -e
  if [ ${confirm} -eq ${EXIT_CODE} ] \
    || [ ${confirm} -ge ${FORCE_EXIT_CODE} ]; then return ;fi
  case "${CHDIR_SIGNAL_CODE:-}" in
    "${DELETE_CODE}")
      local delete_dir_path=$(\
        cat "${DELETE_FILE_PATH}" \
        | rga "^${CH_DIR_PATH}=" \
        | head -n 1 \
        | sed 's/^'${CH_DIR_PATH}'\=//'\
      )
      local display_delete_dir_path=$(\
        echo "${delete_dir_path}" \
         | sed -re 's/([^a-zA-Z0-9_-])/\\\1/g' \
          -e 's/\&/\&amp;/g' \
          -e 's/</\&lt;/g' \
          -e 's/>/\&gt;/g' \
          -e 's/"/\&quot;/g' \
          -e "s/'/\&apos;/g" \
      )
      local cd_delete_message=$(\
        cat <(echo " ") \
            <(echo "Would you like to delete bellow APP dir ?") \
            <(echo " ") \
            <(echo -e "\t${display_delete_dir_path}")\
      )
      set +e
      eval "${delete_confirm_form_cmd} \
        --field=\"\n ${cd_delete_message} \n\n\":LBL" 
      local confirm_app=$?
      set -e
      delete_app_dir "${confirm_app}"
      ;;
  esac
	rm -f "${DELETE_FILE_PATH}"
}