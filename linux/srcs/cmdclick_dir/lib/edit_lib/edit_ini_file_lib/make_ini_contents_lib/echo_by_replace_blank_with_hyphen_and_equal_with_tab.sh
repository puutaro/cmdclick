#!/bin/bash


echo_by_replace_blank_with_hyphen_and_equal_with_tab(){
  local source_con="${1}"
  echo "${source_con}" \
    | sed -e '/^$/d' \
        -re 's/^([^=]*)\=$/\1=-/' \
    | sed -e 's/\=/\t/'
}