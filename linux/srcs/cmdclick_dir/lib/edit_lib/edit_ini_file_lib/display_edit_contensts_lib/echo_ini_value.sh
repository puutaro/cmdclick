#!/bin/bash


echo_ini_value(){
	local ini_value_source="${1}"
	awk \
      -v ini_value_source="${ini_value_source}" \
      'BEGIN {
        ini_value_source_list_len = split(\
          ini_value_source, \
          ini_value_source_list, \
          "\n"\
        )
        print ini_value_source_list[ini_value_source_list_len]
      }'
}