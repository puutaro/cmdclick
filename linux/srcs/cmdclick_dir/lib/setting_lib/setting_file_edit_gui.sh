#!/bin/bash


setting_ini_file_gui_lib_dir_path="${SETTING_LIB_DIR_PATH}/setting_ini_file_gui_lib"
. "${setting_ini_file_gui_lib_dir_path}/display_setting_edit_manager.sh"
. "${setting_ini_file_gui_lib_dir_path}/make_setting_con_by_use_key.sh"
. "${setting_ini_file_gui_lib_dir_path}/parse_setting_value_to_key.sh"
unset -v setting_ini_file_gui_lib_dir_path


setting_file_edit_gui(){
	local LANG="ja_JP.UTF-8"
	local setting_con_source="$(\
		cat "${CMDCLICK_INI_SETTING_FILE_PATH}" \
	)"
	local setting_con_before_edit=$(\
		make_setting_con_by_use_key \
			"${setting_con_source}" \
			"${CMDCLICK_SETTING_KEY_CON}" \
	)
	local SETTING_VALUE=""
	SIGNAL_CODE=""
	display_setting_edit_manager \
		"${setting_con_before_edit}"
	if [ ${SIGNAL_CODE} -eq ${EXIT_CODE} ] \
      || [ ${SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ]; then return; fi
	local setting_con_after_edit="$(\
		parse_setting_value_to_key \
			"${setting_con_source}" \
			"${CMDCLICK_SETTING_KEY_CON}" \
			"${SETTING_VALUE}" \
	)"
	confirm_edit_contensts \
		"${setting_con_after_edit}"
	if [ ${CONFIRM} -eq ${EXIT_CODE} ] \
      || [ ${CONFIRM} -ge ${FORCE_EXIT_CODE} ]; then return; fi
 	echo "${setting_con_after_edit}" \
 		> "${CMDCLICK_INI_SETTING_FILE_PATH}"
}