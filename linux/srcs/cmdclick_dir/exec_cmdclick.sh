#!/bin/bash

set -ue

LANG=C
readonly ITEM_THREAD="ITEM_THREAD_CM2GUI"
readonly APP_MODE_FILE_PATH="${1:-}"
readonly CMDCLICK_WINDOW_TITLE="Command Click"
readonly COMMAND_CLICK_EXTENSION='.sh'
readonly SOURCE_FILE_PATH="${0}"
readonly SOURCE_DIR_PATH="$(dirname $0)"
readonly LIB_DIR_PATH="${SOURCE_DIR_PATH}/lib"
readonly COMMON_LIB_DIR_PATH="${LIB_DIR_PATH}/common_lib"
readonly EDIT_LIB_DIR_PATH="${LIB_DIR_PATH}/edit_lib"
readonly INPUT_GUI_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/input_gui_lib"
readonly INIT_LIB_DIR_PATH="${COMMON_LIB_DIR_PATH}/init_lib"
readonly WINDOW_ICON_PATH="${SOURCE_DIR_PATH}/images/cmdclick_image.png"
readonly USER_HOME_DIR_PATH="/home/${USER}"
readonly CMDCLICK_ROOT_DIR_PATH="${USER_HOME_DIR_PATH}/cmdclick"
export CMDCLICK_CONF_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/conf"
export CMDCLICK_APP_DIR_PATH="${CMDCLICK_CONF_DIR_PATH}/app"
readonly CMDCLICK_VALUE_SIGNAL_FILE_NAME="signal"
readonly CMDCLICK_VALUE_SIGNAL_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_VALUE_SIGNAL_FILE_NAME}"
readonly CMDCLICK_DEFAULT_INI_FILE_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/default"
readonly CMDCLICK_DEFAULT_CD_FILE_NAME=$(echo ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} | sed 's/\//\_/g' | sed 's/^/cd\_/' | sed 's/$/'${COMMAND_CLICK_EXTENSION}'/' | sed 's/\_\_/\_/g')
readonly CMDCLICK_DEFAULT_CD_FILE_PATH="${CMDCLICK_APP_DIR_PATH}/${CMDCLICK_DEFAULT_CD_FILE_NAME}"
INI_FILE_DIR_PATH="${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
readonly CMDCLICK_CONF_INC_CMD_NAME="cmdclidk_inc"
readonly CMDCLICK_CONF_INC_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_CONF_INC_CMD_NAME}"
readonly CMDCLICK_APP_LIST_NAME="cmdclidk_dir_list"
readonly CMDCLICK_APP_LIST_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_APP_LIST_NAME}"
readonly GREP_INC_NUM="INC_NUM"
readonly CMDCLICK_INI_SETTING_FILE_NAME="cmdclick_setting"
readonly CMDCLICK_INI_SETTING_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_INI_SETTING_FILE_NAME}"
readonly CMDCLICK_INI_PASTE_AFTER_ENTER="pasteAfterEnter"
readonly CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME="pasteTargetTerminalName"
readonly CMDCLICK_INI_OPEN_EDITOR_CMD="openEditorCmd"
readonly CMDCLICK_INI_CREATE_FILE_SHIBAN="shiban"
readonly CMDCLICK_INI_RUN_SHELL="runShell"
readonly PASTE_AFTER_ENTER_DEFAULT_VALUE="OFF"
readonly PASTE_TARGET_TERMINAL_DEFAULT_VALUE="terminal"
readonly CMDCLICK_EDITOR_CMD_DEFAULT_VALUE="subl"
readonly CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE="#!/bin/bash"
readonly CMDCLICK_RUN_SHELL_DEFAULT_VALUE="bash"
readonly CMDCLICK_SETTING_KEY_CON="${CMDCLICK_INI_PASTE_AFTER_ENTER}
${CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME}
${CMDCLICK_INI_OPEN_EDITOR_CMD}
${CMDCLICK_INI_CREATE_FILE_SHIBAN}
${CMDCLICK_INI_RUN_SHELL}"
readonly PASTE_AFTER_ENTER_DEFAULT_CB_VALUE="ON!OFF"
readonly CMDCLICK_DEFAULT_SETTING_CON="${CMDCLICK_INI_PASTE_AFTER_ENTER}=${PASTE_AFTER_ENTER_DEFAULT_VALUE}
${CMDCLICK_INI_PASTE_TARGET_TERMINAL_NAME}=${PASTE_TARGET_TERMINAL_DEFAULT_VALUE}
${CMDCLICK_INI_OPEN_EDITOR_CMD}=${CMDCLICK_EDITOR_CMD_DEFAULT_VALUE}
${CMDCLICK_INI_CREATE_FILE_SHIBAN}=${CMDCLICK_CREATE_FILE_SHIBAN_DEFAULT_VALUE}
${CMDCLICK_INI_RUN_SHELL}=${CMDCLICK_RUN_SHELL_DEFAULT_VALUE}"

