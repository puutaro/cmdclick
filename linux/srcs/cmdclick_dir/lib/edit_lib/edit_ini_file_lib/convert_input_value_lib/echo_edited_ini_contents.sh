#!/bin/bash


echo_edited_ini_contents(){
	local ini_contents="${1}"
	local all_key_con="${2}"
	local ini_value="${3}"
	echo "${ini_contents}" \
      | awk \
      -v ini_value="${ini_value}" \
      -v all_key_con="${all_key_con}" \
      '
      { 
        ini_one_key=substr(all_key_con, 0, index(all_key_con, "\n"))
        if( ini_one_key == "") {
          ini_one_key = all_key_con
        }
        replace_ini_one_key=ini_one_key
        gsub("\n", "", ini_one_key)
        ini_one_value=substr(ini_value, 0, index(ini_value, "\n"))
        if( ini_one_value == "") {
          ini_one_value = ini_value
        }
        replace_ini_one_value=ini_one_value
        gsub("\n", "", ini_one_value)
        if($0 !~ "^"ini_one_key"="){
          print $0
          next
        }
        gsub("^\x27-\x27$", "", ini_one_value)
        gsub("^\x22-\x22$", "", ini_one_value)
        gsub("^-$", "", ini_one_value)
        print ini_one_key"="ini_one_value
        all_key_con=substr(all_key_con, index(all_key_con, "\n")+1, length(all_key_con))
        ini_value = substr(ini_value, index(ini_value, "\n")+1, length(ini_value))
      }
    '
}