#!/bin/bash


echo_edited_ini_contents(){
	local ini_contents="${1}"
	local all_key_con="${2}"
	local ini_value="${3}"
	echo "${ini_contents}" \
      | awk \
      -v ini_value="${ini_value}" \
      -v all_key_con="${all_key_con}" \
      -v BTN_PARAMETERS="${BTN_PARAMETERS}" \
      -v INI_CMD_FILE_NAME=${INI_CMD_FILE_NAME} \
      'BEGIN {
        tn_para_len = split(BTN_PARAMETERS, BTN_PARAMETERS_LIST, "\n")
        ini_value_list_length = split(ini_value, ini_value_list, "\n")
        BTN_PARAMETERS_LIST_LENGTH = split(BTN_PARAMETERS, BTN_PARAMETERS_LIST, "\n")
        all_key_con_list_length = split(all_key_con, all_key_con_list, "\n")
        BTN_PARAMETERS = "\n"BTN_PARAMETERS"\n"
        count_ini_value_list_seed = 1
        count_all_key_con_seed = 1
        COUNT_BTN_PARAMETERS_LIST_SEED = 1
      }
      function add_suffix_to_ini_cmd_file(\
        ini_one_key, \
        ini_one_value, \
        cur_key \
      ){
          if(cur_key != INI_CMD_FILE_NAME){
            return ini_one_value
          }
          if(ini_one_value ~ "\\.sh$") {
            return ini_one_value 
          }
          return ini_one_value".sh"
      }
      function return_ini_one_value(\
        ini_one_key, \
        ini_one_value, \
        cur_key \
      ){
        if(\
          ini_one_value \
          && BTN_PARAMETERS ~ "\n"cur_key"=" \
        ) {
          COUNT_BTN_PARAMETERS_LIST_SEED++
          return "-"
        }
        if(ini_one_value){
          return add_suffix_to_ini_cmd_file(\
            ini_one_key, \
            ini_one_value, \
            cur_key \
          )
        }
        if(BTN_PARAMETERS !~ "\n"ini_one_key"="){
            return "-"
        }
        cur_bttn_pra = BTN_PARAMETERS_LIST[COUNT_BTN_PARAMETERS_LIST_SEED]
        cur_bttn_pra_value = substr(cur_bttn_pra, index(cur_bttn_pra, "=")+1, length(cur_bttn_pra))
        if(!cur_bttn_pra_value) cur_bttn_pra_value = "-"
        COUNT_BTN_PARAMETERS_LIST_SEED++
        return cur_bttn_pra_value

      }
      { 
        ini_one_key=all_key_con_list[count_all_key_con_seed]
        ini_one_value = ini_value_list[count_ini_value_list_seed]
        if($0 !~ "^"ini_one_key"="){
          print $0
          next
        }
        cur_key = $0
        gsub("=.*", "", cur_key)
        ini_one_value = return_ini_one_value(\
                          ini_one_key, \
                          ini_one_value, \
                          cur_key \
                        )
        gsub("^\x27-\x27$", "", ini_one_value)
        gsub("^\x22-\x22$", "", ini_one_value)
        gsub("^-$", "", ini_one_value)
        print ini_one_key"="ini_one_value
        count_all_key_con_seed++
        count_ini_value_list_seed++
      }
    '
}