SIGNAL_CODE=0
CHDIR_SIGNAL_CODE=0
#button code
readonly OK_CODE=0
readonly EXIT_CODE=1
readonly EDIT_CODE=2
readonly ADD_CODE=3
readonly DELETE_CODE=4
readonly DESCRIPTION_EDIT_CODE=5
readonly MOVE_CODE=6
readonly INSTALL_CODE=7
readonly INDEX_CODE=10
readonly CHECK_ERR_CODE=11
readonly SETTING_CODE=12
readonly CHDIR_CODE=20
readonly EDIT_FULL_CODE=22
readonly FORCE_EXIT_CODE=50
readonly EXIT_CODE_SOURCE=252
EXECUTE_COMMAND=""
CMD_CLICK_ADD_TITLE=""
INDEX_TITLE_TEXT_MESSAGE=""
readonly INDEX_SELECT_CMD_MESSAGE="please seclect command"
readonly INDEX_CD_DIR_CMD_MESSAGE="please seclect change dir command"
readonly ADD_COMMAND_MESSAGE="please type create command"
readonly ADD_CD_PATH_MESSAGE="please type after ${HOME} by ini_file dir path"
readonly SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME='CMD_VARIABLE_SECTION_START'
readonly INI_CMD_VARIABLE_SECTION_START_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}"
readonly SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME='CMD_VARIABLE_SECTION_END'
readonly INI_CMD_VARIABLE_SECTION_END_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
readonly INI_CMD_VARIABLE_SECTION_DEFAULT="${INI_CMD_VARIABLE_SECTION_START_NAME}
${INI_CMD_VARIABLE_SECTION_END_NAME}"
readonly CC_TERMINAL_NAME='CCerminal'
readonly SEARCH_INI_SETTING_SECTION_START_NAME='SETTING_SECTION_START'
readonly INI_SETTING_SECTION_START_NAME="### ${SEARCH_INI_SETTING_SECTION_START_NAME}"
readonly SEARCH_INI_SETTING_SECTION_END_NAME='SETTING_SECTION_END'
readonly INI_SETTING_SECTION_END_NAME="### ${SEARCH_INI_SETTING_SECTION_END_NAME}"
export SEARCH_INI_LABELING_SECTION_START_NAME='LABELING_SECTION_START'
readonly INI_LABELING_SECTION_START_NAME="### ${SEARCH_INI_LABELING_SECTION_START_NAME}"
export SEARCH_INI_LABELING_SECTION_END_NAME='LABELING_SECTION_END'
readonly INI_LABELING_SECTION_END_NAME="### ${SEARCH_INI_LABELING_SECTION_END_NAME}"
readonly INI_TERMINAL_ON='terminalDo'
readonly INI_OPEN_WHERE='openWhere'
readonly INI_TERMINAL_FOCUS='terminalFocus'
readonly INI_EDIT_EXECUTE='editExecute'
readonly INI_SET_VARIABLE_TYPE='setVariableType'
readonly INI_BEFORE_COMMAND='beforeCommand'
readonly INI_AFTER_COMMAND='afterCommand'
readonly INI_EXEC_BEFORE_CTRL_CMD='execBeforeCtrlCmd'
readonly INI_EXEC_AFTER_CTRL_CMD='execAfterCtrlCmd'
readonly INI_CMD_FILE_NAME='shellFileName'
readonly INI_SHELL_ARGS='shellArgs'
readonly INI_SETTING_KEY_LIST=("${INI_TERMINAL_ON}" "${INI_OPEN_WHERE}" "${INI_TERMINAL_FOCUS}" "${INI_EDIT_EXECUTE}" "${INI_SET_VARIABLE_TYPE}" "${INI_BEFORE_COMMAND}" "${INI_AFTER_COMMAND}" "${INI_EXEC_BEFORE_CTRL_CMD}" "${INI_EXEC_AFTER_CTRL_CMD}" "${INI_CMD_FILE_NAME}")
readonly SEARCH_INI_CMD_SECTION_START_NAME="### Please write bellow with shell script"
export CH_DIR_PATH='CH_DIR_PATH'

