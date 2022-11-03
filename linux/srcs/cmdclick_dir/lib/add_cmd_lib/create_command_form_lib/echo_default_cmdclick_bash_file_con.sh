#!/bin/bash

echo_default_cmdclick_bash_file_con(){
	local temp_file_name="${1}"
	cat <(echo "${CMDCLICK_CREATE_FILE_SHIBAN}") \
		<(echo "") \
		<(echo "${INI_LABELING_SECTION_START_NAME}")  \
		<(echo "${INI_LABELING_SECTION_END_NAME}") \
		<(echo -e "\n") \
		<(echo "${INI_SETTING_SECTION_START_NAME}") \
		<(echo "${INI_SETTING_DEFAULT_GAIN_CON}" \
			| sed -r "s/(${INI_CMD_FILE_NAME}=)/\1${temp_file_name}/") \
		<(echo "${INI_SETTING_SECTION_END_NAME}") \
		<(echo -e "\n") \
		<(echo "${INI_CMD_VARIABLE_SECTION_DEFAULT}")  \
		<(echo -e "\n") \
		<(echo "${SEARCH_INI_CMD_SECTION_START_NAME}") \
		<(echo -e "\n ")
}