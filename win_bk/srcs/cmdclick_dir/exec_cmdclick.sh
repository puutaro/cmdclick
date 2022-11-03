#!/bin/bash

ITEM_THREAD="ITEM_THREAD_CM2GUI"
WINDOW_TITLE="Command Click"
COMMAND_CLICK_EXTENSION='.sh'
SOURCE_FILE_PATH="${0}"
SOURCE_DIR_PATH="$(dirname $0)"
COLOR_DIR_PATH="${SOURCE_DIR_PATH}/color"
LIB_DIR_PATH="${SOURCE_DIR_PATH}/lib"
EDIT_LIB_DIR_PATH="${LIB_DIR_PATH}/edit_lib"
WINDOW_ICON_PATH="${SOURCE_DIR_PATH}/images/cmdclick_image.png"
USER_HOME_DIR_PATH="${HOME}"
CMDCLICK_ROOT_DIR_PATH="${USER_HOME_DIR_PATH}/cmdclick"
CMDCLICK_CONF_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/conf"
CMDCLICK_PASTE_FILE_NAME="paste"
CMDCLICK_PASTE_FILE_PATH="${CMDCLICK_ROOT_DIR_PATH}/${CMDCLICK_PASTE_FILE_NAME}"
CMDCLICK_PASTE_SIGNAL_FILE_NAME="signal"
CMDCLICK_PASTE_SIGNAL_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_PASTE_SIGNAL_FILE_NAME}"
CMDCLICK_PASTE_CMD_FILE_NAME="paste_cmd"
CMDCLICK_PASTE_CMD_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_PASTE_CMD_FILE_NAME}"
CMDCLICK_DEFAULT_INI_FILE_DIR_PATH="${CMDCLICK_ROOT_DIR_PATH}/default"
CMDCLICK_DEFAULT_CD_FILE_NAME=$(echo ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} | sed 's/\//\_/g' | sed 's/^/cd\_/' | sed 's/$/'${COMMAND_CLICK_EXTENSION}'/' | sed 's/\_\_/\_/g')
CMDCLICK_DEFAULT_CD_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_DEFAULT_CD_FILE_NAME}"
INI_FILE_DIR_PATH="${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
CMDCLICK_CHANGE_DIR_CMD="CHANGE_DIR_CMD${COMMAND_CLICK_EXTENSION}"
CMDCLICK_DELETE_CMD="DELETE_CMD${COMMAND_CLICK_EXTENSION}"
CMDCLICK_ADD_CMD="ADD_CMD${COMMAND_CLICK_EXTENSION}"
CMDCLICK_EDIT_CMD="EDIT_CMD${COMMAND_CLICK_EXTENSION}"
CMDCLICK_RESOLUTION_CMD="RESOLUTION_CMD${COMMAND_CLICK_EXTENSION}"
CMDCLICK_SETTING_FILE="setting.ini"
CMDCLICK_CD_FILE_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_CHANGE_DIR_CMD}"
CMDCLICK_DELETE_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_DELETE_CMD}"
CMDCLICK_CONF_DELETE_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_DELETE_CMD}"
CMDCLICK_ADD_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_ADD_CMD}"
CMDCLICK_CONF_ADD_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_ADD_CMD}"
CMDCLICK_EDIT_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_EDIT_CMD}"
CMDCLICK_CONF_EDIT_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_EDIT_CMD}"
CMDCLICK_CONF_INC_CMD_NAME="cmdclidk_inc"
CMDCLICK_CONF_INC_CMD_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_CONF_INC_CMD_NAME}"
CMDCLICK_APP_LIST_NAME="cmdclidk_dir_list"
CMDCLICK_APP_LIST_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_APP_LIST_NAME}"
CMDCLICK_RESOLUTION_CMD_PATH="${INI_FILE_DIR_PATH}/${CMDCLICK_RESOLUTION_CMD}"
CMDCLICKL_SETTUING_FILE_NAME="cmdclick_setting.ini"
CMDCLICKL_SETTUING_FILE_PATH="${CMDCLICK_CONF_DIR_PATH}/${CMDCLICK_SETTING_FILE}"
CMDCLICK_SETTING_ITEM_WODTH="resolution_width"
CMDCLICK_SETTING_ITEM_HEIGHT="resolution_height"
GREP_SECONDS_INI_FILE_DIR_PATH="SECONDS_INI_FILE_DIR_PATH"
GREP_INC_NUM="INC_NUM"

