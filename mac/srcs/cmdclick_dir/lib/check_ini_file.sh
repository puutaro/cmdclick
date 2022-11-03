#!/bin/bash

check_ini_file(){
	local rewrite="no"
	case "${2}" in 
		"")
			local validate_err_message="validation err: "
			if [ ! -e "$1" ]; then
				rewrite="yes"
				validate_err_message+="file locate or name err ("$1")"
			fi
			case "${rewrite}" in "no") local ini_contents=$(cat "$1");; esac
			;;
		*) local ini_contents="${1}" 
			;;
	esac

	#セクションネームをチェック
	case "${rewrite}" in 
		"no")
		    # lecho "ini_contents ${ini_contents}"
		    local get_cmd_sec_num=$(echo "${ini_contents}" | rga -e "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}" -e "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}" | wc -l | tr -d ' ')
		    case "${get_cmd_sec_num}" in 
		    	"2");;
				*) 
					case "${get_cmd_sec_num}" in
						"0");;
						*)
							rewrite="yes"
				    		local validate_err_message+="CMD_SECTION_HOLDER NUM ERR, "
				  			;;
					esac 
					
			esac

			local get_cmd_sec_uniq_num=$(echo "${ini_contents}" | rga -e "${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}$" -e "${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}$" | uniq | wc -l | tr -d ' ')
			case "${get_cmd_sec_num}" in 
		    	"2");;
				*) 
					case "${get_cmd_sec_num}" in
						"0");;
						*)
							rewrite="yes"
				    		local validate_err_message+="CMD_SECTION_HOLDER CONBI ERR, "
				  			;;
					esac 
					
			esac

			local get_set_sec_num=$(echo "${ini_contents}" | rga -e "${SEARCH_INI_SETTING_SECTION_START_NAME}" -e "${SEARCH_INI_SETTING_SECTION_END_NAME}" | wc -l | tr -d ' ')
			case "${get_set_sec_num}" in 
		    	"2");;
				*) 
					case "${get_set_sec_num}" in
						"0");;
						*)
							rewrite="yes"
				    		local validate_err_message+="SETTING_SECTION_HOLDER NUM ERR, "
				  			;;
					esac 
			esac

		    local get_set_sec_uniq_num=$(echo "${ini_contents}" | rga -e "${SEARCH_INI_SETTING_SECTION_START_NAME}$" -e "${SEARCH_INI_SETTING_SECTION_END_NAME}$" | uniq | wc -l | tr -d ' ')
		    case "${get_set_sec_uniq_num}" in 
		    	"2");;
				*) 
					case "${get_set_sec_uniq_num}" in
						"0");;
						*)
							rewrite="yes"
				    		local validate_err_message+="SETTING_SECTION_HOLDER CONBI ERR, "
				  			;;
					esac 
			esac
			local validate_source_con=$(cat <(echo "${ini_contents}" | sed -n '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/,/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_CMD_VARIABLE_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=") <(echo "${ini_contents}" | sed -n '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/,/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/p' | sed '/'${SEARCH_INI_SETTING_SECTION_START_NAME}'/d' | sed '/'${SEARCH_INI_SETTING_SECTION_END_NAME}'/d' | rga "^[a-zA-Z0-9_-]{1,100}=")  | sed '/^$/d' )

			local get_blank_no_include_quote_err=$(echo "${validate_source_con}" | rga "\s" | rga -e "^[a-zA-Z0-9_-]{1,100}=[^\"']" -e "[^\"']$")
			if [ -n "${get_blank_no_include_quote_err}"  ];then 
				rewrite="yes"
				local validate_err_message+="blank isn't included by quote, "
			fi
			;;
	esac
	# lecho "rewrite: ${rewrite}"
	# lecho "validate_err_message: ${validate_err_message}"
	case "${1}" in 
		"${INI_FILE_DIR_PATH}/")
			rewrite="no"
			SIGNAL_CODE=${INDEX_CODE}
			;;
	esac

	case "${rewrite}" in 
		"yes")
			center_box &
			case "${2}" in 
				"")
					local check_message=$(cat <(echo "bellow err, please ini file manual repair or delete \n (FILEPATH: "$1")") <(echo "${validate_err_message}"))
					echo "${CMDCLICK_EDITOR_CMD} ${1}" | pbcopy &
					;;
				*)
					local check_message=$(cat <(echo "bellow err, please re-edit  \n\n") <(echo "  ${validate_err_message}"))
					;;
			esac
			# lecho "${check_message}"
			dialog --title "${WINDOW_TITLE}"  --no-shadow --msgbox "${check_message}" "${INFO_BOX_DEFAULT_SIZE[@]}"
			clear
			SIGNAL_CODE=${CHECK_ERR_CODE}
			# lecho SIGNAL_CODE
			;;
	esac
}