readonly INI_TERMINAL_ON_DEFAULT_GAIN="ON"
readonly INI_OPEN_WHERE_DEFAULT_GAIN="CW"
readonly INI_TERMINAL_FOCUS_DEFAULT_GAIN="OFF"
readonly INI_EDIT_EXECUTE_DEFAULT_GAIN="NO"
readonly INI_SET_VARIABLE_TYPE_DEFAULT_GAIN=""
readonly INI_BEFORE_COMMAND_DEFAULT_GAIN=""
readonly INI_AFTER_COMMAND_DEFAULT_GAIN=""
readonly INI_EXEC_BEFORE_CTRL_CMD_DEFAULT_GAIN=""
readonly INI_EXEC_AFTER_CTRL_CMD_DEFAULT_GAIN=""
readonly INI_INI_CMD_FILE_NAME_DEFAULT_GAIN=""

readonly INI_SETTING_DEFAULT_GAIN_CON="${INI_TERMINAL_ON}=${INI_TERMINAL_ON_DEFAULT_GAIN}
${INI_OPEN_WHERE}=${INI_OPEN_WHERE_DEFAULT_GAIN}
${INI_TERMINAL_FOCUS}=${INI_TERMINAL_FOCUS_DEFAULT_GAIN}
${INI_EDIT_EXECUTE}=${INI_EDIT_EXECUTE_DEFAULT_GAIN}
${INI_SET_VARIABLE_TYPE}=
${INI_BEFORE_COMMAND}=
${INI_AFTER_COMMAND}=
${INI_EXEC_BEFORE_CTRL_CMD}=
${INI_EXEC_AFTER_CTRL_CMD}=
${INI_CMD_FILE_NAME}="
readonly INI_EXECUTE_SETTING_DEFAULT_GAIN_CON="${INI_SETTING_DEFAULT_GAIN_CON}
${INI_SHELL_ARGS}="

readonly ALWAYS_EDIT_EXECUTE="ALWAYS"
readonly ONCE_EDIT_EXECUTE="ONCE"
readonly NO_EDIT_EXECUTE="NO"