CMDCLICK_INPUT_EXEC_ON="input_exec_on"
CMDCLICK_LOG_ON=1
SETTING_ELEMENT=("CMD_CLICK_TARGET_APP" "CMD_CLICK_SOURCE_APP" "CMDCLICK_EDITOR_CMD" "CMDCLICK_MNT_PRFIX" "CMDCLICK_USE_SHELL" "CMDCLICL_MAXIMIZE_GEO" "CMCCLICL_RIGHT_SIZE" "box_size")

REWRITE="no"
FILE_NAME_LENGH=45
FORCE_EXIT_CODE=50
CMD_EXECUTE_FILE_NAME=""
SIGNAL_CODE=0
CREATE_SOURCE_CMD=""
#button code
INDEX_CODE=10
ADD_CODE=3
DELETE_CODE=4
EDIT_CODE=2
EDIT_FULL_CODE=22
CHDIR_CODE=20
RESOLUTION_CODE=60
EXIT_CODE=1
OK_CODE=0
CHECK_ERR_CODE=11
EXCLU_LAST_FNAME_CLM=2
EDIT_CHAR_NUM=200
SCHEME_CHAR_NUME=35
INFO_BOX_DEFAULT_SIZE=(22 70)
CMDCLICK_BAR='################################################################'
CMDCLICK_CUATION_BAR='!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
EXECUTE_COMMAND=""
CMD_CLICK_ADD_TITLE=""
INDEX_TITLE_TEXT_MESSAGE=""
INDEX_SELECT_CMD_MESSAGE="please seclect command"
INDEX_CD_DIR_CMD_MESSAGE="please seclect change dir command"
DELETE_CMD_INDEX_MESSAGE="please seclect delete command"
EDIT_CMD_INDEX_MESSAGE="please seclect edit command"
ADD_COMMAND_MESSAGE="please type create command"
ADD_CD_PATH_MESSAGE="please type ini_file dir path"
SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME='CMD_VARIABLE_SECTION_START'
INI_CMD_VARIABLE_SECTION_START_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}"
SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME='CMD_VARIABLE_SECTION_END'
INI_CMD_VARIABLE_SECTION_END_NAME="### ${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}"
INI_CMD_VARIABLE_SECTION_DEFAULT="${INI_CMD_VARIABLE_SECTION_START_NAME}
${INI_CMD_VARIABLE_SECTION_END_NAME}"


CC_TERMINAL_NAME='CCerminal'
SEARCH_INI_SETTING_SECTION_START_NAME='SETTING_SECTION_START'
INI_SETTING_SECTION_START_NAME="### ${SEARCH_INI_SETTING_SECTION_START_NAME}"
SEARCH_INI_SETTING_SECTION_END_NAME='SETTING_SECTION_END'
INI_SETTING_SECTION_END_NAME="### ${SEARCH_INI_SETTING_SECTION_END_NAME}"
INI_TERMINAL_ON='terminal_on'
INI_OPEN_WHERE='open_where'
INI_TERMINAL_SIZE='terminal_size'
INI_TERMINAL_FOCUS='terminal_focus'
INI_INPUT_EXECUTE='input_execute'
INI_IN_EXE_DFLT_VL='in_exe_dflt_vl'
INI_BEFORE_COMMAND='before_command'
INI_AFTER_COMMAND='after_command'
INI_CMD_FILE_NAME='sh_file_name'
INI_SETTING_KEY_LIST=("${INI_TERMINAL_ON}" "${INI_OPEN_WHERE}" "${INI_TERMINAL_SIZE}" "${INI_TERMINAL_FOCUS}" "${INI_BEFORE_COMMAND}" "${INI_AFTER_COMMAND}" "${INI_CMD_FILE_NAME}")
SEARCH_INI_CMD_SECTION_START_NAME="### Please write bellow with shell script"
FULL_EDIT_BOOL="FULL_EDIT_BOOL"
CH_DIR_PATH='CH_DIR_PATH'
export CH_DIR_PATH=${CH_DIR_PATH}

