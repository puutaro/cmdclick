#!/bin/bash

convert_input_value(){
	#入力値を取得
	local ini_value=$(echo "${1}" | sed -re "s/(^ .*$)/\"\1/" -re "s/(^[^\"].* .*$)/\"\1/" -re "s/(^.* .*[^\"]$)/\1\"/"  -re "s/(.* $)/\1\"/" -e "s/^\"\"/\"/" -e "s/\"\"$/\"/")
  # echo "convert_input_value: ${ini_value}"
  # lecho "${ini_contents}"
  local set_key_value=$(paste -d '=' <(echo "${all_key_con}") <(echo "${ini_value}" | sed -r 's/([^a-zA-Z0-9_])/\\\1/g'))
  sed_set_key_value_con=$(echo "${set_key_value}" | sed -r "s/(^[a-zA-Z0-9_-]{1,100})\=(.*)/| sed \"s\/^\1\=.*\/\1=\2\/\"/")
  sed_set_key_value_con=$(echo ${sed_set_key_value_con} | tr -d '\n')
  # lecho ---
  # lecho "sed_set_key_value_con: ${sed_set_key_value_con}"
  ini_contents=$(eval "echo \"\${ini_contents}\" ${sed_set_key_value_con}" | sed -r "s/(^[a-zA-Z0-9_-]{1,100}=)-$/\1/")
  # lecho "ini_contents: ${ini_contents}"
}
