#!/bin/bash


echo_source_con_when_two_over_roop(){
  local ini_contents_set_default_value_in_parameter="${1}"
  echo "${ini_contents_set_default_value_in_parameter}" \
  | awk \
    -F '=' \
    -v INI_SETTING_DEFAULT_VALUE_CONS="${INI_SETTING_DEFAULT_VALUE_CONS}" \
    -v SEARCH_INI_SETTING_SECTION_START_NAME="${SEARCH_INI_SETTING_SECTION_START_NAME}" \
    -v SEARCH_INI_SETTING_SECTION_END_NAME="${SEARCH_INI_SETTING_SECTION_END_NAME}" \
    '
    BEGIN {
      count_ini_setting_section_start_name = 0
      count_ini_setting_section_end_name = 0
      ini_setting_default_value_cons_of["'${INI_TERMINAL_ON}'"] = "'${INI_TERMINAL_ON_DEFAULT_VALUE}'"
      ini_setting_default_value_cons_of["'${INI_OPEN_WHERE}'"] = "'${INI_OPEN_WHERE_DEFAULT_VALUE}'"
      ini_setting_default_value_cons_of["'${INI_TERMINAL_FOCUS}'"] = "'${INI_TERMINAL_FOCUS_DEFAULF_VALUE}'"
      ini_setting_default_value_cons_of["'${INI_EDIT_EXECUTE}'"] = "'${INI_EDIT_EXECUTE_DEFAULF_VALUE}'"
      multiple_ok_key_of["'${INI_SET_VARIABLE_TYPE}'"] = 1
    }
    {
      current_first_field_value = $1
      if(current_first_field_value == "") next
      if(current_first_field_value ~ SEARCH_INI_SETTING_SECTION_START_NAME) {
        count_ini_setting_section_start_name++
      }
      if(current_first_field_value ~ SEARCH_INI_SETTING_SECTION_END_NAME) {
        count_ini_setting_section_end_name++
      }

      if( \
        count_ini_setting_section_start_name == 0 \
        ) next

      if( \
        count_ini_setting_section_start_name == 1 \
        && count_ini_setting_section_end_name == 1 \
      ) next
      if(current_first_field_value ~ "[^a-zA-Z0-9:_-]") next
      if(\
        count_key_of[current_first_field_value] > 0 \
        && multiple_ok_key_of[current_first_field_value] <= 0 \
      ) next
      count_key_of[current_first_field_value]++
      if(INI_SETTING_DEFAULT_VALUE_CONS !~ current_first_field_value) next
      current_parameter_value = ini_setting_default_value_cons_of[current_first_field_value]
      if(current_parameter_value <= 0){
        printf current_first_field_value"="
        for(i=2;i<NF;++i){printf("%s=",$i)}print $NF
        next
      }
      current_value = $2
      if(current_value == "") next
      current_value_hat = "^"current_value"!"
      current_extra = "!"current_value
      success_bool = gsub(current_value_hat, "^"current_value"!", current_parameter_value)
      if(success_bool <= 0) gsub(current_extra, "!^"current_value, current_parameter_value)
      print current_first_field_value":CB="current_parameter_value
    }'
}