INI_TERMINAL_ON_DEFAULT_GAIN="ON"
INI_OPEN_WHERE_DEFAULT_GAIN="CW"
INI_TERMINAL_SIZE_DEFAULT_GAIN="MAX"
INI_TERMINAL_FOCUS_DEFAULT_GAIN="OFF"
INI_INPUT_EXECUTE_DEFAULT_GAIN="N"
INI_IN_EXE_DFLT_VL_DEFAULT_GAIN=""
INI_BEFORE_COMMAND_DEFAULT_GAIN=""
INI_AFTER_COMMAND_DEFAULT_GAIN=""
INI_INI_CMD_FILE_NAME_DEFAULT_GAIN=""
INI_SETTING_DEFAULT_GAIN_LIST=("${INI_TERMINAL_ON_DEFAULT_GAIN}" "${INI_OPEN_WHERE_DEFAULT_GAIN}" "${INI_TERMINAL_SIZE_DEFAULT_GAIN}" "${INI_TERMINAL_FOCUS_DEFAULT_GAIN}" "${INI_BEFORE_COMMAND_DEFAULT_GAIN}" "${INI_AFTER_COMMAND_DEFAULT_GAIN}" "${INI_INI_CMD_FILE_NAME_DEFAULT_GAIN}")
INI_SETTING_DEFAULT_GAIN_CON="${INI_TERMINAL_ON}=${INI_TERMINAL_ON_DEFAULT_GAIN}
${INI_OPEN_WHERE}=${INI_OPEN_WHERE_DEFAULT_GAIN}
${INI_TERMINAL_SIZE}=${INI_TERMINAL_SIZE_DEFAULT_GAIN}
${INI_TERMINAL_FOCUS}=${INI_TERMINAL_FOCUS_DEFAULT_GAIN}
${INI_INPUT_EXECUTE}=${INI_INPUT_EXECUTE_DEFAULT_GAIN}
${INI_IN_EXE_DFLT_VL}=
${INI_BEFORE_COMMAND}=
${INI_AFTER_COMMAND}=
${INI_CMD_FILE_NAME}="

INI_TERMINAL_ON_DEFAULT_VALUE="(ON/OFF)"
INI_OPEN_WHERE_DEFAULT_VALUE="(CW/NT/NW)"
INI_TERMINAL_SIZE_DEFAULT_VALUE="(noUse)" #(MAX/RMAX/LMAX/DF)
INI_TERMINAL_FOCUS_DEFAULF_VALUE="(OFF/ON)"
INI_BEFORE_COMMAND_DEFAULT_VALUE=""
INI_AFTER_COMMAND_DEFAULT_VALUE=""
INI_INI_CMD_FILE_NAME_DEFAULT_VALUE=""
INI_SETTING_DEFAULT_VALUE_LIST=("${INI_TERMINAL_ON_DEFAULT_VALUE}" "${INI_OPEN_WHERE_DEFAULT_VALUE}" "${INI_TERMINAL_SIZE_DEFAULT_VALUE}" "${INI_TERMINAL_FOCUS_DEFAULF_VALUE}" "${INI_BEFORE_COMMAND_DEFAULT_VALUE}" "${INI_AFTER_COMMAND_DEFAULT_VALUE}" "${INI_INI_CMD_FILE_NAME_DEFAULT_VALUE}")


