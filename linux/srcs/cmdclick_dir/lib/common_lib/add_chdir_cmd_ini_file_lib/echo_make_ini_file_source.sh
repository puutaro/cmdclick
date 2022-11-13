#!/bin/bash


echo_make_ini_file_source(){
	local ini_file_name="${1}"
	local main_contents="${2}"
	local sed_ini_file_name="$(\
		echo "${ini_file_name}" \
			| sed -r 's/([^a-zA-Z0-9_-])/\\\1/g'
	)"
	cat <(echo "${CMDCLICK_CREATE_FILE_SHIBAN}") \
		<(echo -e "") \
		<(echo -e "") \
		<(echo "${INI_LABELING_SECTION_START_NAME}")  \
		<(echo "${INI_LABELING_SECTION_END_NAME}")  \
		<(echo -e "") \
		<(echo -e "") \
		<(echo "${INI_SETTING_SECTION_START_NAME}")  \
		<(\
			echo "${INI_SETTING_DEFAULT_GAIN_CON}" \
			| sed \
				-e 's/'${INI_TERMINAL_ON}'=.*/'${INI_TERMINAL_ON}'=OFF/' \
				-re "s/(${INI_CMD_FILE_NAME}=)/\1\"${sed_ini_file_name}\"/" \
				-re "s/(${INI_SET_VARIABLE_TYPE})=/\1=${CH_DIR_PATH}:MDIR=/" \
		) \
		<(echo "${INI_SETTING_SECTION_END_NAME}"\
		) \
		<(echo -e "\n") \
		<(\
			echo "${INI_CMD_VARIABLE_SECTION_DEFAULT}" \
				| sed "2i${CH_DIR_PATH}=\"${create_chdir_path}\"") \
		<(echo -e "\n") \
		<(echo "${SEARCH_INI_CMD_SECTION_START_NAME}") \
		<(echo "${main_contents}")
}