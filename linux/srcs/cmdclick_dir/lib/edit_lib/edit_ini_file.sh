#!/bin/bash


EDIT_INI_FILE_LIB_DIR_PATH="${EDIT_LIB_DIR_PATH}/edit_ini_file_lib"

. "${EDIT_INI_FILE_LIB_DIR_PATH}/make_ini_contents.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/edit_function.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/convert_input_value.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/echo_ini_contents_moto.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/echo_ch_dir_path_parameter_if_chdir_first_roop.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/mv_app_dir.sh"
. "${EDIT_INI_FILE_LIB_DIR_PATH}/echo_signal_code_by_two_over_when_edit_execute.sh"
unset -v EDIT_INI_FILE_LIB_DIR_PATH


edit_ini_gui(){
  local LANG=C
  local ROOP_NUM=0
  local INI_CONTENTS=""
  local EDIT_FILE_NAME="${1}"
  local exec_edit_execute="${2:-${NO_EDIT_EXECUTE}}"
  local ch_dir_path_parameter_before=""
  local EDIT_FILE_PATH="${INI_FILE_DIR_PATH}/${EDIT_FILE_NAME}"
  while :
  do
    ROOP_NUM=$((${ROOP_NUM} + 1))
    local ini_contents_moto=$(\
      echo_ini_contents_moto \
        "${ROOP_NUM}" \
        "${INI_CONTENTS}" \
        "${EDIT_FILE_NAME}" \
    )
    ch_dir_path_parameter_before=$(\
      echo_ch_dir_path_parameter_if_chdir_first_roop \
          "${CHDIR_SIGNAL_CODE}" \
          "${ROOP_NUM}" \
          "${ini_contents_moto}" \
          "${ch_dir_path_parameter_before}" \
    )
    local EDIT_DESCRIPTION=""
    local VARIABLE_CONTENSTS_FIELD_LIST=()
    local VARIABLE_CONTENSTS_VALUE_LIST=()
    local ALL_KEY_CON=""
    local SOURCE_CMD=""
    INI_CONTENTS="${ini_contents_moto}"
    make_ini_contents \
      "${ini_contents_moto}"
    [ ${SIGNAL_CODE} -eq ${EXIT_CODE} \
      -o ${SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ] \
    &&  EXEC_SET_VARIABLE_TYPE="${NO_EDIT_EXECUTE}" \
    && break \
    || e=$?
    local INI_VALUE=""
    SIGNAL_CODE=${EDIT_CODE}
    display_edit_contensts \
      "${EDIT_WINDOW_LOCATION}" 
    [ ${SIGNAL_CODE} -eq ${EXIT_CODE} \
      -o ${SIGNAL_CODE} -ge ${FORCE_EXIT_CODE} ] \
    &&  EXEC_SET_VARIABLE_TYPE="${NO_EDIT_EXECUTE}" \
    && break \
    || e=$?
    convert_input_value "${INI_VALUE}"
    check_ini_std_out "${INI_CONTENTS}"
    case "${SIGNAL_CODE}" in 
      "${CHECK_ERR_CODE}") ROOP_NUM=$(( ${ROOP_NUM} - 1 )); continue;;
      "${EDIT_FULL_CODE}") continue ;; esac
    case "${exec_edit_execute}" in 
      "${NO_EDIT_EXECUTE}") 
          CONFIRM=""
          confirm_edit_contensts "${INI_CONTENTS}" 
          ;;
      "${ONCE_EDIT_EXECUTE}"|"${ALWAYS_EDIT_EXECUTE}") CONFIRM=0 ;;
    esac
    #yad用入力値反映イニファイル内容を作成
    case "${CONFIRM}" in 
      "1") : ;;
      "0")  
          local ini_file_name_str=$(\
            echo -e "${INI_CONTENTS}" \
              | grep "${INI_CMD_FILE_NAME}="\
              | cut -d= -f2- \
              || e=$? \
          )
          test -z "${ini_file_name_str}" \
          && ini_file_name_str=$(\
            echo_removed_double_quote_both_ends "${EDIT_FILE_NAME}" \
          )
          local removed_file_name_double_quote_ends=$(\
            echo_removed_double_quote_both_ends \
              "${ini_file_name_str}" \
          )
          unset -v ini_file_name_str
          mv_ini_file_when_rename \
            "${removed_file_name_double_quote_ends}" \
            "${EDIT_FILE_NAME}" \
            "${INI_FILE_DIR_PATH}"
          mv_app_dir \
            "${CHDIR_SIGNAL_CODE}" \
            "${INI_CONTENTS}" \
            "${ch_dir_path_parameter_before}"
          local edit_output_path="${INI_FILE_DIR_PATH}/${removed_file_name_double_quote_ends}"
          unset -v removed_file_name_double_quote_ends
          echo "${INI_CONTENTS}" > "${edit_output_path}"
          touch "${edit_output_path}" &
          SIGNAL_CODE=$(\
            echo_signal_code_by_two_over_when_edit_execute \
            "${exec_edit_execute}"\
            "${ROOP_NUM}" \
          )
          break ;;
      *) break ;;
    esac
  done
}