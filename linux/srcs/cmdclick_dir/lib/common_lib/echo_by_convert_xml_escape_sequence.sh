#!/bin/bash


echo_by_convert_xml_escape_sequence(){
	local target_contents="${1}"
	local LANG="ja_JP.UTF-8"
	echo ${target_contents} \
	| sed -re 's/([^a-zA-Z0-9_-])/\\\1/g' \
		-e 's/\&/\&amp;/g' \
	    -e 's/</\&lt;/g' \
	    -e 's/>/\&gt;/g' \
	    -e 's/"/\&quot;/g' \
	    -e "s/'/\&apos;/g"
}


echo_by_convert_xml_escape_sequence_new_line(){
	local LANG="ja_JP.UTF-8"
	local target_contents="${1}"
	echo "${target_contents}" \
	| sed -re 's/([^a-zA-Z0-9_-])/\\\1/g' \
		-e 's/\&/\&amp;/g' \
	    -e 's/</\&lt;/g' \
	    -e 's/>/\&gt;/g' \
	    -e 's/"/\&quot;/g' \
	    -e "s/'/\&apos;/g"
}