CMD_CLICK_VIRTICAL_VAR='CMD_CLICK_VIRTICAL_VAR'
CMDCLICK_ANPASAD='CMDCLICK_ANPASAD'
CMDCLICK_XTRAMATION='CMDCLICK_XTRAMATION'
CMDCLICK_DOUBLEQUOTE='CMDCLICK_DOUBLEQUOTE'
CMDCLICK_SINGLEQUOTE='CMDCLICK_SINGLEQUOTE'
CMDCLICK_BACKQUOTE='CMDCLICK_BACKQUOTE'
CMDCLICK_EQUALE='CMDCLICK_EQUALE'
CMDCLICK_HATHAT='CMDCLICK_HATHAT'
CMDCLICK_DAIKAKKO_MAE='CMDCLICK_DAIKAKKO_MAE'
CMDCLICK_DAIKAKKO_ATO='CMDCLICK_DAIKAKKO_ATO'
CMDCLICK_KAGIKAKKO_MAE='CMDCLICK_KAGIKAKKO_MAE'
CMDCLICK_KAGIKAKKO_ATO='CMDCLICK_KAGIKAKKO_ATO'
CMDCLICKKAKEZAN_MARK='CMDCLICKKAKEZAN_MARK'
CMDCLICK_DOLL_MARK='CMDCLICK_DOLL_MARK'
CMDCLICK_PLUS_MARK='CMDCLICK_PLUS_MARK'
CMDCLICK_HATENA_MARK='CMDCLICK_HATENA_MARK'
CMDCLICK_SEED_MARK='CMDCLICK_SEED_MARK'
CMDCLICK_BACKSEED_MARK='CMDCLICK_BACKSEED_MARK'
CMDCLICK_COLON_MARK='CMDCLICK_COLON_MARK'
CMDCLICK_COLONNAO_MARK='CMDCLICK_COLONNAO_MARK'
CMDCLICK_ATTO_MARK='CMDCLICK_ATTO_MARK'
CMDCLICK_NYORONYORO_MARK='CMDCLICK_NYORONYORO_MARK'
CMDCLICK_HUTUUKAKKO_MAE_MARK='CMDCLICK_HUTUUKAKKO_MAE_MARK'
CMDCLICK_HUTUUKAKKO_ATO_MARK='CMDCLICK_HUTUUKAKKO_ATO_MARK'
CMDCLICK_PERCENT_ATO_MARK='CMDCLICK_PERCENT_ATO_MARK'
CMDCLICK_SHARP_MARK='CMDCLICK_SHARP_MARK'
CMDCLICK_SLASH_MARK='CMDCLICK_SLASH_MARK'
CMDCLICK_BACKSLASH_MARK='CMDCLICK_BACKSLASH_MARK'
CMDCLICK_ONE_BACKSLASH_MARK='CMDCLICK_ONE_BACKSLASH_MARK'
CMDCLICK_N_CAHR='CMDCLICK_N_CAHR'
CMDCLICK_MINUS_MARK='CMDCLICK_MINUS_MARK'

EXEC_TERMINAL_ON=""
EXEC_OPEN_WHERE="" 
EXEC_WORKING_DIRECTORY="" 
EXEC_TERMINAL_SIZE=""
EXEC_TERMINAL_FOCUS=""
EXEC_INPUT_EXECUTE=""
EXEC_IN_EXE_DFLT_VL=""
EXEC_BEFORE_COMMAND="" 
EXEC_AFTER_COMMAND="" 
EXEC_EXEC_WAKE=""

EDIT_EDITOR_ON=""


