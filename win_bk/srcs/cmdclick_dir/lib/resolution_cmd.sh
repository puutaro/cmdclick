#!/bin/bash


resolution_cmd(){
    center_box
    local width=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_WODTH}=" | sed 's/'${CMDCLICK_SETTING_ITEM_WODTH}'\=//')
    local height=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_HEIGHT}=" | sed 's/'${CMDCLICK_SETTING_ITEM_HEIGHT}'\=//')
    # open fd
    exec 3>&1
    local VALUES=$(dialog --backtitle "resolution backtitle" \
    --title "${WINDOW_TITLE}" \
    --no-shadow \
    --form "resolution form" \
    ${box_size[@]} \
      "width:" 1 1 "$width" 1 10 10 0 \
      "height:" 2 1 "$height"  2 10 10 0 \
    2>&1 1>&3)
    # close fd    
    exec 3>&-
    #clear
    # echo VALUES ${VALUES}
    case "${VALUES}" in 
      "");;
      *)
        # display values just entered
        VALUES=$(echo "${VALUES}" | sed -e 's/-//g' -e '1s/^$/must be set width/g')
        echo "${VALUES}" | xargs -I{} expr {} + 1 >&/dev/null
        local status_code=$?
        case "${status_code}" in 
          "0")
              local resolution_con="${CMDCLICK_SETTING_ITEM_WODTH}=\n${CMDCLICK_SETTING_ITEM_HEIGHT}="
              local setting_con=$(paste -d "\0" <(echo -e "${resolution_con}") <(echo "${VALUES}"))
              # lecho "resolution_con: ${resolution_con}"
              echo "${setting_con}" > "${CMDCLICKL_SETTUING_FILE_PATH}" &
              ;;
          *)
            reso_err_message=$(echo -e "resolution value err: \n$(echo "${VALUES}" | sed -e '1s/^/\twidth: /g' -e '2s/^/\theight: /g')")
            dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "${reso_err_message}" "${INFO_BOX_DEFAULT_SIZE[@]}" ;;
        esac
        ;;
    esac
}
