#!/bin/bash


input_path_check_lib_path="${COMMON_LIB_DIR_PATH}/input_path_check_lib"
. "${input_path_check_lib_path}/val_add_cmd_base.sh"

unset -v input_path_check_lib_path


#コマンドをユーザー入力フォームで取得
create_chdir_command_form(){
	local LANG="ja_JP.UTF-8"
	set +e
	eval "${add_cmd_base}\
		--text=\"\n${ADD_CD_PATH_MESSAGE}\n\" \
		--field=\"${CH_DIR_PATH}\" \"${HOME}/\""
	set -e
}