case  "${IMPORT_CMDCLICK_VAL}" in 
	"")
		export DIALOGRC=${COLOR_DIR_PATH}/dialogrc
		. ${LIB_DIR_PATH}/add_cmd_ini.sh
		. ${LIB_DIR_PATH}/delete_cmd.sh
		. ${LIB_DIR_PATH}/resolution_cmd.sh
		. ${LIB_DIR_PATH}/check_ini_file.sh
		. ${LIB_DIR_PATH}/read_ini_to_cmd.sh
		. ${LIB_DIR_PATH}/edit_ini_file.sh
		. ${LIB_DIR_PATH}/input_gui.sh
		. ${LIB_DIR_PATH}/add_chdir.sh
		. ${EDIT_LIB_DIR_PATH}/make_ini_contensts.sh
		. ${EDIT_LIB_DIR_PATH}/edit_function.sh
		. ${EDIT_LIB_DIR_PATH}/convert_input_value.sh

		#add_cmd_ini_file
		LOOP=0
		SIGNAL_CODE=${INDEX_CODE}
		NORMAL_SIGNAL_CODE=${INDEX_CODE}
		ACTIVE_CHECK_VARIABLE=0
		resize_base_cmd(){
			local size_list=($(echo "${1}"))
			# nircmd.exe win activate ititle "'${WINDOW_TITLE}'" 
			# nircmd.exe win setsize ititle "'${WINDOW_TITLE}'" '${1}'
			powershell.exe -c '
				$host.UI.RawUI.WindowTitle = "'${WINDOW_TITLE}'"
				$MAIN_WINDOW_TITLE="*'${WINDOW_TITLE}'*"
				Add-Type -AssemblyName UIAutomationClient
				#Get-Processで取得できた1つ目のハンドルを対象とする。
				$hwnd=(Get-Process |?{$_.MainWindowTitle -like $MAIN_WINDOW_TITLE})[0].MainWindowHandle
				#ハンドルからウィンドウを取得する
				$window=[System.Windows.Automation.AutomationElement]::FromHandle($hwnd)
				#ウィンドウサイズの状態を把握するためにWindowPatternを使う
				$windowPattern=$window.GetCurrentPattern([System.Windows.Automation.WindowPattern]::Pattern)
				$windowPattern.SetWindowVisualState([System.Windows.Automation.WindowVisualState]::Normal)
				#ウィンドウサイズを変更するためのﾊﾟﾀｰﾝ。
				$transformPattern=$window.GetCurrentPattern([System.Windows.Automation.TransformPattern]::Pattern)
				#Maximamだと移動もｻｲｽﾞ変更もできないので注意。
				$transformPattern.Resize('${size_list[2]}','${size_list[3]}')
				$transformPattern.Move('${size_list[0]}','${size_list[1]}')
				'
		}
		right_box(){
			#nircmd win setsize process ${CMD_CLICK_SOURCE_APP}.exe ${CMCCLICL_RIGHT_SIZE}
			resize_base_cmd "${CMCCLICL_RIGHT_SIZE}"
			# nircmd.exe win activate ititle "${WINDOW_TITLE}"
			# nircmd.exe win setsize ititle "${WINDOW_TITLE}" ${CMCCLICL_RIGHT_SIZE}
			
			# wmctrl.exe -a ubuntu2004
			
		}
		export -f right_box

		center_box(){
		  #nircmd win setsize process ${CMD_CLICK_SOURCE_APP}.exe ${CMDCLICL_MAXIMIZE_GEO}
	  	  # nircmd.exe win setsize ititle "${WINDOW_TITLE}" "${CMDCLICL_MAXIMIZE_GEO}"
		  resize_base_cmd "${CMDCLICL_MAXIMIZE_GEO}"
		  # powershell.exe -c '
		  # 		$host.UI.RawUI.WindowTitle = "'${WINDOW_TITLE}'"
		  # 		$MAIN_WINDOW_TITLE="*'${WINDOW_TITLE}'*"
				# Add-Type -AssemblyName UIAutomationClient
				# $hwnd=(Get-Process |?{$_.MainWindowTitle -like $MAIN_WINDOW_TITLE})[0].MainWindowHandle
				# $window=[System.Windows.Automation.AutomationElement]::FromHandle($hwnd)
				# $windowPattern=$window.GetCurrentPattern([System.Windows.Automation.WindowPattern]::Pattern)
				# $windowPattern.SetWindowVisualState([System.Windows.Automation.WindowVisualState]::Maximized)'
		}

		maximize_app(){
		  local width=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_WODTH}=" | sed 's/'${CMDCLICK_SETTING_ITEM_WODTH}'\=//')
		  local height=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_HEIGHT}=" | sed 's/'${CMDCLICK_SETTING_ITEM_HEIGHT}'\=//')
		  case "${height}" in 
		  	""|"0") height=$(((${width} * 9) / 16)) ;;
		  esac
		  
		  local x_posi=0
		  local y_posi=0
		  local x_posi2=${width}
		  local y_posi2=${height}
		  open -a "${app_name}"
		  osascript \
		  -e "tell application \"${1}\" 
		  ignoring application responses
		  set bounds of front window to {${x_posi}, ${y_posi}, ${x_posi2}, ${y_posi2}}
		  end ignoring
		  end tell"
		}

		left_maximize_box(){
		  local width=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_WODTH}=" | sed 's/'${CMDCLICK_SETTING_ITEM_WODTH}'\=//')
		  local height=$(echo "${SETTING_SOURCE}" | grep "${CMDCLICK_SETTING_ITEM_HEIGHT}=" | sed 's/'${CMDCLICK_SETTING_ITEM_HEIGHT}'\=//')
		  case "${height}" in 
		  	""|"0") height=$(((${width} * 9) / 16)) ;;
		  esac
		  
		  local x_posi=0
		  local y_posi=0
		  local x_posi2=$((${width} / 2))
		  local y_posi2=${height}
		  open -a "${app_name}"
		  osascript \
		  -e "tell application \"${1}\" 
		  ignoring application responses
		  set bounds of front window to {${x_posi}, ${y_posi}, ${x_posi2}, ${y_posi2}} \
		  end ignoring
		  end tell"
		}

		right_maximize_box(){
			wmctrl.exe -a "${CMD_CLICK_SOURCE_APP}"
			# nircmd win setsize process ${CMD_CLICK_SOURCE_APP}.exe 1000 100 610 810
		  	nircmd.exe sendkeypress rwin+right
		}



		cmd_click_startup_app(){
			wmctrl.exe -a "${1}"
		  # local app_name="${1}"
		  # local app_path="/Applications/${app_name}.app"
		  # open "${app_name}"
		}


		open_new_tab_cmc(){
		  osascript -e "tell application \"${1}\" to activate
		    tell application \"System Events\" to keystroke \"t\" using command down"
		}

		cmd_click_paste_terminal(){
			local before_clip="$(wl-paste)"
			echo "${1}" | tr -d '\n' | wl-copy
			wmctrl.exe -a "${2}"
			nircmd.exe sendkeypress ctrl+shift+v
			nircmd.exe sendkeypress enter
			# powershell.exe -c 'add-type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait("^v{ENTER}")'
			echo -n "${before_clip}" | wl-copy
		}


		execute_cmd_by_xdotool(){
			cmd_click_paste_terminal "${1}" "${CMD_CLICK_TARGET_APP}" 
		}

		open_editor(){
			cd "$(dirname "${1}")"
	        ${CMDCLICK_EDITOR_CMD} "$(basename "${1}")"
		}
		export -f open_editor

		init(){
			# lecho "index:CMDCLICK_CD_FILE_PATH: ${CMDCLICK_CD_FILE_PATH}"
			# conf格納用ディレクトリがなければ作成
			if [ ! -d ${CMDCLICK_CONF_DIR_PATH} ]; then mkdir -p ${CMDCLICK_CONF_DIR_PATH}; fi
			# iniファイル格納用ディレクトリがなければ作成
			if [ ! -d ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH} ];then mkdir -p ${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH};fi 
			# change default dir file make 
			if [ ! -e ${CMDCLICK_DEFAULT_CD_FILE_PATH} ];then 
				add_chdir_cmd_ini_file "${CMDCLICK_DEFAULT_INI_FILE_DIR_PATH}"
			fi
			# lecho "SECONDS_INI_FILE_DIR_PATH:-1: ${SECONDS_INI_FILE_DIR_PATH}"
			if [ ! -e "${CMDCLICKL_SETTUING_FILE_PATH}" ] || [ ! -s "${CMDCLICKL_SETTUING_FILE_PATH}" ];then 
				local setting_source+="${SETTING_ELEMENT[0]}=WindowsTerminal"
				setting_source+="\n${SETTING_ELEMENT[1]}=ubuntu2004"
				setting_source+="\n${SETTING_ELEMENT[2]}=subl.exe"
				setting_source+="\n${SETTING_ELEMENT[3]}=/mnt"
				setting_source+="\n${SETTING_ELEMENT[4]}=#!/bin/bash"
				setting_source+="\n${SETTING_ELEMENT[5]}=70 50 1850 1050"
				setting_source+="\n# outdislay: 70 50 1850 1050"
				setting_source+="\n# innnerdisplay: 70 20 1300 750"
				setting_source+="\n${SETTING_ELEMENT[6]}=1400 330 520 770"
				setting_source+="\n# innerdisplay:outdisplay 900 130 480 640"
				setting_source+="\n# outdisplay: 1400 330 520 770"
				setting_source+="\n${SETTING_ELEMENT[7]}=1230 730 730"
				setting_source=$(echo -e "${setting_source}")
				echo -e "${setting_source}" > "${CMDCLICKL_SETTUING_FILE_PATH}" &
			else 
				local setting_source=$(cat "${CMDCLICKL_SETTUING_FILE_PATH}")
				echo "${setting_source}" | grep -e "^${SETTING_ELEMENT[0]}" -e "^${SETTING_ELEMENT[1]}" -e "^${SETTING_ELEMENT[2]}" -e "^${SETTING_ELEMENT[3]}" -e "^${SETTING_ELEMENT[4]}" -e "^${SETTING_ELEMENT[5]}" -e "^${SETTING_ELEMENT[6]}"  -e "^${SETTING_ELEMENT[7]}" | sort | uniq | wc -l | [ ! $(cat) -eq 8 ] && echo "setting file manual repaer" && exit 0			 
			fi
			CMD_CLICK_TARGET_APP="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[0]}'/p' | sed 's/'${SETTING_ELEMENT[0]}'=//')"
			CMD_CLICK_SOURCE_APP="$(echo "${setting_source}"| sed -n '/'${SETTING_ELEMENT[1]}'/p' | sed 's/'${SETTING_ELEMENT[1]}'=//')"
			CMDCLICK_EDITOR_CMD="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[2]}'/p' | sed 's/'${SETTING_ELEMENT[2]}'=//')"
			CMDCLICK_MNT_PRFIX="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[3]}'/p' | sed 's/'${SETTING_ELEMENT[3]}'=//')"
			CMDCLICK_USE_SHELL="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[4]}'/p' | sed 's/'${SETTING_ELEMENT[4]}'=//')"
			CMDCLICL_MAXIMIZE_GEO="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[5]}'/p' | sed 's/'${SETTING_ELEMENT[5]}'=//')"
			CMCCLICL_RIGHT_SIZE="$(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[6]}'/p' | sed 's/'${SETTING_ELEMENT[6]}'=//')"
			box_size=($(echo "${setting_source}" | sed -n '/'${SETTING_ELEMENT[7]}'/p' | sed 's/'${SETTING_ELEMENT[7]}'=//'))
			# becuase use in input gui's fzf
			export CMDCLICK_EDITOR_CMD=${CMDCLICK_EDITOR_CMD}
		}
		init

		while true :
		do
			# lecho "BEFORE INDEX SIGNAL_CODE: ${SIGNAL_CODE}"
			case "${NORMAL_SIGNAL_CODE}" in 
				"${INDEX_CODE}")
					. ${SOURCE_DIR_PATH}/index.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE}
					;;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${OK_CODE}")
					. ${SOURCE_DIR_PATH}/execute.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${ADD_CODE}")
					. ${SOURCE_DIR_PATH}/add.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${EDIT_CODE}")
					. ${SOURCE_DIR_PATH}/edit.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${DELETE_CODE}")
					. ${SOURCE_DIR_PATH}/delete.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${CHDIR_CODE}")
					# lecho "### chdir rand :${SIGNAL_CODE}"
					. ${SOURCE_DIR_PATH}/chdir/chdir.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE};;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${RESOLUTION_CODE}")
					. ${SOURCE_DIR_PATH}/resolution.sh
					NORMAL_SIGNAL_CODE=${SIGNAL_CODE} ;;
			esac

			case "${NORMAL_SIGNAL_CODE}" in 
				"${FORCE_EXIT_CODE}")
					LOOP=0
					# lecho "${EXIT_CODE} SIGNAL_CODE: ${SIGNAL_CODE}"
					exit 0 ;;
			esac

			case "${LOOP}" in 
				"5")
					# lecho "EXIT_CODE: ${SIGNAL_CODE}"
					exit 0 ;;
			esac
			LOOP=$(expr ${LOOP} + 1)
		done
		;;
esac