readonly INI_TERMINAL_ON_DEFAULT_VALUE="ON!OFF"
readonly INI_OPEN_WHERE_DEFAULT_VALUE="CW!NT"
readonly INI_TERMINAL_FOCUS_DEFAULF_VALUE="OFF!ON"
readonly INI_EDIT_EXECUTE_DEFAULF_VALUE="${NO_EDIT_EXECUTE}!${ONCE_EDIT_EXECUTE}!${ALWAYS_EDIT_EXECUTE}"
readonly INI_SET_VARIABLE_TYPE_DEFAULT_VALUE=""
readonly INI_BEFORE_COMMAND_DEFAULT_VALUE=""
readonly INI_AFTER_COMMAND_DEFAULT_VALUE=""
readonly INI_INI_CMD_FILE_NAME_DEFAULT_VALUE=""
readonly INI_EXEC_BEFORE_CTRL_CMD_DEFAULT_VALUE=""
readonly INI_EXEC_AFTER_CTRL_CMD_DEFAULT_VALUE=""
readonly INI_SETTING_DEFAULT_VALUE_CONS="${INI_TERMINAL_ON}=${INI_TERMINAL_ON_DEFAULT_VALUE}
${INI_OPEN_WHERE}=${INI_OPEN_WHERE_DEFAULT_VALUE}
${INI_TERMINAL_FOCUS}=${INI_TERMINAL_FOCUS_DEFAULF_VALUE}
${INI_EDIT_EXECUTE}=${INI_EDIT_EXECUTE_DEFAULF_VALUE}
${INI_SET_VARIABLE_TYPE}=${INI_SET_VARIABLE_TYPE_DEFAULT_VALUE}
${INI_BEFORE_COMMAND}=${INI_BEFORE_COMMAND_DEFAULT_VALUE}
${INI_AFTER_COMMAND}=${INI_AFTER_COMMAND_DEFAULT_VALUE}
${INI_EXEC_BEFORE_CTRL_CMD}=${INI_EXEC_BEFORE_CTRL_CMD_DEFAULT_VALUE}
${INI_EXEC_AFTER_CTRL_CMD}=${INI_EXEC_AFTER_CTRL_CMD_DEFAULT_VALUE}
${INI_CMD_FILE_NAME}=${INI_INI_CMD_FILE_NAME_DEFAULT_VALUE}"

EXEC_TERMINAL_ON=""
EXEC_OPEN_WHERE="" 
EXEC_WORKING_DIRECTORY="" 
EXEC_TERMINAL_FOCUS=""
EXEC_EDIT_EXECUTE=""
EXEC_SET_VARIABLE_TYPE=""
EXEC_BEFORE_COMMAND="" 
EXEC_AFTER_COMMAND=""
EXEC_BEFORE_CTRL_CMD=""
EXEC_AFTER_CTRL_CMD=""
EXEC_SHELL_ARGS=""

COUNT_EXEC_EDIT_EXECUTE=0

case  "${IMPORT_CMDCLICK_VAL:-}" in 
	"");; *) return;; esac
. "${LIB_DIR_PATH}/check_ini_file.sh"
. "${LIB_DIR_PATH}/check_ini_std_out.sh"
. "${EDIT_LIB_DIR_PATH}/edit_ini_file.sh"
. "${INPUT_GUI_LIB_DIR_PATH}/upgrade_app_dir_list_order.sh"
. "${INPUT_GUI_LIB_DIR_PATH}/echo_display_ini_file_dir_path.sh"
. "${INIT_LIB_DIR_PATH}/set_default_setting_value.sh"
. "${INIT_LIB_DIR_PATH}/read_resolution_from_system.sh"
. "${INIT_LIB_DIR_PATH}/make_requrement_dir.sh"
. "${INIT_LIB_DIR_PATH}/switch_cmdclick_or_app_mode.sh"
. "${COMMON_LIB_DIR_PATH}/echo_by_convert_xml_escape_sequence.sh"
. "${COMMON_LIB_DIR_PATH}/echo_removed_double_quote_both_ends.sh"
. "${COMMON_LIB_DIR_PATH}/fetch_parameter_from_pip.sh"
. "${COMMON_LIB_DIR_PATH}/mv_ini_file_when_rename.sh"
. "${COMMON_LIB_DIR_PATH}/echo_by_remove_pre_or_suffix_single_quote.sh"
. "${COMMON_LIB_DIR_PATH}/echo_labeling_section_bitween_start_and_end.sh"
. "${COMMON_LIB_DIR_PATH}/echo_only_parameter_value.sh"
. "${COMMON_LIB_DIR_PATH}/get_by_window_title.sh"
. "${COMMON_LIB_DIR_PATH}/echo_longpath_by_summraizing.sh"
. "${COMMON_LIB_DIR_PATH}/confirm_edit_contensts.sh"
. "${COMMON_LIB_DIR_PATH}/choose_app_dir_list_for_move.sh"
. "${COMMON_LIB_DIR_PATH}/input_gui.sh"
. "${COMMON_LIB_DIR_PATH}/reactive_when_aleady_exist_cmdclick.sh"
. "${COMMON_LIB_DIR_PATH}/surround_single_double_quote_when_existing_space_or_quote.sh"
export -f fetch_parameter
export -f fetch_parameter_from_pip
export -f echo_labeling_section_bitween_start_and_end
export -f echo_labeling_section_bitween_start_and_end_from_pip
export -f echo_longpath_by_summraizing
LOOP=0
ACTIVE_CHECK_VARIABLE=0


