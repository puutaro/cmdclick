#!/bin/bash


normal_index(){
	local LANG="ja_JP.UTF-8"
	local ini_file_list="${1}"
	local scale_display_width="${2}"
	local one_string_width=13
	local preview_string_width=$((${scale_display_width} / ${one_string_width}))
	local japanise_preview_string_width=$((${preview_string_width} / 2))
	export preview_string_width=${preview_string_width}
	export japanise_preview_string_width=${japanise_preview_string_width}
	echo "${ini_file_list}" | \
		fzf --delimiter $'\t' \
			--layout=reverse \
			--border  \
			--with-nth 1 \
			--cycle \
			--header-lines=1 \
			--info=inline \
			--preview 'LANG="ja_JP.UTF-8" head -100 {2}/{1} | echo_labeling_section_bitween_start_and_end_from_pip | tr -d "\n" | jfold '${japanise_preview_string_width}' | sed "$ s/$/\n\n/" && head -100 {2}/{1} | sed '1d' | sed 's/^#.*//' | sed "s/^[a-zA-Z0-9_-]\{1,100\}=.*//" | tr -d "\n" | fold -b'${preview_string_width}'' \
			--bind "Alt-w:execute(open_editor {2}/{1})" \
			--bind "Alt-e:execute(echo \"${EDIT_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-E:execute(echo \"${DESCRIPTION_EDIT_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-m:execute(echo \"${MOVE_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-i:execute(echo \"${INSTALL_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-a:execute(echo \"${ADD_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-d:execute(echo \"${DELETE_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-l:execute(echo \"${CHDIR_CODE},{1},${CMDCLICK_APP_DIR_PATH}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-C:execute(echo \"${SETTING_CODE},{1},{2}\" > '${CMDCLICK_VALUE_SIGNAL_FILE_PATH}')+abort" \
			--bind "Alt-s:reload(export IMPORT_CMDCLICK_VAL=1 && . ${IMPORT_PATH_EXEC_CMDCLICK} && . ${IMPORT_PATH_INPUT_GUI} && export SIGNAL_CODE=${SIGNAL_CODE} && exec_inc && reload_cmd)" \
			--bind "Alt-S:reload(export IMPORT_CMDCLICK_VAL=1 && . ${IMPORT_PATH_EXEC_CMDCLICK} && . ${IMPORT_PATH_INPUT_GUI} && export SIGNAL_CODE=${SIGNAL_CODE} && exec_dec && reload_cmd)" \
			--bind "Alt-r:reload(export IMPORT_CMDCLICK_VAL=1 && . ${IMPORT_PATH_EXEC_CMDCLICK} && . ${IMPORT_PATH_INPUT_GUI} && export SIGNAL_CODE=${SIGNAL_CODE} && reload_cmd)" \
			--bind "alt-v:execute(echo {2}/{1} | tr -d '\n' | xclip -selection c -i -f)" \
			--bind alt-g:preview-up,alt-G:preview-page-up,alt-b:preview-down,alt-B:preview-page-down \
			--color 'fg:#000000,fg+:#ddeeff,bg:#f2f2f2,preview-bg:#e6ffe6,border:#ffffff'\
			--color 'info:#00b386,hl+:#02ebc7,hl:#0750fa,header:#000000,gutter:#000000' \
			--color 'marker:#0750fa,spinner:#0750fa,pointer:#00b386,prompt:#000000' \
			--preview-window top:4
}