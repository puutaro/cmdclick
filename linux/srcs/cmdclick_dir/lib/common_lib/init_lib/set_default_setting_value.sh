#!/bin/bash



set_default_setting_value(){
	if [ ! -e "${CMDCLICK_INI_SETTING_FILE_PATH}" ]; then
		echo "${CMDCLICK_DEFAULT_SETTING_CON}" \
			> "${CMDCLICK_INI_SETTING_FILE_PATH}"
		PASTE_AFTER_ENTER_BOOL="${PASTE_AFTER_ENTER_DEFAULT_VALUE}"
		PASTE_TARGET_TERMINAL_NAME=${PASTE_TARGET_TERMINAL_DEFAULT_VALUE}
		export CMDCLICK_EDITOR_CMD_STR="${CMDCLICK_EDITOR_CMD_DEFAULT_VALUE}"
		CMDCLICK_CREATE_FILE_SHIBAN="${CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE}"
		CMDCLICK_RUN_SHELL="${CMDCLICK_RUN_SHELL_DEFAULT_VALUE}"
	else 
		local setting_con="$(\
			cat "${CMDCLICK_INI_SETTING_FILE_PATH}" \
		)"
		PASTE_AFTER_ENTER_BOOL=$(
			fetch_parameter \
				"${setting_con}" \
				"${CMDCLICK_INI_PASTE_AFTER_ENTER}" \
		)
		PASTE_TARGET_TERMINAL_NAME=$(
			fetch_parameter \
				"${setting_con}" \
				"${CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME}" \
		)
		export CMDCLICK_EDITOR_CMD_STR=$(
			fetch_parameter \
				"${setting_con}" \
				"${CMDCLICK_INI_OPEN_EDITOR_CMD}" \
		)
		CMDCLICK_CREATE_FILE_SHIBAN=$(
			fetch_parameter \
				"${setting_con}" \
				"${CMDCLICK_INI_CREATE_FILE_SHIBAN}" \
		)
		CMDCLICK_RUN_SHELL=$(
			fetch_parameter \
				"${setting_con}" \
				"${CMDCLICK_INI_RUN_SHELL}" \
		)
	fi
	case "${PASTE_AFTER_ENTER_BOOL:-}" in
		"ON") ;; 
		"OFF") ;;
		*) PASTE_AFTER_ENTER_BOOL="${PASTE_AFTER_ENTER_DEFAULT_VALUE}" ;;
	esac
	case "${PASTE_TARGET_TERMINAL_NAME:-}" in
		"") PASTE_TARGET_TERMINAL_NAME="${PASTE_TARGET_TERMINAL_DEFAULT_VALUE}" ;;
	esac
	local wt_app_name="WindowsTerminal"
	case "${PASTE_TARGET_TERMINAL_NAME}" in
		"${wt_app_name}"|"${wt_app_name,,}") START_EXE_NAME="wt" ;;
		*) START_EXE_NAME="${PASTE_TARGET_TERMINAL_NAME}"
	;; esac
	case "${CMDCLICK_EDITOR_CMD_STR:-}" in
		"") export CMDCLICK_EDITOR_CMD_STR="${CMDCLICK_EDITOR_CMD_DEFAULT_VALUE}"
	;;esac
	case "${CMDCLICK_CREATE_FILE_SHIBAN:-}" in
		"") CMDCLICK_CREATE_FILE_SHIBAN="${CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE}" ;;
	esac
	case "${CMDCLICK_RUN_SHELL:-}" in
		"") CMDCLICK_RUN_SHELL="${CMDCLICK_RUN_SHELL_DEFAULT_VALUE}" ;;
	esac
}