execute_cmd_by_xdotool(){
	local ccerminal_acctive_state=$(\
		wmctrl -lx \
		| grep -i "${2}" \
		| grep -i "${PASTE_TARGET_TERMINAL_NAME}" \
		| tail -n -1 \
		| awk '{print $1}' \
		|| e=$? \
	)
	case "${ccerminal_acctive_state}" in 
		"");;
		*) 
			local clip_con=$(xclip -selection c -o)
			echo "${1}" | xclip -selection clipboard
			xdotool key "ctrl+shift+v"
			test "${PASTE_AFTER_ENTER_BOOL}" == "ON" \
				&& xdotool key Return
    		echo -n "${clip_con}" | xclip -selection c -i
    		;;
    esac
    #CCerminal or terminalがあれば、ウィンドウをアクティブにし、CCerminal化
	ccerminal_acctive_state=$(\
		wmctrl -lx \
		| grep -i "${2}" \
		| grep -i "${PASTE_TARGET_TERMINAL_NAME}" \
		| tail -n -1 \
		| awk '{print $1}' \
		|| e=$? \
	)
	case "${ccerminal_acctive_state}" in 
		"") EXECUTE_COMMAND="";;
		*)
			wmctrl -i -a "${2}"
			wmctrl -r :ACTIVE: -N "${CC_TERMINAL_NAME}"
			;;
	esac
}

init(){
	switch_cmdclick_or_app_mode \
		"${APP_MODE_FILE_PATH}"
	make_requrement_dir
	set_default_setting_value
	# change default dir file make 
	if [ ! -e ${CMDCLICK_DEFAULT_CD_FILE_PATH} ];then 
		add_chdir_cmd_ini_file \
			"${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
	fi
	read_resolution_from_system
	reactive_when_aleady_exist_cmdclick
}

init

open_editor(){
    ${CMDCLICK_EDITOR_CMD_STR} "${1}"
}
export -f open_editor


while true :
do
	case "${NORMAL_SIGNAL_CODE}" in
		"${INDEX_CODE}")
			. "${LIB_DIR_PATH}/index.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE}
			;;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${OK_CODE}")
			. "${LIB_DIR_PATH}/execute.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${ADD_CODE}")
			. "${LIB_DIR_PATH}/add_cmd.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${EDIT_CODE}")
			. "${LIB_DIR_PATH}/edit.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${DESCRIPTION_EDIT_CODE}")
			. "${LIB_DIR_PATH}/description_edit.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${MOVE_CODE}")
			. "${LIB_DIR_PATH}/move.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${INSTALL_CODE}")
			. "${LIB_DIR_PATH}/install.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${DELETE_CODE}")
			. "${LIB_DIR_PATH}/delete.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${CHDIR_CODE}")
			. "${LIB_DIR_PATH}/add_chdir.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
	esac

	case "${NORMAL_SIGNAL_CODE}" in
		"${SETTING_CODE}")
			. "${LIB_DIR_PATH}/setting.sh"
			NORMAL_SIGNAL_CODE=${SIGNAL_CODE} ;;
	esac

	case "${NORMAL_SIGNAL_CODE}" in 
		"${FORCE_EXIT_CODE}")
			LOOP=0
			exit 0 ;;
	esac

	case "${LOOP}" in 
		"5")
			exit 0 ;;
	esac
	LOOP=$(expr ${LOOP} + 1)
done
