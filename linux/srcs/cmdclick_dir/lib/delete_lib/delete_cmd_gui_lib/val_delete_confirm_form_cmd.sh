#!/bin/bash


delete_confirm_form_cmd="yad --form \
    --title=\"\${WINDOW_TITLE}\" \
    --window-icon=\"\${WINDOW_ICON_PATH}\" \
    --item-separator='!'\
    --center \
    --scroll \
    --borders=\${CMDCLICK_BORDER_NUM} \
    --height=\${scale_display_height} \
    --width=\${scale_display_width}"
